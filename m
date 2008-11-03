From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: AutoFS5 for 2.6.27.x?
Date: Mon, 03 Nov 2008 16:07:29 +0100
Message-ID: <490F13B1.7000508@aei.mpg.de>
References: <490EFB81.3060102@aei.mpg.de>
	<x49r65ski5k.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49r65ski5k.fsf@segfault.boston.devel.redhat.com>
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
To: autofs@linux.kernel.org

Hi all

Jeff Moyer wrote:
> The kernel module is named autofs4 for reasons I won't get into.  The
> latest userspace package is autofs version 5.  The autofs4 kernel
> modules speaks the autofs version 5 protocol.
> 
> In short, you want the autofs version 5 userspace packages.

Jumping up and down too early I guess:

I've userland autofs5 version 5.0.3 installed, the kernel 2.6.27.2 has
AUTOFS4 set
$ zgrep AUTOFS /proc/config.gz
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y

and when starting autofs it complains about wrong kernel protocol version:

/etc/init.d/autofs restart
Stopping automount: done.
Starting automount: /usr/sbin/automount: kernel protocol version 5.00 or
above required.
no valid automount entries defined.

auto.master only has a single line:
/atlas/data          yp:auto.data      --timeout=5

and ypcat yields:
$ ypcat auto.data
-fstype=nfs,nfsvers=3,hard,rsize=32768,wsize=32768,tcp,rw       &:/data/

Something's wrong here but I can't spot it.

Cheers

Carsten
