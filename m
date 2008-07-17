From: Ian Kent <raven@themaw.net>
Subject: Re: More autofs problems
Date: Thu, 17 Jul 2008 11:03:15 +0800
Message-ID: <1216263797.22783.62.camel@raven.themaw.net>
References: <4868B0BA.9040208@aei.mpg.de>
	<1214822142.3008.18.camel@raven.themaw.net>
	<4868DD3C.5020706@aei.mpg.de>
	<1214832384.3008.27.camel@raven.themaw.net>
	<4868EA97.4000103@aei.mpg.de>
	<1214835616.3008.35.camel@raven.themaw.net>
	<4868EE71.7070607@aei.mpg.de>
	<1214836889.3008.45.camel@raven.themaw.net>
	<4869C550.6040708@aei.mpg.de>
	<1214892205.3017.23.camel@raven.themaw.net>
	<20080715142340.GM11428@casco.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080715142340.GM11428@casco.aei.mpg.de>
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
To: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Cc: autofs@linux.kernel.org


On Tue, 2008-07-15 at 16:23 +0200, Steffen Grunewald wrote:
> On Tue, Jul 01, 2008 at 02:03:23PM +0800, Ian Kent wrote:
> > 
> > btw, I discovered a mistake in one of the patches included in the
> > previous patch. I'll post an updated patch later today. Sorry for the
> > trouble.
> 
> Now that 2.6.26 is out, how many of your patches are left over (and
> would still be recommended) ?

Most of the patches I've recently posted are still in the mm tree as
they were way too late for the 2.6.26 merge window. I also have another
5 or so maintenance/bug fix patches I'm testing.

Hopefully, this will be done soon and I can release 5.0.4 with updated
patches. I can put patches for point release kernels on kernel.org if
that is needed.

Version 5.0.4 is quite important to me because, even though I think this
every time I do a release, this one fixes some fairly important bugs.

Ian
