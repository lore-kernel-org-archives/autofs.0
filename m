From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: AutoFS5 for 2.6.27.x?
Date: Mon, 03 Nov 2008 09:17:59 -0500
Message-ID: <x49r65ski5k.fsf@segfault.boston.devel.redhat.com>
References: <490EFB81.3060102@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <490EFB81.3060102@aei.mpg.de> (Carsten Aulbert's message of "Mon, 
	03 Nov 2008 14:24:17 +0100")
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org

Carsten Aulbert <carsten.aulbert@aei.mpg.de> writes:

> Hi all,
>
> I'm reading/skimming this list for quite a bit of time, but somehow I
> lost track. In the mainline kernel 2.6.27.4 there seems to be only
> autofs4 not autofs5, right?  At least I'm only seeing CONFIG_AUTOFS_FS
> and CONFIG_AUTOFS4_FS.
>
> On the ftp server of kernel.org I found 5.0.3 patches from January, but
> that seems quite old to me. The golden question: Is this the correct
> tarball to use or is there some git repo were I should pull the patches
> - and how?

The kernel module is named autofs4 for reasons I won't get into.  The
latest userspace package is autofs version 5.  The autofs4 kernel
modules speaks the autofs version 5 protocol.

In short, you want the autofs version 5 userspace packages.

Cheers,

Jeff
