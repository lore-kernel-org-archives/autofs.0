From: Ian Kent <raven@themaw.net>
Subject: Re: nested automounts: bind and nfs
Date: Thu, 11 Oct 2007 00:47:32 +0800
Message-ID: <1192034852.3151.21.camel@raven.themaw.net>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192029316.3151.11.camel@raven.themaw.net>
	<1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Wed, 2007-10-10 at 17:29 +0200, Lukas Kolbe wrote:
> Hey Ian,
> 
> > 
> > Certainly is.
> > You're NFS is broken.
> > 
> > I'm not even going to look at the log or consider possible util-linux
> > version issues until you update the kernel on this system. This part of
> > the problem is very much the responsibility of the distribution kernel
> > maintainers. 
> 
> I'm not quite so sure about that. nfs is working fine, I can
> browse /vol/eclipse-3.1/bin and all other nfs shares without failure.
> The bind-mount is what breaks, and the fact that the bind mount takes
> place and gets executed _before_ /vol/eclipse-3.1/bin is actually
> nfs-mounted, as you can clearly see in the log (only the relevant lines
> here, for the full log see the other mail):

Sure, this may not be the only problem but, having been involved in
discussions about this a few times over the last year I'm pretty sure
there is also a race in the NFS client kernel code of the kernel you are
using.

I'll have a look at the log and the map your using and try and reproduce
what your seeing.

Ian
