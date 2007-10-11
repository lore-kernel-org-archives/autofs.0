From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: nested automounts: bind and nfs
Date: Thu, 11 Oct 2007 10:24:26 +0200
Message-ID: <1192091066.20253.8.camel@localhost>
References: <1191247723.19265.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1191300830.26331.24.camel@raven.themaw.net>
	<1191321007.27255.12.camel@localhost>
	<1191332917.26331.171.camel@raven.themaw.net>
	<1192025757.27076.31.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1192072389.3114.2.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1192072389.3114.2.camel@raven.themaw.net>
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

Ups.

> > There's an updated package in 
> >
> http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2-5.diff.gz - the only change being adding --disable-mount-locking and removing --enable-force-shutdown during configure.
> 
> File not found?

Sorry about that - in the meantime I uploaded a new version with the
latest patch (4. oct.) applied and didn't realise that the old one got
deleted.

Try this:
http://packages.techfak.uni-bielefeld.de/pool/techfak-testing/a/autofs5/autofs5_5.0.2-6.diff.gz 

I promise I won't update until I hear from you :)

-- 
Lukas
