From: Ian Kent <raven@themaw.net>
Subject: Re: New Debian packages
Date: Mon, 4 Apr 2005 10:51:36 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504041046400.27508@wombat.indigo.net.au>
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

I've also been working on this.

I've taken my lead from Debian bug report discussions.
I'll check your patches before I put out a new version.

> 
> BTW, we're freezing really soon, so if you want something into the Debian
> version in time for sarge, now is probably the time. :-)

I'm tempted to release 4.1.4. Most of the current issues are with the 
Debian portion of the init script which we have been working on.

Do you think we can get this bit right and go straight to release?

Ian
