From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Segfault on lookups with wildcards
Date: Thu, 4 Mar 2010 18:23:10 -0300
Message-ID: <20100304212310.GA16319@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:received:received:date:from:to:subject
	:message-id:mime-version:content-type:content-disposition:user-agent;
	bh=3s9+5WBgwBropuwnKScrrylUYcFts6NAatKqg3L1UHI=;
	b=dzMHB65t4rwKgwYL93QnJrfSzjApLuVXZVqeL/0ELTdj39+o46/W9T0WjQXf+j9GBL
	I1qXqg1gghdu9DYntjOUvlmLrT5WohNSLhKnvEbowFZArsd+AicZQkp/+CPq0s/8InfN
	UvXOYNJSOZvu+Pjz5htMmUWKXQmgVDXW7pmFs=
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

There is a problem in AutoFS (5.0.5 plus all patches released so far)
related to negative caching of keys that start with an '*'.

How to reproduce:

# cat /etc/auto.master
/nfs	/etc/auto.nfs

# cat /etc/auto.nfs
*	-ro,hard,intr,nolock 10.1.1.4:/export/&

# stat '/nfs/*foo'

Automount will segfault (please see logs attached) in lookup_mount()
(lookup_file.c:1075):

1074				me = cache_lookup_distinct(mc, key);
1075				me->status = now + ap->negative_timeout;

(gdb) print me
$1 = (struct mapent *) 0x0

Here's the call trace for reference:

#0  0x00007fc74e22c423 in lookup_mount (ap=<value optimized out>,
name=<value optimized out>, name_len=<value optimized out>,
context=<value optimized out>)
    at lookup_file.c:1075
#1  0x00007fc74fdbd065 in lookup_name_file_source_instance
(ap=0x7fc74ffffc00, map=0x7fc74ffffd10, name=0x7fc74fd60ea0 "*foo",
name_len=4) at lookup.c:707
#2  0x00007fc74fdbd958 in lookup_nss_mount (ap=0x7fc74ffffc00,
source=0x0, name=0x7fc74fd60ea0 "*foo", name_len=4) at lookup.c:894
#3  0x00007fc74fdb3d76 in do_mount_indirect (arg=0x7fc74ffffc00) at
indirect.c:813
#4  0x00007fc74f416a3f in start_thread (arg=0x7fc74fd63710) at
pthread_create.c:297
#5  0x00007fc74f180ecd in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:112
#6  0x0000000000000000 in ?? ()

If I understand correctly, the code assumes that "me" will never be
NULL because cache_update() was called a couple of lines above to insert
the key into the cache.

