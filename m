From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5 not recognizing manual umounts	properly
Date: Sun, 05 Nov 2006 17:48:37 +0800
Message-ID: <1162720118.13896.25.camel@localhost>
References: <10272992.2537671162323983680.JavaMail.servlet@kundenserver>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-H8Saj7u4y/F9lMJvtHnv"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <10272992.2537671162323983680.JavaMail.servlet@kundenserver>
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
To: twendt@online.de
Cc: autofs@linux.kernel.org


--=-H8Saj7u4y/F9lMJvtHnv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-10-31 at 20:46 +0100, twendt@online.de wrote:
> >On Sat, 2006-10-28 at 18:41 +0200, Timo Wendt wrote:
> >> Hi,
> >> 
> >> 
> >> I have just installed FC6 to do some tests with autofs 5 as I need to
> >> use direct mounts. The new version works really great. The only thing
> >> I figured out so far that does not work fine is, when I umount one of
> >> the automounted fs manually.
> >> If I then try to list the contents of that directory it says, that it
> >> is empty. As soon as I try to create a file in that directory, it
> >> fails and seems to realize, that the directory should be mounted and
> >> remounts it, without creating the file though.
> >
> >And what kernel are you using?
> >And the version of autofs?
> >
> >Ian
> >
> >
> Hi,
> 
> sorry for the delay I didn't get to check this yesterday.
> 
> I have the following maps:
> 
> /etc/auto.master:
> 
> /- /etc/auto.direct
> 
> /etc/auto.direct:
> 
> /home/timo      192.168.178.187:/mnt
> 
> The IP is actually the local IP, therefore I get bind mounts instead of NFS mounts.
> 
> Here is what I am doing:
> 
> [root@localhost autofs-5.0.1]# mount
> /dev/mapper/vg00-lvroot on / type ext3 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda5 on /boot type ext3 (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> nfsd on /proc/fs/nfsd type nfsd (rw)
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> -rw-r--r-- 1 root root 0 Oct 27 20:09 a
> 
> [root@localhost autofs-5.0.1]# umount /mnt
> 
> [root@localhost autofs-5.0.1]# mount
> /dev/mapper/vg00-lvroot on / type ext3 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda5 on /boot type ext3 (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> nfsd on /proc/fs/nfsd type nfsd (rw)
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> 
> [root@localhost autofs-5.0.1]# touch /home/timo/b
> touch: cannot touch `/home/timo/b': Permission denied
> 
> [root@localhost autofs-5.0.1]# mount
> /dev/mapper/vg00-lvroot on / type ext3 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> /dev/hda5 on /boot type ext3 (rw)
> tmpfs on /dev/shm type tmpfs (rw)
> /dev/mapper/vg00-lvxen on /xen_domains type ext3 (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> nfsd on /proc/fs/nfsd type nfsd (rw)
> /mnt on /home/timo type none (rw,bind)
> 
> [root@localhost autofs-5.0.1]# ll /home/timo
> total 0
> -rw-r--r-- 1 root root 0 Oct 27 20:09 a
> 

There are three kernel patches that resulted from testing that aren't
present in the FC6 kernel. They are working their way through the rc
process for 2.6.19 at the moment. I've attached them.

I think that the autofs4-2.6.18-rc4-mm1-follow_link-false-negative.patch
patch resolves this issue. This patch allows autofs4 to recognize a
direct mount trigger as a mount point even if it has remnant dentrys
(basically stale or never instantiated directories). I'm a little
surprised as I didn't think this was a case where remnant dentrys are
created and I can't see where it happens in the log. The other two
patches address quite different issues.

Additionally, I noticed that the manual umount can lead to a file handle
leak and the patch 
autofs-5.0.1-rc2-check-fh-on-mount-trigger.patch should fix that.

I haven't tested this last patch yet apart from that it compiles.

I must reiterate that manually umounting mounts is not recommended
although it should be fine for simple indirect and direct mounts.
Multi-mounts are another matter altogether. If you know the autofs
internals of how they work, manually umounting such a tree (including
the internal autofs trigger mounts) in the correct order may work but
you could easily get yourself into the situation where entries won't
mount or expire, which would require a restart to fix.

Ian


--=-H8Saj7u4y/F9lMJvtHnv
Content-Disposition: attachment;
	filename=autofs4-2.6.18-rc4-mm1-follow_link-false-negative.patch
Content-Type: text/x-patch;
	name=autofs4-2.6.18-rc4-mm1-follow_link-false-negative.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.18-rc4-mm1/fs/autofs4/root.c.follow_link-false-negative	2006-08-14 10:13:59.000000000 +0800
+++ linux-2.6.18-rc4-mm1/fs/autofs4/root.c	2006-08-14 10:15:26.000000000 +0800
@@ -359,7 +359,7 @@ static void *autofs4_follow_link(struct 
 	 * don't try to mount it again.
 	 */
 	spin_lock(&dcache_lock);
-	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
+	if (!d_mountpoint(dentry) && __simple_empty(dentry)) {
 		spin_unlock(&dcache_lock);
 
 		status = try_to_fill_dentry(dentry, 0);

--=-H8Saj7u4y/F9lMJvtHnv
Content-Disposition: attachment;
	filename=autofs4-2.6.18-rc4-mm2-clear-pending.patch
Content-Type: text/x-patch; name=autofs4-2.6.18-rc4-mm2-clear-pending.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.18-rc4-mm2/fs/autofs4/root.c.clear-pending	2006-08-20 13:20:23.000000000 +0800
+++ linux-2.6.18-rc4-mm2/fs/autofs4/root.c	2006-08-20 13:21:30.000000000 +0800
@@ -281,9 +281,6 @@ static int try_to_fill_dentry(struct den
 
 		DPRINTK("mount done status=%d", status);
 
-		if (status && dentry->d_inode)
-			return status; /* Try to get the kernel to invalidate this dentry */
-
 		/* Turn this into a real negative dentry? */
 		if (status == -ENOENT) {
 			spin_lock(&dentry->d_lock);
@@ -540,6 +537,9 @@ static struct dentry *autofs4_lookup(str
 			    return ERR_PTR(-ERESTARTNOINTR);
 			}
 		}
+		spin_lock(&dentry->d_lock);
+		dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
+		spin_unlock(&dentry->d_lock);
 	}
 
 	/*

--=-H8Saj7u4y/F9lMJvtHnv
Content-Disposition: attachment;
	filename=autofs4-2.6.18-rc6-mm2-zero-timeout.txt
Content-Type: text/plain; name=autofs4-2.6.18-rc6-mm2-zero-timeout.txt;
	charset=utf-8
Content-Transfer-Encoding: 7bit


If the timeout of an autofs mount is set to zero then umounts
are disabled. This works fine, however the kernel module checks
the expire timeout and goes no further if it is zero. This is
not the right thing to do at shutdown as the module is passed
an option to expire mounts regardless of their timeout setting.

This patch allows autofs to honor the force expire option.

Signed-off-by: Ian Kent <raven@themaw.net>

---

--- linux-2.6.18-rc6-mm2/fs/autofs4/expire.c.zero-timeout	2006-09-14 10:25:55.000000000 +0800
+++ linux-2.6.18-rc6-mm2/fs/autofs4/expire.c	2006-09-14 10:37:54.000000000 +0800
@@ -32,7 +32,7 @@ static inline int autofs4_can_expire(str
 
 	if (!do_now) {
 		/* Too young to die */
-		if (time_after(ino->last_used + timeout, now))
+		if (!timeout || time_after(ino->last_used + timeout, now))
 			return 0;
 
 		/* update last_used here :-
@@ -253,7 +253,7 @@ static struct dentry *autofs4_expire_dir
 	struct dentry *root = dget(sb->s_root);
 	int do_now = how & AUTOFS_EXP_IMMEDIATE;
 
-	if (!sbi->exp_timeout || !root)
+	if (!root)
 		return NULL;
 
 	now = jiffies;
@@ -293,7 +293,7 @@ static struct dentry *autofs4_expire_ind
 	int do_now = how & AUTOFS_EXP_IMMEDIATE;
 	int exp_leaves = how & AUTOFS_EXP_LEAVES;
 
-	if ( !sbi->exp_timeout || !root )
+	if (!root)
 		return NULL;
 
 	now = jiffies;

--=-H8Saj7u4y/F9lMJvtHnv
Content-Disposition: attachment;
	filename=autofs-5.0.1-rc2-check-fh-on-mount-trigger.patch
Content-Type: text/x-patch;
	name=autofs-5.0.1-rc2-check-fh-on-mount-trigger.patch;
	charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/daemon/direct.c b/daemon/direct.c
index c92a745..f75ce2d 100644
--- a/daemon/direct.c
+++ b/daemon/direct.c
@@ -1392,8 +1392,14 @@ int handle_packet_missing_direct(struct 
 		return 1;
 	}
 
-	ioctlfd = open(me->key, O_RDONLY);
-	if (ioctlfd < 0) {
+	if (me->ioctlfd != -1) {
+		/* Maybe someone did a manual umount, clean up ! */
+		ioctlfd = me->ioctlfd;
+		me->ioctlfd = -1;
+	} else
+		ioctlfd = open(me->key, O_RDONLY);
+
+	if (ioctlfd == -1) {
 		cache_unlock(mc);
 		pthread_setcancelstate(state, NULL);
 		crit(ap->logopt, "failed to create ioctl fd for %s", me->key);

--=-H8Saj7u4y/F9lMJvtHnv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-H8Saj7u4y/F9lMJvtHnv--

