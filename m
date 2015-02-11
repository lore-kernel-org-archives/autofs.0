From: Ian Kent <ikent@redhat.com>
Subject: Re: sloppy mount option not handled by some filesystems.
Date: Wed, 11 Feb 2015 19:15:13 +0800
Message-ID: <1423653313.2599.37.camel@pluto.fritz.box>
References: <CAJfpegsPezK7-MY7F+re7N4N564OyzKVPsmOa-zSWGSpuP7W_A@mail.gmail.com>
	 <1422401769.2654.29.camel@pluto.fritz.box>
	 <CAJfpegvkCRbpTCTOvOpdw0F167SvrzVRnCtGJGxUQ9hdoYS3pw@mail.gmail.com>
	 <1423651936.2599.32.camel@pluto.fritz.box>
	 <1423652197.2599.33.camel@pluto.fritz.box>
	 <CAJfpegvt7ArFWV6+6gzJA2QT+-DC+t5x9Op3R=OBO-bNfHFreA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <CAJfpegvt7ArFWV6+6gzJA2QT+-DC+t5x9Op3R=OBO-bNfHFreA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: autofs@vger.kernel.org, lchiquitto@suse.com

On Wed, 2015-02-11 at 12:03 +0100, Miklos Szeredi wrote:
> On Wed, Feb 11, 2015 at 11:56 AM, Ian Kent <ikent@redhat.com> wrote:
> > On Wed, 2015-02-11 at 18:52 +0800, Ian Kent wrote:
> >> On Wed, 2015-02-11 at 11:11 +0100, Miklos Szeredi wrote:
> >> > On Wed, Jan 28, 2015 at 12:36 AM, Ian Kent <ikent@redhat.com> wrote:
> >> >
> >> > > I could leave it only for NFS, as it supports it anyway, and not pass it
> >> > > for any other mounts. Then any bug requests could be passed on the the
> >> > > file system maintainers. Then I could add it for that file system when
> >> > > done.
> >> > >
> >> > > The only annoyance with that approach is the autofs generic mount
> >> > > module, which is used to mount a number of file systems, would need to
> >> > > check the file system name to decide whether to add the sloppy option.
> >> > >
> >> > > TBH I'm not to fussy about what we do here but we need to make a
> >> > > decision before I do or I'll end up flipping back and forth.
> >> > >
> >> > > So I guess it's up to us to decide, ;)
> >> > >
> >> > > I'll post a message to the autofs list once we decide and see if we get
> >> > > any good arguments to change the approach and we can alter it as needed
> >> > > (if at all).
> >> >
> >> > Hi Ian,
> >> >
> >> > Any news about this?
> >> >
> >> > There's more and morecomplaints about the new behavior.  I'm inclined
> >> > to just make it NFS-only, as that will restore the old state of
> >> > affairs.
> >>
> >> Good question, I must admit I had forgotten about it since with the
> >> report I had the subsystem changed to ignore the option.
> >>
> >> I was going to not pass it from autofs and I have a patch for that.
> >> We could use that, after I check I've cover the bases, and I'll commit
> >> it upstream with the next set of patches (that might be a little while
> >> though).
> >
> > Leaving it for NFS only, of course.
> 
> Okay.
> 
> If you have a patch, please let me know and I'll review and test it.

It's pretty simple but should do the trick.
I have it at the top of the queue now so I can push it without having to
push the others.

Umm, I didn't even compile test this so please forgive any pain, ;)
Nevertheless I think this covers the cases.

autofs-5.1.0 - dont pass sloppy option for other than nfs mounts

From: Ian Kent <ikent@redhat.com>

Historically autofs added an option to mounts, called the sloppy
option, meant to allow mount(8) to ignore invalid mount options.
This was done so that mount map entries for sites that needed to
use different mount options for some machines would still work.
It was needed for nfs mounts in particular.

Recent changes to mount(8) cause the sloppy option to be passed on
for all mounts when it is given.

Previously mount(8) only passed on the option to nfs mounts so now,
for other than nfs mounts, the mount will fail if the file system
doesn't understand the sloppy option.

