From: Stef Bon <stef@bononline.nl>
Subject: Re: How to determine a path is a mountpoint.
Date: Tue, 16 Feb 2010 14:20:44 +0100
Message-ID: <201002161420.44885.stef@bononline.nl>
References: <201002152253.46863.stef@bononline.nl> <4B7A0B31.30200@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B7A0B31.30200@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Tuesday 16 February 2010 04:04:17 Ian Kent wrote:
> On 02/16/2010 05:53 AM, Stef Bon wrote:
> > Hello,
> > 

> 
> Yes, checking /proc/mounts is slow but is the only way when using older
> versions of the kernel module.
> 
> In a recent source tree, have a look at lib/mounts.c:is_mounted() and
> lib/dev-ioctl-lib.c, and in particular dev_ioctl_ismountpoint().
> 
> Ian

Thanks for you fast answer.

I've checked the code and found the functions you're pointed, they are indeed 
what I'm looking for.

The function is_mounted looks like an internal function. It makes use of a 
struct ioctl_ops, which is initialised with get_ioctl_ops.  I do not 
understand this, cause this function does not use any parameter (like path!) 
so how does this function determine it's a mountpoint?

Or is it initialised somewhere else?? 
(in that case it looks like an constrcution with fuse handling 
filedescriptors.. when openening a file for writing, it looks for a fd already 
set in the runtimeoptions fuse_file_info->fh, and opens that in stead of 
looking at the path, which happens to be a parameter also) 


The other function you mention is dev_ioctl_ismounpoint, which looks more 
suitable to use in an external program like a fusemodule. The ioctl device, is 
that the device /var/run/autofs.fifo-mnt-mount.md5key-sbon-mount?

(if the map looks like:
/mnt/mount.md5key/sbon/mount  /etc/autofs/auto.md5key MD5KEY_USER=sbon
)

Stef
