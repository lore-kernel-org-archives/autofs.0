From: Oscar Salvador <osalvador@suse.com>
Subject: Re: [PATCH] Test for ldap connectivity during lookup_ldap
 initialization
Date: Thu, 17 Aug 2017 11:48:42 +0200
Message-ID: <cd8f1b58-e8e5-84d0-f7ef-43df2a49cb31@suse.com>
References: <1502399721-2491-1-git-send-email-osalvador@suse.com>
 <a1205319-aa1f-13c4-51c6-740ac6d15a4c@themaw.net>
 <b93d61bf-ebea-1dd4-9618-f365a6b80727@themaw.net>
 <51c1d96b-ff3d-1024-5a91-06a85fd49e03@suse.com>
 <afeda808-2e60-5194-70d8-fb1d503d416b@themaw.net>
 <17211d66-5e65-f83b-790e-e2f3275d17ff@themaw.net>
 <252354c4-8647-e46e-321e-9b304731310d@themaw.net>
 <7502a0e9-6288-ed45-8225-706944a65d7c@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <7502a0e9-6288-ed45-8225-706944a65d7c@themaw.net>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org



On 08/16/2017 12:00 PM, Ian Kent wrote:
> On 16/08/17 17:43, Ian Kent wrote:
>> On 16/08/17 17:39, Ian Kent wrote:
>>>
>>> Could you have a look at:
>>> autofs-5.1.2-wait-for-master-map-available-at-start.patch
>>> autofs-5.1.2-add-master-read-wait-option.patch
>>> autofs-5.1.2-work-around-sss-startup-delay.patch
>>> autofs-5.1.2-add-sss-master-map-wait-config-option.patch
>>> autofs-5.1.2-fix-included-master-map-not-found-return.patch
>>> autofs-5.1.2-dont-fail-on-master-map-read-fail-timeout.patch
>>> autofs-5.1.2-set-sane-default-master-read-wait-timeout.patch
>>> autofs-5.1.2-dont-return-until-after-master-map-retry-read.patch
>>> autofs-5.1.2-make-lookup_nss_read_master-return-nss-status.patch
>>>
>>> found at https://www.kernel.org/pub/linux/daemons/autofs/v5/patches-5.1.3/.
> 
> And there's this one too.
> autofs-5.1.2-fix-work-around-sss-startup-delay.patch


I can reproduce this with the latest version of autofs from git.

My setup is quite simple:

# git clone https://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git
# ./configure && make && make install

# vim /etc/auto.master
/- auto.host
+auto.master

# vim /etc/auto.host
/data1  xx.xx.xx.xx:/mnt/export1
/data2  xx.xx.xx.xx:/mnt/export2
/data3	xx.xx.xx.xx:/mnt/export3

# grep autom /etc/nsswitch.conf
automount:	files ldap


# automount -d -v -f

# output of mounts (other terminal)
auto.host on /data3 type autofs 
(rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
auto.host on /data2 type autofs 
(rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)
auto.host on /data1 type autofs 
(rw,relatime,fd=7,pgrp=29843,timeout=300,minproto=5,maxproto=5,direct)


# comment one mount in /etc/auto.host
# kill -HUP $(pidof automount)


Outcome:


do_hup_signal() -> do_read_master()[readall = 1] -> master_read_master()

in master_read_master we set master->read_fail to 0 again and we call 
master_mount_mounts()


master_mount_mounts () -> check_update_map_sources()

in check_update_map_sources() we set map_stale and source->stale to 1:

	if (readall)
                 map_stale = 1;

	...
	...

	while (source) {
                 if (readall)
                         source->stale = 1;
		...
	}


Then we add a new task to re-read the map:

	if (map_stale)
                 st_add_task(ap, ST_READMAP);


st_readmap() -> do_readmap() -> lookup_nss_read_map()


Within lookup_nss_read_map(), we call read_map_source():

	list_for_each(p, head) {
                  this = list_entry(p, struct nss_source, list);
                   ...
                   ...
                   result = read_map_source(this, ap, map, age);
                   ...
          }

read_map_source() is being called for "files" and "ldap"

in the case with "files" everything goes fine, and back to 
lookup_nss_read_map() we set at_least_one to 1

	if(result == NSS_STATUS_SUCCESS) {
		at_least_one = 1;
		result = NSS_STATUS_TRYAGAIN;
	}


in the case with "ldap":

read_map_source()-> read_source_instance() -> do_read_map() -> open_lookup()

since open_lookup() for ldaps succeeds, we move on, and we call:

status = lookup->lookup_read_map(ap, age, lookup->context);


lookup->lookup_read_map() returns NSS_STATUS_UNAVAIL and we set 
map->stale to 0:

	if (status != NSS_STATUS_SUCCESS)
                 map->stale = 0;


	
back to lookup_nss_read_map(), since result was NSS_STATUS_UNAVAIL, we 
set map->stale = 0 again


	if (result == NSS_STATUS_UNAVAIL)
		map->stale = 0;


back in do_readmap() we check if the map got stale or not, and in case 
it got, we do a readmap again:


	while (map) {
		if (!map->stale) {
			map = map->next;
			continue;
		}

		...
		...
		while (me) {
			do_readmap_mount(ap, mnts, map, me, now);
			me = cache_enumerate(mc, me);
		}
	}


but since we zeroed map->stale before, we bypass it and we don't do that.
Another fixup that doesn't not imply messing with return values of 
open_lookup() from ldap module could be this one:


diff --git a/daemon/lookup.c b/daemon/lookup.c
index 583d3d3..82f3a58 100644
--- a/daemon/lookup.c
+++ b/daemon/lookup.c
@@ -550,6 +550,7 @@ int lookup_nss_read_map(struct autofs_point *ap, 
struct map_source *source, time
         struct map_source *map;
         enum nsswitch_status status;
         unsigned int at_least_one = 0;
+       unsigned int old_stale_val;
         int result = 0;

         /*
@@ -615,6 +616,7 @@ int lookup_nss_read_map(struct autofs_point *ap, 
struct map_source *source, time

                 pthread_cleanup_push(nsslist_cleanup, &nsslist);
                 head = &nsslist;
+               old_stale_val = map->stale;
                 list_for_each(p, head) {
                         this = list_entry(p, struct nss_source, list);

@@ -654,6 +656,9 @@ int lookup_nss_read_map(struct autofs_point *ap, 
struct map_source *source, time
                 if (!map)
                         break;

+               if (at_least_one)
+                       map->stale = old_stale_val;
+
                 map = map->next;
         }


I tested it and works for me.


So in case that we succeed at least with one lookup method, we put back 
the original stale value (that gets zeroed in do_read_map() if 
lookup->lookup_read_map() returns something different than 
NSS_STATUS_SUCCESS)

In this case we don't skip the map in do_readmap()


         while (map) {
                 if (!map->stale) {			<-- here
                         map = map->next;
                         continue;
                 }

                 ...
                 ...
                 while (me) {
                         do_readmap_mount(ap, mnts, map, me, now);
                         me = cache_enumerate(mc, me);
                 }
         }


Thanks
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
