From: Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Wed, 16 Aug 2017 09:21:39 +0200
Message-ID: <51c1d96b-ff3d-1024-5a91-06a85fd49e03@suse.com>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
 <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org



On 08/16/2017 07:46 AM, Ian Kent wrote:
> On 16/08/17 13:02, Ian Kent wrote:
>> On 11/08/17 05:15, Oscar Salvador wrote:
>>> Right now we are just checking and parsing the ldap's configuration
>>> in lookup_init() function, and if everything goes well we return a zero
>>> value indicating that everything worked fine.
>>>
>>> This has a problem, because in the case we set ldap method in
>>> /etc/nsswitch.conf, configuration parsing goes fine but ldap is not working,
>>> we will return a zero value in lookup_init() function, so autofs will move on,
>>> but then we will return NSS_STATUS_UNAVAIL in lookup_read_master() function
>>> once do_reconnect() fails, and because of this autofs will not be able to
>>> reread the maps.
>>
>> Umm ... I can't see a check in the current upstream NIS code?
> 
> I also don't understand the problem in the upstream code your trying to
> resolve. Can you try and describe it again please?


Sure, I'm going to try to explain it, hopefully better:

Let's say we set "files" and "nis" method in /etc/nsswitch.conf, just 
like this:

# grep auto /etc/nsswitch.conf
automount:	files nis


And then let's say we have this configuration:

# grep -v '^#' /etc/auto.master
/- auto.host
+auto.master

# cat /etc/auto.host
/data1  xx.xx.xx.xx:/mnt/export1
/data2  xx.xx.xx.xx:/mnt/export2
/data3	xx.xx.xx.xx:/mnt/export3


Once we start autofs, we should have the mounts:

auto.host on /data3 type autofs 
(rw,relatime,fd=7,pgrp=2128,timeout=300,minproto=5,maxproto=5,direct)
auto.host on /data2 type autofs 
(rw,relatime,fd=7,pgrp=2128,timeout=300,minproto=5,maxproto=5,direct)
auto.host on /data1 type autofs 
(rw,relatime,fd=7,pgrp=2128,timeout=300,minproto=5,maxproto=5,direct)


Then, let's say we want to remove one mount, so we comment one of the 
mounts in /etc/auto.host, and then we send the
-HUP signal to the autofs process.

The result of signaling autofs -HUP is that it re-reads the config.

So, we call:

lookup_nss_read_master() -> do_read_master() -> open_lookup() ->

fails?
      |->yes: return NSS_STATUS_NOTFOUND
      |-> no: lookup->lookup_read_master()


The point of open_lookup() is to try to initialize the library by 
calling mod->lookup_init() (nis, ldap, ...),
and in case it fails, we return NSS_STATUS_NOTFOUND, and 
do_read_master() returns NSS_STATUS_NOTFOUND too.

This is possible because in lookup_init() for lookup_yp.c we check if we 
are bound to a domain:

	if (!ctxt->domainname) {
                 char *domainname;
                 /* This should, but doesn't, take a const char ** */
                 err = yp_get_default_domain(&domainname);
                 if (err) {
                         logerr(MODPREFIX
                               "map %s: %s", ctxt->mapname, 
yperr_string(err));
                         ret = 1;
                         goto out;
                 }
		...
		...
	}


In my case it fails because I'm not bound to any nis domain, so since 
mod->lookup_init() fails,
open_lookup() returns NSS_STATUS_NOTFOUND and we just return instead of 
moving on.



Now, this doesn't work for ldap.
If we replace "nis" for "ldap" in /etc/nsswitch.conf, like:

# grep auto /etc/nsswitch.conf
automount:	files ldap


And then we comment one mount and try to reload autofs with HUP signal, 
the process is going to be different.

The point with ldap is that we don't really check if the configuration 
for ldap works or not, we just try to initialize it,
but we don't check if we can connect to the ldap server and do a bind 
operation, so even if our ldap is broken lookup_init()
from ldap is going to return success, letting us move on and call 
lookup->lookup_read_master(), which is going to fail hard
in the first call to do_reconnect() in lookup_read_master() function.

The problem with this is that there is a big difference in failing in 
open_lookup() or failing in lookup->lookup_read_master(),
and that's it if we return NSS_STATUS_NOTFOUND or NSS_STATUS_UNAVAIL.
In case we return the last one, lookup_nss_read_master() is going to do:

	if (result == NSS_STATUS_UNAVAIL)
		master->read_fail = 1;

and this will not let autofs re-read its configuration and remove the 
mounts we commented.


Given that said, what I wanted to achieve with my patch is to really 
check if we got a working ldap setup
by trying to call do_reconnect() in do_init(), because it tries to 
connect to the ldap server found in the
config and do a bind operation, which should be enough to test if our 
ldap works or not.

In my case, without the patch, if I try to reload the autofs config with 
the -HUP signal, autofs won't do it.
With the patch, since I return NSS_STATUS_NOTFOUND if lookup_init() 
fails, autofs is able to re-read the config.

I hope I was able to explain it better this time.

This being said, I'm not sure if we way I chose to fix this is the best one.


Thanks
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
