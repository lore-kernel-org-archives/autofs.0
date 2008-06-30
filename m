From: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Subject: Re: More autofs problems
Date: Mon, 30 Jun 2008 16:57:48 +0200
Message-ID: <20080630145748.GX11428@casco.aei.mpg.de>
References: <4868946B.7050801@aei.mpg.de>
	<1214815665.3008.11.camel@raven.themaw.net>
	<4868B0BA.9040208@aei.mpg.de>
	<1214822142.3008.18.camel@raven.themaw.net>
	<4868DD3C.5020706@aei.mpg.de>
	<1214832384.3008.27.camel@raven.themaw.net>
	<4868EA97.4000103@aei.mpg.de>
	<1214835616.3008.35.camel@raven.themaw.net>
	<4868EE71.7070607@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4868EE71.7070607@aei.mpg.de>
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
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Mon, Jun 30, 2008 at 04:32:17PM +0200, Carsten Aulbert wrote:
> 
> http://packages.debian.org/search?keywords=autofs5&searchon=names&suite=all&section=all
> 
> So, I don't know how much effort it would be to backport them to glibc
> 2.3 instead of 2.7 and so on...

Jan Christoph Nordholz <hesso@pool.math.tu-berlin.de> (who is listed as
maintainer of the package) might be able to tell.

From a first glance, the package build-depends on debhelper >=6 - something
that isn't easily ignored. OTOH, since autofs5 has been there for so long,
there might exist some debian/ stuff that would match Etch. Should I ask him?

> Might be worth a try, if you say it's stable enough ;)

Let's hope so.
Except for quite some patches names *UPSTREAM*, there isn't too much in the
.diff.gz ...

Steffen
