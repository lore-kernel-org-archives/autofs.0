From: "Rigler, Stephen C." <srigler@marathonoil.com>
Subject: RE: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Wed, 26 Jan 2005 10:33:34 -0600
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE7101B291B1@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

 

> -----Original Message-----
> From: autofs-bounces@linux.kernel.org 
> [mailto:autofs-bounces@linux.kernel.org] On Behalf Of raven@themaw.net
> Sent: Wednesday, January 26, 2005 9:35 AM
> To: Steinar H. Gunderson
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] [ANNOUNCE] autofs 4.1.4 beta1 release
> 
> I see.
> 
> What if autofs[4] is not compiled as a module?
> 
> This might need some more work.
> 

Just to contribute to this, on Altix running SGI's variant of RHEL 3,
they compile autofs (3 and 4) into the kernel and not as modules.
We've had problems with automount defaulting to version 3 in this case.
It works fine when compiled as a module.  I opened a case with SGI
asking
them to ship their kernel with it compiled as a module, but I haven't
heard their stance on that yet.

-Steve