The problem is that cache_update() won't add the key into the cache
if it starts with an '*', as we can see in lib/cache.c:1067:

	me = cache_lookup(mc, key);
	while (me && me->source != ms)
		me = cache_lookup_key_next(me);
	if (!me || (*me->key == '*' && *key != '*')) {	<===
		ret = cache_add(mc, ms, key, mapent, age);

I verified that a patch like this will fix the problem:

Index: autofs-5.0.5/lib/cache.c
===================================================================
--- autofs-5.0.5.orig/lib/cache.c
+++ autofs-5.0.5/lib/cache.c
@@ -719,7 +719,7 @@ int cache_update(struct mapent_cache *mc
 	me = cache_lookup(mc, key);
 	while (me && me->source != ms)
 		me = cache_lookup_key_next(me);
-	if (!me || (*me->key == '*' && *key != '*')) {
+	if (!me || (*me->key == '*' && (strcmp(key, "*") != 0))) {
 		ret = cache_add(mc, ms, key, mapent, age);
 		if (!ret) {
 			debug(logopt, "failed for %s", key);


However, I'm not sure if it is correct. The test "*key == '*'" appears
in other functions, so I was wondering if it's a good idea to add keys
with wildcards into the cache after all.

Thanks!
Leonardo

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log-autofs.txt"

Mar  4 17:40:37 n30 automount[18528]: Starting automounter version 5.0.5, master map auto.master
Mar  4 17:40:37 n30 automount[18528]: using kernel protocol version 5.01
Mar  4 17:40:37 n30 automount[18528]: lookup_nss_read_master: reading master files auto.master
Mar  4 17:40:37 n30 automount[18528]: parse_init: parse(sun): init gathered global options: (null)
Mar  4 17:40:37 n30 automount[18528]: lookup_read_master: lookup(file): read entry /nfs
Mar  4 17:40:37 n30 automount[18528]: master_do_mount: mounting /nfs
Mar  4 17:40:37 n30 automount[18528]: automount_path_to_fifo: fifo name /var/run/autofs.fifo-nfs
Mar  4 17:40:37 n30 automount[18528]: lookup_nss_read_map: reading map file /etc/auto.nfs
Mar  4 17:40:37 n30 automount[18528]: parse_init: parse(sun): init gathered global options: (null)
Mar  4 17:40:37 n30 automount[18528]: remount_active_mount: trying to re-connect to mount /nfs
Mar  4 17:40:37 n30 automount[18528]: mounted indirect on /nfs with timeout 600, freq 150 seconds
Mar  4 17:40:37 n30 automount[18528]: remount_active_mount: re-connected to mount /nfs
Mar  4 17:40:37 n30 automount[18528]: st_ready: st_ready(): state = 0 path /nfs
Mar  4 17:40:37 n30 automount[18528]: ghosting enabled
Mar  4 17:41:02 n30 automount[18528]: handle_packet: type = 3
Mar  4 17:41:02 n30 automount[18528]: handle_packet_missing_indirect: token 77, name *foo, request pid 18539
Mar  4 17:41:02 n30 automount[18528]: attempting to mount entry /nfs/*foo
Mar  4 17:41:02 n30 automount[18528]: lookup_mount: lookup(file): looking up *foo
Mar  4 17:41:02 n30 automount[18528]: lookup_mount: lookup(file): *foo -> -ro,hard,intr,nolock 10.1.1.4:/export/&
Mar  4 17:41:02 n30 automount[18528]: parse_mount: parse(sun): expanded entry: -ro,hard,intr,nolock 10.1.1.4:/export/*foo
Mar  4 17:41:02 n30 automount[18528]: parse_mount: parse(sun): gathered options: ro,hard,intr,nolock
Mar  4 17:41:02 n30 automount[18528]: parse_mount: parse(sun): dequote("10.1.1.4:/export/*foo") -> 10.1.1.4:/export/*foo
Mar  4 17:41:02 n30 automount[18528]: parse_mount: parse(sun): core of entry: options=ro,hard,intr,nolock, loc=10.1.1.4:/export/*foo
Mar  4 17:41:02 n30 automount[18528]: sun_mount: parse(sun): mounting root /nfs, mountpoint *foo, what 10.1.1.4:/export/*foo, fstype nfs, options ro,hard,intr,nolock
Mar  4 17:41:02 n30 automount[18528]: mount_mount: mount(nfs): root=/nfs name=*foo what=10.1.1.4:/export/*foo, fstype=nfs, options=ro,hard,intr,nolock
Mar  4 17:41:02 n30 automount[18528]: mount_mount: mount(nfs): nfs options="ro,hard,intr,nolock", nosymlink=0, ro=1
Mar  4 17:41:02 n30 automount[18528]: mount_mount: mount(nfs): calling mkdir_path /nfs/*foo
Mar  4 17:41:02 n30 automount[18528]: mount_mount: mount(nfs): calling mount -t nfs -s -o ro,hard,intr,nolock 10.1.1.4:/export/*foo /nfs/*foo
Mar  4 17:41:02 n30 automount[18528]: >> mount.nfs: access denied by server while mounting 10.1.1.4:/export/*foo
Mar  4 17:41:02 n30 automount[18528]: mount(nfs): nfs: mount failure 10.1.1.4:/export/*foo on /nfs/*foo
Mar  4 17:41:02 n30 kernel: [37406.116873] automount[18540]: segfault at 98 ip 00007fc74e22c423 sp 00007fc74fd5f830 error 6 in lookup_file.so[7fc74e224000+1c000]

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Q68bSM7Ycu6FN28Q--

