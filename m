From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: More autofs problems
Date: Mon, 30 Jun 2008 18:57:31 +0200
Message-ID: <1214845052.7542.4.camel@eldorado>
References: <4868946B.7050801@aei.mpg.de>
	<1214815665.3008.11.camel@raven.themaw.net>
	<4868B0BA.9040208@aei.mpg.de>
	<1214822142.3008.18.camel@raven.themaw.net>
	<4868DD3C.5020706@aei.mpg.de>
	<1214832384.3008.27.camel@raven.themaw.net>
	<4868EA97.4000103@aei.mpg.de>
	<1214835616.3008.35.camel@raven.themaw.net>
	<4868EE71.7070607@aei.mpg.de>
	<20080630145748.GX11428@casco.aei.mpg.de>
	<20080630153346.GB16035@pool.math.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080630153346.GB16035@pool.math.tu-berlin.de>
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
To: Jan Christoph Nordholz <hesso@pool.math.tu-berlin.de>
Cc: autofs@linux.kernel.org

Hi!

> > > http://packages.debian.org/search?keywords=autofs5&searchon=names&suite=all&section=all
> > > 
> > > So, I don't know how much effort it would be to backport them to glibc
> > > 2.3 instead of 2.7 and so on...
> > 
> > Jan Christoph Nordholz <hesso@pool.math.tu-berlin.de> (who is listed as
> > maintainer of the package) might be able to tell.
> 
> I don't think that it's very problematic to backport the autofs5 package to Etch.
> I'm working on it. (Thanks to Steffen for mailing me directly - I follow this
> mailinglist, but sometimes I lag behind a bit.)

I don't know if this has changed with the latest patches, but last time
I tried autofs5 used a symbol from openldap that was not in etch's
openldap (LDAP_CONTROL_PAGEDRESULTS), which could be fixed by patching
that symbol into the autofs-source, but since then it's crashing on us
every now and then. Sorry to be so vague, but I didn't have time to
debug the crash any further.

Other than that, autofs5 is order magnitudes better and more reliable
than 4 ever was. Seriously. 

> Regards,
> 
> Jan

-- 
Lukas
