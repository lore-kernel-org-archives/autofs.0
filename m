From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Wed, 10 Oct 2007 19:02:44 +0200
Message-ID: <1192035764.20253.5.camel@localhost>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192029316.3151.11.camel@raven.themaw.net>
	<1192030146.27076.46.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192034852.3151.21.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192034852.3151.21.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hello Ian,

> Sure, this may not be the only problem but, having been involved in
> discussions about this a few times over the last year I'm pretty sure
> there is also a race in the NFS client kernel code of the kernel you are
> using.
> 
> I'll have a look at the log and the map your using and try and reproduce
> what your seeing.

Thank you very much, I look forward to your findings. If you think it's
a bug in either the kernel or util-linux or nfs-utils, I'll ponder the
distributor from now on.

> Ian


-- 
Lukas