Since the option was not passed on to other than nfs mounts before
it seems sensible for autofs to not add it for other than nfs mounts
now.

Signed-off-by: Ian Kent <ikent@redhat.com>
---
 CHANGELOG               |    1 +
 modules/mount_bind.c    |    9 ++++-----
 modules/mount_changer.c |    6 +++---
 modules/mount_ext2.c    |    6 +++---
 modules/mount_generic.c |    4 ++--
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index b0dce1e..ff8e1cd 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -33,6 +33,7 @@
 - clarify multiple mounts description.
 - gaurd against incorrect umount return.
 - update man page autofs(8) for systemd.
+- dont pass sloppy option for other than nfs mounts.
 
 04/06/2014 autofs-5.1.0
 =======================
diff --git a/modules/mount_bind.c b/modules/mount_bind.c
index 465f09c..ac954e3 100644
--- a/modules/mount_bind.c
+++ b/modules/mount_bind.c
@@ -158,13 +158,12 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 		if (!status)
 			existed = 0;
 
-		debug(ap->logopt,
-		      MODPREFIX
-		      "calling mount --bind " SLOPPY " -o %s %s %s",
+		debug(ap->logopt, MODPREFIX
+		      "calling mount --bind -o %s %s %s",
 		      options, what, fullpath);
 
-		err = spawn_bind_mount(ap->logopt,
-			     SLOPPYOPT "-o", options, what, fullpath, NULL);
+		err = spawn_bind_mount(ap->logopt, "-o",
+				       options, what, fullpath, NULL);
 
 		if (err) {
 			if (ap->type != LKP_INDIRECT)
diff --git a/modules/mount_changer.c b/modules/mount_changer.c
index d7bfa09..5e2b47c 100644
--- a/modules/mount_changer.c
+++ b/modules/mount_changer.c
@@ -103,12 +103,12 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	}
 
 	if (options && options[0]) {
-		debug(ap->logopt,
-		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
+		debug(ap->logopt, MODPREFIX
+		      "calling mount -t %s -o %s %s %s",
 		      fstype, options, what, fullpath);
 
 		err = spawn_mount(ap->logopt, "-t", fstype,
-			     SLOPPYOPT "-o", options, what, fullpath, NULL);
+			          "-o", options, what, fullpath, NULL);
 	} else {
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s %s %s",
diff --git a/modules/mount_ext2.c b/modules/mount_ext2.c
index 1bc429d..3c87512 100644
--- a/modules/mount_ext2.c
+++ b/modules/mount_ext2.c
@@ -116,11 +116,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 	}
 
 	if (options) {
-		debug(ap->logopt,
-		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
+		debug(ap->logopt, MODPREFIX
+		      "calling mount -t %s -o %s %s %s",
 		      fstype, options, what, fullpath);
 		err = spawn_mount(ap->logopt, "-t", fstype,
-			     SLOPPYOPT "-o", options, what, fullpath, NULL);
+			          "-o", options, what, fullpath, NULL);
 	} else {
 		debug(ap->logopt,
 		      MODPREFIX "calling mount -t %s %s %s",
diff --git a/modules/mount_generic.c b/modules/mount_generic.c
index 79e3d32..2473b80 100644
--- a/modules/mount_generic.c
+++ b/modules/mount_generic.c
@@ -97,11 +97,11 @@ int mount_mount(struct autofs_point *ap, const char *root, const char *name, int
 
 	if (options && options[0]) {
 		debug(ap->logopt,
-		      MODPREFIX "calling mount -t %s " SLOPPY "-o %s %s %s",
+		      MODPREFIX "calling mount -t %s -o %s %s %s",
 		      fstype, options, loc, fullpath);
 
 		err = spawn_mount(ap->logopt, "-t", fstype,
-			     SLOPPYOPT "-o", options, loc, fullpath, NULL);
+				  "-o", options, loc, fullpath, NULL);
 	} else {
 		debug(ap->logopt, MODPREFIX "calling mount -t %s %s %s",
 		      fstype, loc, fullpath);


