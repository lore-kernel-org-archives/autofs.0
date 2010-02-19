From: Ian Kent <raven@themaw.net>
Subject: Re: How to determine a path is a mountpoint.
Date: Fri, 19 Feb 2010 11:57:15 +0800
Message-ID: <4B7E0C1B.4040209@themaw.net>
References: <201002152253.46863.stef@bononline.nl>
	<201002171343.31360.stef@bononline.nl>
	<4B7BFC44.4050706@themaw.net>
	<201002190018.37820.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <201002190018.37820.stef@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On 02/19/2010 07:18 AM, Stef Bon wrote:
> On Wednesday 17 February 2010 15:25:08 Ian Kent wrote:
> 
>> 
>> And I will check the implementation and get back with specific 
>> behaviours, if this is what you need.
>> 
>> Don't forget that if the kernel doesn't support the mount check
>> ioctl you will need to use something like what is done in 
>> lib/mounts.c:is_mounted() and call something like 
>> lib/mounts.c:table_is_mounted() to scan /proc/mounts. It does this
>> when it sees the kernel doesn't support the new function. That is
>> when it sees that the struct ioctl_ops ismountpoint field is null
>> (because there is no ioctl entry point for it).
>> 
>> Ian
> 
> OK,
> 
> I know that I need something else when the kernel does not support
> the ioctl check.
> 
> Maybe I should have been more clear in what I want. I'm afraid I have
> totell you something about my setup, although you don't need to
> understand it. Please do not forget just learned C and not "home" in
> the autofs code and construction.

Well, I tried to keep the discussion simple!
We will just have to work through it then.

> 
> I'm using a very simple map file:
> 
> *            -fstype=md5key :/&
> 
> that's it! It passes every key to the mountcommand of the nonexistant
> md5key  filesystem: /sbin/mount.md5key
> 
> which is a wrapper for other (real) mount commands. The automounter
> just let this happen what is a pretty nice thing!
> 
> Now the mountpoint where this map is assigned to depends to the user,
> the line in the auto.master looks like:
> 
> /mnt/mount.md5key/sbon/mount       /etc/autofs/auto.md5key
> MD5KEY_USER=sbon
> 
> Now this directory is not to be accessed directly by the user, but
> through a fusemodule I'm working on. In short, it points to
> directories (keys) in the /mnt/mount.md5key/sbon/mount directory,
> which are one level deep. Every key is actually the md5sum of a
> record (I call them resource records) about a resource, local(USB) or
> remote (CIFS, FTP, SSH).
> 
> Now in the autofs managed directory
> 
> /mnt/mount.md5key/sbon/mount
> 
> only those directories exist of resources actually mounted! If I
> access a SMB share in my connection tree, my call is redirected to
> the proper md5key directory in /mnt/mount.md5key/sbon/mount, making
> the automounter mount the share:
> 
> mount | grep /mnt/mount.md5key/sbon
> 
> //SCLFS20091030/video on
> /mnt/mount.md5key/sbon/mount/e23e33a53d5d08ad8f0425de4edd9309 type
> cifs (rw,mand)
> 
> 
> and when I do /bin/ls -l /mnt/mount.md5key/sbon/mount: total 0 
> drwxr-xr-x 10 root root    0 2010-02-09 12:11
> e23e33a53d5d08ad8f0425de4edd9309
> 
> when I enter other shares these appear as well. When unmounted, the
> directories disapear. Logic, you might say, but this is crucial.
> 
> My fusemodule is an overlay fs, which mirrors another directory under
> the directory under which it's mounted, and does some changes.

aka unionfs type behaviour?

You are in for a bundle of trouble if your trying to implement an
overlay file system. If there are enough restrictions on functionality
you might be able to get this working reliably but the locking alone
will likely drive you nuts! You understand that once you play in kernel
space you can have multiple concurrent code paths accessing and possibly
changing the same data structures at the same time.

> 
> Now how does my module know which share is mounted when building an
> directory overview with readdir and applications like Dolphin are
> searching for a .directory file. The call for this .directory file in
> the target is intercepted by my fuse module, cause otherwise this
> call will also make the automounter mount the share, while only the
> .directory is looked up.
> 
> Now like I've said before, I cannot do a stat of the target key
> directory, cause this will make the automounter to mount the share. 
> It's possible to make my fuse module to read the contents of
> /mnt/mount.md5key/sbon/mount, and check the key to be investigated is
> in this directory. I haven't tested this, but it should work.

It sounds like you have essentially got a kernel module here.

In that case you should not need to use an ioctl because you already
have access to the same information that the mounted check ioctl has. If
you are within a callback from kernel space deadlock is very likely
going to happen if you start calling back to the kernel again via an ioctl.

Is this a kernel module you are working with or callbacks from the
kernel? If it is then you really should be doing this a completely
different way, like using d_lookup() to locate the dentry in the
directory and then doing the checks. But I don't know exactly what
environment you are working within yet so I can't quite help.

> 
> Right now I looking for a way the automounter can give the answer. It
> looks like the dev_ioctl_ismountpoint return -1 for the case the
> share is not mounted, and *mountpoint is equal to 0. When mounted,
> another filesystem is mounted, so *mountpoint is DEV_IOCTL_ISMOUNTED
> | DEV_IOCTL_IS_OTHER.

The -1 is an error so maybe we can get more info from errno but lets
continue this discussion after we work out what environment we are in
from the question above.

Ian
