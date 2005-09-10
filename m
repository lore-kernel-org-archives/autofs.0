From: Ian Kent <raven@themaw.net>
Subject: Re: Multipliexing mounts
Date: Sat, 10 Sep 2005 11:33:01 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0509101112250.2073@donald.themaw.net>
References: <134FC8D9C1F126488E3D123A9B2607370A75992F@bp1houex002.bp1.ad.bp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <134FC8D9C1F126488E3D123A9B2607370A75992F@bp1houex002.bp1.ad.bp.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Murata, Dennis W (SAIC)" <muratadw@bp.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 9 Sep 2005, Murata, Dennis W (SAIC) wrote:

> I recently had an applications trainer give a class on Konqueror.  During the class she went up a directory from $HOME.  Konqueror tried to automount 1321 home directories.  I did not count to see how many were mounted, but I was able to kill Konqueror.  The workstation did not lock up, but not all home directories were available.  Has the patch to multiplex mounts been applied to any autofs version?
> We are running RHEL 3 update 3, with autofs-4.1.4-4 from jmoyer recompiled.  The users want the ghosting feature, so I don't want to disable it.
> The home directories are automounted from a NetApp filer.
> 

Hi Dennis,

Your description of this problem is a bit unclear to me.

I think you're talking about about more than one issue.

Firstly the multiplexing of mounts is likely referring to the kernel 
sunrpc implementation which is not part of the autofs code. There 
certainly is a problem there that's been discussed many times. There are a 
couple of patches around but I don't believe any are ready for general 
use. This would allow you to mount that many mounts but, with a 2.4 
kernel and the more-unnamed patch such as is in RedHat kernels, you will 
run out of unnamed devices at just over 1200. The limitation on unnamed 
devices has been removed in 2.6.

The second thing is that you may be using the multi-mount (auto.net) type 
mounts from these servers whereby accessing it mounts all the servers 
exports. Lazy mount/umount for multi-mounts is not done yet. I was this 
very morning thinking about the way in which this will be implemented. 
Unfortunately, when this is done it will require the reworked direct mount 
functionality that is well underway now.

In any case I'm not sure that this will actually play well with the 
aggressive directory tree scanning of file managers found in KDE and Gnome.

We'll just have to see.

Ian
