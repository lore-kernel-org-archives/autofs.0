From: raven@themaw.net
Subject: Re: autofs - nfs with localhost
Date: Sun, 13 Feb 2005 19:32:59 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502131932000.2089@donald.themaw.net>
References: <20050209170812.GA3000@hamburg.neofonie.priv>
	<20050211121413.GB26099@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050211121413.GB26099@uio.no>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org

On Fri, 11 Feb 2005, Steinar H. Gunderson wrote:

> On Wed, Feb 09, 2005 at 06:08:12PM +0100, Rasmus Hahn wrote:
>> For some reason the automounter believes in beeing smarter than me,
>> and instead of mounting using the nfs daemon it could find on port 12215
>> it uses a `mount --bind' to mount the root filesystem without nfs.
>
> While we're at this; how would this work with NFSv4, which has a virtual
> root (ie. localhost:/foo/bar might map to /exports/nfsv4/foo/bar or whatnot)?
> Does autofs currently contain support for this?

Not especially.

I haven't put any time into v4 yet.

Ian
