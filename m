From: Ian Kent <raven@themaw.net>
Subject: Re: nested automounts: bind and nfs
Date: Wed, 10 Oct 2007 23:15:16 +0800
Message-ID: <1192029316.3151.11.camel@raven.themaw.net>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
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

On Wed, 2007-10-10 at 16:15 +0200, Lukas Kolbe wrote:
> Hi Ian, Jeff and list,
> 
> > The mount command looks fine to me but mount(8) is failing.
> > I'm not sure what's in the kernel your running, checking that would
> > probably be a good idea, where can I find the source for it?
> 
> 
> > The other thing is that it looks like the bind mount isn't triggering
> > the dependent mount which implies that the "--disable-mount-locking"
> > isn't being used with configure.
> 
> There's an updated package in 
> http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2-5.diff.gz - the only change being adding --disable-mount-locking and removing --enable-force-shutdown during configure.
> 
> 
> Here is what happens:
> 
> 
> root@sorpe:~# /etc/init.d/autofs start
> Starting automount: done.
> 
> root@sorpe:~# ls -la /vol/eclipse/bin/
> total 0
> dr-xr-xr-x 8 root root 0 2007-10-10 16:06 ..
> ?--------- ? ?    ?    ?                ? /vol/eclipse/bin/.
> 
> okay, something borked here :)

Certainly is.
You're NFS is broken.

I'm not even going to look at the log or consider possible util-linux
version issues until you update the kernel on this system. This part of
the problem is very much the responsibility of the distribution kernel
maintainers. 

Ian
