From: Stef Bon <stef@bononline.nl>
Subject: Re: Returning issues.
Date: Tue, 07 Jun 2011 11:15:30 +0200
Message-ID: <4DEDEC32.4070602@bononline.nl>
References: <4DEBB650.8030207@bononline.nl>
	<1307424204.3285.52.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1307424204.3285.52.camel@perseus.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

  On 06/07/2011 07:23 AM, Ian Kent wrote:
> On Sun, 2011-06-05 at 19:01 +0200, Stef Bon wrote:
>> hi,
>>
>> I see that issues that automounter doing unnecessary mounting like:
>>
>> http://linux.kernel.org/pipermail/autofs/2011-May/006568.html
> I think you misunderstood the report here.
> Neither of the points below were related to it.
>
>> and here
>>
>> http://linux.kernel.org/pipermail/autofs/2011-April/006542.html
>>
>> some more documentation here would prevent users asking the
>> same questions.
>>
>> This behaviour is mostly caused by:
>>
>> A.
>>
>> ls is a alias (in de shell) to ls --color=auto
>>
>> which will follow targets, and this makes the automounter mount.
> This mostly isn't a problem these days as most user space utilities
> behave better with automount these days.
>
> We will need to wait and see how the user space utilities behave with
> the new vfs automount kernel infrastructure and work out what needs to
> be done as we go.

I hope you're right. How do apps "know" a directory is a autofs managed 
mountpoint?


>> B.
>>
>>
>> extended attributes called by the environment, or an app.
>>
>> I see here a sollution is proposed to fix this in coreutils and the acl
>> package. Hmm, is this right?
> Yes, this was related to inconsistent use of system calls within the
> user space utility, an lgetxattr(2) call was being made instead of a
> getxattr(2) call (inconsistent with respect to previous calls in the
> same utility code path), which was causing a mount to occur on the
> follow, as required by the lgetxattr(2) call.
>
> So, in this case, it needed to be fixed in the utility.

You're mixing things here I think. A lgetxattr will normally not follow 
a symlink,
as the call getxattr does.

Isn't it the other way around?

(compare stat and lstat: lstat looks at the symlink self, stat follows 
the symlink and takes the target)

Anyhow, when a userspace utility does something like that, it's a 
serious error. Utilities should do exactly what is requested, and never 
anything else.



| autofs directories don't have extended attributes.

You mean only the autofs managed mount points? The contents of the share 
can have Xattr right?


>> Can't an autofs managed directory have Xattr?? That does not sound right.
> No, the autofs fs doesn't support extended attributes.
>
> Do you really think we need extended attributes?
> If you do then a patch, which includes some reasoning of why we need
> them, would be welcomed.

No, it suprise me only, since the contents of an autofs managed 
mountpoint can have Xatttr (see above) and I consider the autofs managed 
mountpoint belonging to the mounted share.

Maybe simular like the stat call, where the trailing slash makes the 
difference, a trailing slash to the end of the path when doing 
getxattr/setxattr is doing a call to the "." dir on the remote share, 
and without it it's going to the autofs managed dir on the localhost, 
resulting in a EOPNOTSUPP as expected.

> >  
> >  In my construction I'm blocking the xattr calls to autofs managed dirs,
> >  unless it's already mounted, and I consider this as an ugly hack.
| How?

This is possible in the (special) construction I'm working on, fuse-workspace and mount.md5key.

In short, it's like GoboLinux, providing a special environment to the user. GoboLinux needed a special kernel
patch to achieve this, I'm using a FUSE fs to do the same. The environment looks like:

/Computer
/Home
/Internet Services
/Mounts
/Network
/Shared
/System

This the the root of the filesystem. Quite different he?!?

Now you may think like "what the hell you're doing to the Linux system", but the normal directories like
/bin, /etc, /lib, etcetera are present but hidden, the readdir - part of the FUSE fs - call has the ability to
hide entries when configured.

You can do a stat on /bin, and enter it normally . Well that's required to make the system run.
First step is to mount the FUSE fs at a certain directory:

/var/lib/workspace/$USER/bind

Then create the "root system" directory:

mkdir /var/lib/workspace/$USER/bind/bin

then make it hidden:

setfattr --name="system.workspace_entry_hide" --no-dereference --value=1 -- "/var/lib/workspace/bind/$USER/bind/bin"

This command changes the value of the Xattr (system.workspace_entry_hide) of the entry managed by the FUSE fs,
as the FUSE fs has a administration of entries and inodes of it's own, and has it's own set of Xattr as you can see.

Now the entry will not show when doing a readdir call anymore.

But it does exist, and can be used to mount:

mount --bind /bin /var/lib/workspace/$USER/bind/bin

Every syscall to something in this directory will not go through the FUSE fs, but directly will lead to /bin,
which is a very good thing, the extra layer will slow things down. The VFS takes care of that.

Now do this for every root system map, and you have a complete directory you can chroot to, where you can do things with
the FUSE fs, and not have any loss of performance.

Now chroot to this environment using pam_chroot when the session begins, and you'r done.

It's possible to have no visible directories at all, while the system is just running. For example KDE looks at
$HOME/.kde for settings, well it's just there.



