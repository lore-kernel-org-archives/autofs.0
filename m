From: Ian Kent <raven@themaw.net>
Subject: RE: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Thu, 27 Jan 2005 09:24:18 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0501270921590.20105@wombat.indigo.net.au>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE7101B291B1@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE7101B291B1@HOUEXC210.mgroupnet.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rigler, Stephen C." <srigler@marathonoil.com>
Cc: autofs@linux.kernel.org

On Wed, 26 Jan 2005, Rigler, Stephen C. wrote:

>  
> 
> > -----Original Message-----
> > From: autofs-bounces@linux.kernel.org 
> > [mailto:autofs-bounces@linux.kernel.org] On Behalf Of raven@themaw.net
> > Sent: Wednesday, January 26, 2005 9:35 AM
> > To: Steinar H. Gunderson
> > Cc: autofs@linux.kernel.org
> > Subject: Re: [autofs] [ANNOUNCE] autofs 4.1.4 beta1 release
> > 
> > I see.
> > 
> > What if autofs[4] is not compiled as a module?
> > 
> > This might need some more work.
> > 
> 
> Just to contribute to this, on Altix running SGI's variant of RHEL 3,
> they compile autofs (3 and 4) into the kernel and not as modules.
> We've had problems with automount defaulting to version 3 in this case.
> It works fine when compiled as a module.  I opened a case with SGI
> asking
> them to ship their kernel with it compiled as a module, but I haven't
> heard their stance on that yet.

Interesting.

Seems to me that having both filesystems compiled in can't work as they 
both attempt to register as "autofs".

So first come first served.
Deselecting autofs would also work of course.

Ian
