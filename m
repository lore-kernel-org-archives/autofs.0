From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5 for 2.6.27.x?
Date: Tue, 04 Nov 2008 09:39:51 +0900
Message-ID: <1225759191.3003.15.camel@zeus.themaw.net>
References: <490EFB81.3060102@aei.mpg.de>
	<x49r65ski5k.fsf@segfault.boston.devel.redhat.com>
	<490F13B1.7000508@aei.mpg.de>
	<x49abcgkdup.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49abcgkdup.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-03 at 10:50 -0500, Jeff Moyer wrote:
> Carsten Aulbert <carsten.aulbert@aei.mpg.de> writes:
> 
> > Hi all
> >
> > Jeff Moyer wrote:
> >> The kernel module is named autofs4 for reasons I won't get into.  The
> >> latest userspace package is autofs version 5.  The autofs4 kernel
> >> modules speaks the autofs version 5 protocol.
> >> 
> >> In short, you want the autofs version 5 userspace packages.
> >
> > Jumping up and down too early I guess:
> >
> > I've userland autofs5 version 5.0.3 installed, the kernel 2.6.27.2 has
> > AUTOFS4 set
> > $ zgrep AUTOFS /proc/config.gz
> > CONFIG_AUTOFS_FS=y
> > CONFIG_AUTOFS4_FS=y
> 
> Don't build them both into the kernel.  Ian, we should see if there's a
> way to disallow that.

Yeah, that does seem sensible these days.
Mmmm ... I've not really needed to do anything in the kernel build
system before, so I'm not sure either!

> 
> You want:
> 
> CONFIG_AUOTFS_FS=n
> CONFIG_AUTOFS4_FS=m
> 
> Cheers,
> 
> Jeff
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
