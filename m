From: Ian Kent <raven@themaw.net>
Subject: Re: New Debian packages
Date: Tue, 5 Apr 2005 20:05:31 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504051957560.1851@donald.themaw.net>
References: <20050403000945.GB22336@uio.no>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050403000945.GB22336@uio.no>
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Sun, 3 Apr 2005, Steinar H. Gunderson wrote:

> Ian,
>
> I uploaded a couple of new autofs versions to the Debian archive today; you
> might be interested in some of the patches (mostly minor stuff, like backing
> down on "set -e" in the init scripts, but there's an odd bugfix in places).
> Should I send them one by one, or do you just get 4.1.3+4.1.4beta2-7 out of
> the archive and pick out the patches yourself?

I've checked the patches and here's what I've got:

052 - applied
053 - equivalent change already in place
054 - backout my changes and apply
055 - will apply
056 & 57 - will apply but think scripts are now Boune shell complaint
058 - equivalent change already in place
059 - applied

So this looks good to me.

>
> BTW, we're freezing really soon, so if you want something into the Debian
> version in time for sarge, now is probably the time. :-)

Do we have enough time for another beta and some testing time or prehaps it's
release time given the above.

I need to test localy after I make these changes anyway so it's going to
be a couple of more days.

Ian
