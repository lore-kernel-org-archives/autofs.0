From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Newbie Question
Date: Thu, 12 Aug 2004 15:12:54 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16667.49462.344049.857207@segfault.boston.redhat.com>
References: <411BAE2F.8040309@analog.com>
	<16667.46801.458839.821849@segfault.boston.redhat.com>
	<411BBA84.7030009@analog.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <411BBA84.7030009@analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: "Anne.Bourgeois" <anne.bourgeois@analog.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Newbie Question; "Anne.Bourgeois" <anne.bourgeois@analog.com> adds:

anne.bourgeois> Jeff, My apologies.  I should have included more info in my
anne.bourgeois> original post.  Please see my answers below...

anne.bourgeois> Jeff Moyer wrote:

>> ==> Regarding [autofs] Newbie Question; "Anne.Bourgeois"
>> <anne.bourgeois@analog.com> adds:
>> 
anne> I am pretty new to the list, and I have a very basic question.  How
anne> do I install the kernel patch so that I can install the autofs rpm?
>> What distribution are you running?  Do you want to patch a kernel from
>> that distribution (recommended), or run a vanilla kernel from
>> kernel.org?

anne> We are currently running RedHat 8.0 with the 2.4.20.20-8smp
anne> kernel.  We are looking to go to Enterprise 3 in the near
anne> future, but are dependent on some software vendors, so we
anne> are holding back at the moment.  We are seeing several
anne> autofs issues, which is the reason that I am trying these
anne> updates.

Okay, get the source rpm for your kernel and install it.  Note that this is
not the kernel-source-x.y.z rpm, but rather the kernel-x.y.z.src.rpm.  It
will install to /usr/src/redhat/ by default.

Now, here's the tricky part.  I'm not sure if any of Ian's patch sets will
apply cleanly to your Red Hat 8 kernel.  :(  You can try the patch against
rh9, which can be found here:

     http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs4-2.4.20-redhat9-20040508.patch

In addition to this patch, you will want to install Ian's mount expiry
patch for 2.4, which I've attached to this mail.

Okay, so the way you apply these patches is to put the actual patch files
into /usr/src/redhat/SOURCES.  Then, you want to update the
/usr/src/redhat/SPECS/kernel-2.4.spec file (I *think* that's what it's
called) to actually include/apply these patches.  There are two lines you
need to add for each patch.  They will look something like this (follow the
convention in the spec file)

Patch5900: autofs4-2.4.20-redhat9-20040508.patch

and later in the spec file:

%patch5900 -p1

To be nice, you should bump the release number in the spec file (found near
the top), and add a changelog entry (search for %changelog).  Once you've
done all of this, you are ready to build.  Use the following command to
build the binary rpm:

rpmbuild -bb /usr/src/redhat/SPECS/kernel-2.4.spec

If that errors, then the patches probably didn't apply cleanly.  You can
either take it upon yourself to fix up the broken hunks, or you can do the
following, more laborious process.

You can download a vanilla kernel from kernel.org that Ian has made a patch
for, and then apply the relevant patches to _that_ kernel.  Once you've
done that you can take the result, and generate a patch for your specific
kernel.

Here are the specific steps to follow to accomplish this.

Comment out the %patch lines you added to the spec file, and then issue
an 'rpmbuild -bp /usr/src/redhat/SPECS/kernel-2.4.spec'.  That should execute
the "prep" stage, rebuilding your tree w/o the patches.

unpack your linux sources into /usr/src/redhat/BUILD/kernel-x.y.z.  You
will already see a directory there named for the Red Hat kernel version.
So, something like:

cd /usr/src/redhat/BUILD/kernel*
tar xjf /tmp/linux-2.4.22.tar.bz2

Apply the patches to this kernel:

cd linux-2.4.22
patch -sp1 < /tmp/autofs4-2.4.22-20040508.patch
patch -sp1 < /tmp/autofs4-lookup.patch  (assuming this is what you've named
					 the attachment from this email)

Now, generate a diff:

cd ..
diff -urN linux-<redhatver> linux-2.4.22 > linux-autofs4.patch

Put the resulting patch into /usr/src/redhat/SOURCES, make sure you add
PatchXXXX and %patchXXXX -p 1 lines to the spec file which correspond to
this new patch, and go ahead and try the build again.

Phew!  Hopefully I haven't confused you.

anne> When I tried to just install the new autofs rpm, I got a dependency
anne> error:
>>
anne> liblber-2.2.so.7 is needed by autofs-4.1.3-13 libldap-2.2.so.7 is
anne> needed by autofs-4.1.3-13
>> If you're running Fedora, I'd suggest upgrading your current system with
>> yum.

anne> I'd prefer not to change the basic system that I'm running,
anne> as I have several users on the current system.  Running on
anne> a large network, we see the automount map caching as a big
anne> problem right now.  I am hoping to find a way to fix it
anne> without too much upgrading, re-kicking of machines, etc.

Okay, that makes perfect sense.

anne> I already have autofs-4.1.3-9 installed and didn't see any dependency
anne> errors when I installed that.
>> Well, there should be no added dependency requirements.  You _could_ try
>> doing an rpm -i --force of the autofs package.

[snip]
anne> Finally worked when I used the "--nodeps" flag.  Is this
anne> OK, though?

Well, it's probably okay.  It's definitely okay if you're not using ldap.
;)


Hope this helps!

-Jeff


 --- linux-2.4.20/fs/autofs4/root.c.dir_ops	2004-07-14 21:14:02.000000000 +0800
+++ linux-2.4.20/fs/autofs4/root.c	2004-07-14 21:15:58.000000000 +0800
@@ -33,7 +33,7 @@
 static int autofs4_dir_close(struct inode *inode, struct file *file);
 static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
-static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *);
+static struct dentry *autofs4_lookup(struct inode *,struct dentry *);
 static int autofs4_dcache_readdir(struct file *, void *, filldir_t);
 
 struct file_operations autofs4_root_operations = {
@@ -50,7 +50,7 @@
 };
 
 struct inode_operations autofs4_root_inode_operations = {
-	lookup:		autofs4_root_lookup,
+	lookup:		autofs4_lookup,
 	unlink:		autofs4_dir_unlink,
 	symlink:	autofs4_dir_symlink,
 	mkdir:		autofs4_dir_mkdir,
@@ -58,7 +58,7 @@
 };
 
 struct inode_operations autofs4_dir_inode_operations = {
-	lookup:		autofs4_dir_lookup,
+	lookup:		autofs4_lookup,
 	unlink:		autofs4_dir_unlink,
 	symlink:	autofs4_dir_symlink,
 	mkdir:		autofs4_dir_mkdir,
@@ -434,23 +434,8 @@
 	d_release:	autofs4_dentry_release,
 };
 
-/* Lookups in non-root dirs never find anything - if it's there, it's
-   already in the dcache */
-static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry)
-{
-#if 0
-	DPRINTK(("autofs4_dir_lookup: ignoring lookup of %.*s/%.*s\n",
-		 dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
-		 dentry->d_name.len, dentry->d_name.name));
-#endif
-
-	dentry->d_fsdata = NULL;
-	d_add(dentry, NULL);
-	return NULL;
-}
-
 /* Lookups in the root directory */
-static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry)
+static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
