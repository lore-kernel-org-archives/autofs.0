From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Wed, 26 Jan 2005 17:22:35 +0100
Message-ID: <20050126162235.GB9417@uio.no>
References: <20050122215228.GA14303@tangens.sinus.cz>
	<20050126152037.GX21479@debian-server.aei.mpg.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050126152037.GX21479@debian-server.aei.mpg.de>
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
Content-Transfer-Encoding: 7bit
To: steffen.grunewald@aei.mpg.de
Cc: autofs@linux.kernel.org

On Wed, Jan 26, 2005 at 04:20:37PM +0100, Steffen Grunewald wrote:
> I also see this (Debian Sarge, installation done some weeks ago, package
> version is 4.1.3-4). WIth an older installation (another Sarge), still using
> 3.9.99-4.0.0pre10-16, this doesn't show up.

4.1.3-4 is old, there has bene _lots_ of changes since then. The latest
version in sarge is 4.1.3-8; 4.1.3-9 (latest in sid) is broken due to a build
problem, and only fixes a minor issue anyhow.

> An upgrade to 4.1.3-8 apparently cured the problem; I don't know how
> close the Debian package maintainer Steiner Gundersson works with autofs
> people, and whether he's introduced some patches that have not been in
> the previous version (and may have found their way into 4.1.4).

I'm at least here on the list, and we're currently trying to sync most of the
Debian packages into 4.1.4 (upstream has already done most of them); see the
other discussion today. :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
