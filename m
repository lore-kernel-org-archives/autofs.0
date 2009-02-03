From: Michael Loftis <mloftis@wgops.com>
Subject: Re: AutoFS Race Conditions?  Negative Cache?
Date: Mon, 02 Feb 2009 18:05:15 -0700
Message-ID: <587B15FCE26A5069952E314B@ZOP-MACTEL.local>
References: <F76FAA9B4E7600AAC1FFA15B@ZOP-MACTEL.local>	
	<1233113406.3005.21.camel@zeus.themaw.net>	
	<E53DDD7AD6715F60A879D415@ZOP-MACTEL.local>
	<1233621955.2951.18.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1233621955.2951.18.camel@zeus.themaw.net>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org



--On February 3, 2009 9:45:55 AM +0900 Ian Kent <raven@themaw.net> wrote:

>> I understand that.  I'm having trouble reproducing this one except under
>> load, which is why I decided it's probably some sort of race condition.
>> And it goes away when i set timeout=0.  I'm betting though that with
>> 'current' autofs4 module it may not happen or with 'current' daemon and
>> module. I tried to get autofs5 debian package from sid/lenny (debian
>> unstable/testing) to compile but because it's using some symbols that
>> don't  exist in ldap.h from openldap 2.1 it won't compile for Debian 4.0
>> without a  little bit of massaging.
>
> What are the symbols?
> Send over the compile breakage output or the Debian source package (I
> can probably check it out on my Ubuntu test machine).

Using the autofs5 package from sid and after a few minor massages to get 
the debhelper stuff into compliance with the older etch dh tools (5.0.3 
base, but same errors are present in 5.0.4, same undef-ed symbol) 
LDAP_CONTROL_PAGEDRESULTS seems to have appeared somewhere eitehr in 
OpenLDAP 2.2 or in 2.1 after debians libldap2-dev  2.1.30-13.3 packages.

gcc -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include -I../lib 
-fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
-DAUTOFS_MAP_DIR=\"/etc\" -DLDAP_DEPRECATED=1  -I/usr/include/libxml2 
-DLDAP_THREAD_SAFE -c cyrus-sasl.c
gcc -shared -O2 -Wall -D_REENTRANT -D_FILE_OFFSET_BITS=64 -I../include 
-I../lib -fPIC -D_GNU_SOURCE -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
-DAUTOFS_MAP_DIR=\"/etc\" -DLDAP_DEPRECATED=1  -I/usr/include/libxml2 
-DLDAP_THREAD_SAFE -o lookup_ldap.so \
		lookup_ldap.c cyrus-sasl.o ../lib/autofs.a -lldap -llber -lresolv -lsasl2 
-L/usr/lib -lxml2 -lcrypto -lkrb5
lookup_ldap.c: In function 'ldap_create_page_control':
lookup_ldap.c:88: error: 'LDAP_CONTROL_PAGEDRESULTS' undeclared (first use 
in this function)
lookup_ldap.c:88: error: (Each undeclared identifier is reported only once
lookup_ldap.c:88: error: for each function it appears in.)
lookup_ldap.c: In function 'ldap_parse_page_control':
lookup_ldap.c:103: error: 'LDAP_CONTROL_PAGEDRESULTS' undeclared (first use 
in this function)
make[2]: *** [lookup_ldap.so] Error 1
make[2]: Leaving directory `/home/mloftis/dev/autofs/autofs5-5.0.3/modules'
make[1]: *** [daemon] Error 2
make[1]: Leaving directory `/home/mloftis/dev/autofs/autofs5-5.0.3'
make: *** [build.stamp] Error 2


>
>>
>> Another problem I ran into was that there's no way to pass the -n flag
>> to  mount.  I'm probably going to have to make my own autofs4 daemon
>> packages,  but is this a feature of autofs5 daemon?  The reason I ask is
>> the  webservers here well, linking /proc/mounts to /etc/mtab is bad for
>> the same  reason, ls takes a few seconds (as do many other things) to
>> execute when  there's 12k+ mounts in /etc/mtab (that might be less if we
>> can get  timeout's to work but as we don't have any profiles on
>> this...).  We'd need  this long term for both nfs and bind mounts.  It
>> doesn't appear that it's  an option in autofs5 either as the call ends
>> up being :: err = spawn_bind_mount(ap->logopt, SLOPPYOPT "-o", options,
>>                              what, fullpath, NULL);
>
> Right, have a look at 5.0.4, those functions will check if /etc/mtab is
> a link to /proc/mounts and add "-n" to the mount options if it is. I try
> my best to keep all the individual patches for each version update (at
> least through the v5 updates) and often they are straight forward to
> backport.
>
> It's true that there are still bugs in v5, even after more than two
> years working at it, but as far as I can tell, people generally feel
> that v5 is much better than v4.

Yeah doing a symlink still has the same problem for us.  ls does 
'something' that reads /etc/mtab.  With our current script which walks our 
NFS tree and calls mount -n --bind everything is good, so for us we just 
need to be able to pass -n because we need a short /etc/mtab.  -- /root is 
local btw...  and if you strace you can see it walking through /etc/mtab. 
Other utils, like df too.  Granted once we can get timeouts working they'll 
be a lot shorter but the delay will still be significant.  Right now it's 
carrying ~6k mounts from the old system and the active mounts from the 
autofs based stuff (again it's not unmounting right now because turning 
that on caused it to become completely unstable)  No symlinks in either, 
just a few misc files (excluded from here though).

web6:~# pwd
/root
web6:~# time ls
...

real	0m2.051s
user	0m0.016s
sys	0m1.960s
web6:~# wc -l /proc/mounts
15799 /proc/mounts

web5:~# pwd
/root
web5:~# time ls
...

real	0m0.028s
user	0m0.000s
sys	0m0.028s
web5:~# wc -l /proc/mounts
5668 /proc/mounts


-- 
"Genius might be described as a supreme capacity for getting its possessors
into trouble of all kinds."
-- Samuel Butler
