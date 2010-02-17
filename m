From: Ian Kent <raven@themaw.net>
Subject: Re: How to determine a path is a mountpoint.
Date: Wed, 17 Feb 2010 22:25:08 +0800
Message-ID: <4B7BFC44.4050706@themaw.net>
References: <201002152253.46863.stef@bononline.nl>
	<201002161420.44885.stef@bononline.nl>
	<4B7AD5DC.3010307@themaw.net>
	<201002171343.31360.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <201002171343.31360.stef@bononline.nl>
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

On 02/17/2010 08:43 PM, Stef Bon wrote:
> On Tuesday 16 February 2010 18:29:00 Ian Kent wrote:
>> On 02/16/2010 09:20 PM, Stef Bon wrote:
>>> On Tuesday 16 February 2010 04:04:17 Ian Kent wrote:
>>>> On 02/16/2010 05:53 AM, Stef Bon wrote:
>>>>> Hello,
>>>>
>>>> Yes, checking /proc/mounts is slow but is the only way when using older
>>>> versions of the kernel module.
>>>>
>>>> In a recent source tree, have a look at lib/mounts.c:is_mounted() and
>>>> lib/dev-ioctl-lib.c, and in particular dev_ioctl_ismountpoint().
>>>>
>>>> Ian
>>>
>>> Thanks for you fast answer.
>>>
>>> I've checked the code and found the functions you're pointed, they are
>>> indeed what I'm looking for.
>>>
>>> The function is_mounted looks like an internal function. It makes use of
>>> a struct ioctl_ops, which is initialised with get_ioctl_ops.  I do not
>>> understand this, cause this function does not use any parameter (like
>>> path!) so how does this function determine it's a mountpoint?
>>
>> Read lib/dev-ioctl-lib.c, that's why I mentioned it, it's not that long.
>>
>> It implements a set of functions for autofs control operations.
>>
>> Many of them can't be called by just any process but the
>> dev_ioctl_ismountpoint() function can. It may not look that simple but
>> if you take some time to understand what it is doing you can take the
>> bits you need and that will end up being fairly simple.
>>
>> The one problem you do have is that if the kernel doesn't have the new
>> device ioctl interface you will need to scan /proc/mounts, the same as
>> is done by the is_mounted() function if it sees the new functionality
>> isn't available.
> 
> Ok, but some helpe here is welcome. I've learned C just some months ago, and 
> programming devices is new to me.
> 
> Look at dev_ioctl_ismountpoint.
> 
> The parameters it's using are logopt, ioctlfd, path and mountpoint.
> 
> logopt has something to do with logging, and is important, but not the topic.
> ioctlfd is the filedescriptor for the fifo(?) in /var/run:

You probably wouldn't need logopt, it's for autofs per-mount log level
so it's automount daemon specific. Read the comment above the function,
you don't have a file descriptor so you can give it a (full) path and
set the file descriptor to -1.

> 
> /var/run/autofs.fifo-mnt-mount.md5key-sbon-mount

Forget about those named pipes they are nothing to do with this.
You need to read this whole file to understand what is going on and
adapt the bits you need for your own use.

If you have a recent kernel then you can use the miscellaneous device
/dev/autofs for ioctl control functions such as is done in
dev_ioctl_ismountpoint(). To find out if the kernel supports it you need
to use a construct similar to that seen in init_ioctl_ctl(). If the
device file is available init_ioctl_ctl() opens the device file, stores
the descriptor in the struct ioctl_ctl, and uses the file descriptor
from that structure for autofs ioctl operations, as is seen in
dev_ioctl_ismountpoint().

You need to see the bugger picture of what is going on in
dev-ioctl-lib.c to be able to make use of it.

> 
> in /proc/1705/fd :
> 
> 9 -> /var/run/autofs.fifo-mnt-mount.md5key-sbon-mount
> 
> and 15 -> /var/run/autofs.fifo-mnt-mount.md5key-root-mount
> 
> futher path is of course the path to be examined. Is it absolute or relative
> 
> and mountpoint is the value which is combination of DEV_IOCTL_IS_MOUNTED, 
> DEV_IOCTL_IS_AUTOFS and DEV_IOCTL_IS_OTHER. 
> 
> Is my analysis good???
> 
> 
> To be sure, the value's I'm looking for are autofs managed mountpoints 
> (DEV_IOCTL_IS_AUTOFS is 1) and the path is a mountpoint, which means
> a resource is actually mounted here. (DEV_IOCTL_IS_OTHER).

If nothing is mounted on the directory it should set
DEV_IOCTL_IS_AUTOFS, if there is an "other" mount it should set the
DEV_IOCTL_IS_OTHER bit. I need to look again at the implementation in
dev-ioctl-lib.c and the kernel module to be sure of what it will return.

> 
> I'm using a setup where the autofs managed directories are one level deep, 
> nothing more.
> But does this function really return a path is a mountpoint. In my module,
> it's already clear that it is an autofs managed dir. In my module autofs 
> managed dirs are of the form /mnt/mount.md5key/%USERID%/mount/%md5key%
> where %md5key% is the md5sum of the resource record.
> My fuse module checks the dirname of the path is equal to 
> /mnt/mount.md5key/%USERID%, and the basename is 32 long, and exists. 
> Resource records, containing all the information about a resource (local like 
> USB and remote like SMB and FTP) necessary to mount it.

I'm don't really understand what you are trying to do and I shouldn't
need to, I just need to know what you want to know about a given path so
try not to cloud the description with implementation detail. I thought
your issue was that if you use a system call like statfs(2) to get file
system information it will cause a mount to occur which you don't want.

> 
> Now I want to add a test in my fusemodule fuse-workspace-union about this 
> autofsmanaged directory is a an active mountpoint, or not active (expired/not 
> activated...). 
> It's not that important, but I want extra cosmetics. When mounted, I want the 
> module to show another icon than when not mounted.

And I will check the implementation and get back with specific
behaviours, if this is what you need.

Don't forget that if the kernel doesn't support the mount check ioctl
you will need to use something like what is done in
lib/mounts.c:is_mounted() and call something like
lib/mounts.c:table_is_mounted() to scan /proc/mounts. It does this when
it sees the kernel doesn't support the new function. That is when it
sees that the struct ioctl_ops ismountpoint field is null (because there
is no ioctl entry point for it).

Ian