Now the construction (a lot of scripts and utilities) creates the directories like:

/Computer
/Home
/Internet Services
/Mounts
/Network
/Shared
/System

where for example the Computer folder offers access to hardware like ATA disks/partitions, USB devices and
their partitions.
The Network folder provides access to SMB (=Windows and or Samba) shares, giving a browseable map, to all
available services/shares. This is done dynamically while you browse, by running scripts
(which use nbtscan/nmblook/smbclient) on the fly. This means sometimes a delay of 1 a 2 seconds, when browsing
the "workgroup" and the "server" map, but that's ok.

The hardware and the shares (and all other mountable resources which this construction offers) are redirected (by the
FUSE fs) to autofs managed mountpoints, using a hash table.

This is where the md5key comes in: every resource (a partition, a device, a smb share/server/workgroup, a network,
a iso file, account at Google Docs, account at Amazon S3 etc, a mountable archive are supported yet) is
is detected and kept in a hash table, where a md5key is an unique key to it. (unique index).

Every user gets a set of autofsmanaged mountpoints, some for private use, some public, and thus shared with others:

cd /var/run/autofs/
cat mount.m5key.master

/mnt/mount.md5key/public/0 /etc/autofs/auto.md5key --timeout=600 MD5KEY_USER=public
/mnt/mount.md5key/public/1 /etc/autofs/auto.md5key --timeout=2 MD5KEY_USER=public
/mnt/mount.md5key/public/2 /etc/autofs/auto.md5key --timeout=0 MD5KEY_USER=public
/mnt/mount.md5key/sbon/0 /etc/autofs/auto.md5key --timeout=600 MD5KEY_USER=sbon
/mnt/mount.md5key/sbon/1 /etc/autofs/auto.md5key --timeout=2 MD5KEY_USER=sbon
/mnt/mount.md5key/sbon/2 /etc/autofs/auto.md5key --timeout=0 MD5KEY_USER=sbon

and cat /etc/autofs/auto.md5key:

*       -fstype=md5key :/&

(all the intelligence is in /sbin/mount.md5key, this reckognizes the md5key, looks it up in the hashtable and launches
the right mount command with the right options)


As you can see the construction has created 3 private autofs managed maps, and 3 public.

The private are used for private access like a SMB share using Kerberos or private credentials,
the public for a SMB share using guest or public credentials (=credentials the same for every user on this machine),
for example.
Other example: a CDrom, which is alway public, and access to Google Docs account which is private.

You see different timeouts. This is cause different resource require different timeouts. An USB device has to be unmounted
asap it's not used anymore (cause stupid/bluntly removing by the user will not cause too much trouble),
but umounting a networkshare is not necessary.

So here you see the FUSE fs is a layer, and can adjust the behaviour of certain calls like getxattr, which in the
past made the automounter mount for no good reason.

I've made the FUSE fs only pass through the getxattr call to the underlying resource when really part of the resource,
so blocking the call to the mountpoint.

I understand that the fixes you mention in the VFS will result in the same behaviour.

If anyone is interested, more info:


http://linux.bononline.nl/wiki/index.php/Mount.md5key

especially more screenshots:

http://linux.bononline.nl/wiki/index.php/Changes_and_issues

I'm still working on it, and not very successfull in getting attention.
I've asked to give a presentation on the on the Gnome/KDE meeting in Berlin, but did not get a positive reaction.
It's offtopic, was the comment. Well for Gnome this counts (it has GnomeVFS, which is doing something simular)
, but not for KDE. It does not have a good interface to recources.
I do not consider kioslaves as a unified and userfriendly way.
Earlier I have tried to give a presentation at the OpenSuse conference in Germany, no result there also.

Now apps all doing their own thing, like vlc, which does something completly different than amarok and that
again is different form Juk.....

My construction works in every environent (also simple text login) providing extra functionality via .directory files
(icon and actions) and get/set information via Xattr.

If anyone wants to try it, I'will write the intall page. That is still not done..


| Since the autofs fs inode operations do not define a getxattr operation
| these calls always return -EOPNOTSUPP. So they don't cause a callback to
| user space. User space should handle the EOPNOTSUPP return since
| extended attributes may not be available for a file system?

| OTOH the lgetxattr(2) call requires the kernel follow the mount point
| (by definition) and so a mount should be attempted and the call made
| upon the mounted file system if it succeeds.

|The bottom line is that the kernel has changed quite significantly
|underneath you, sorry.


That's not a problem, but what is a problem is the lack of good documentation/announces
saying this behaviour has changed. I'm saying this in general,not meaning you,
and staying up to date with every important development and change is a job in it self....

| Although the behavior should be substantially the same it isn't exactly
|the same and we will need to work out if we need to change anything and
|what we need to change. Keep in mind that we need to try and adhere to
|normal system call semantics were we can, if at all possible.


Mentioning the recent changes, what about the new O_PATH option added to options to open a directory?
Has this any effect on the behaviour, when for example  opening the mountpoint self.

I'm now using the "at" commands like openat and fstatat a lot if a fd is available.


Thanks,

Stef Bon
