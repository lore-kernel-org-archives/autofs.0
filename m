From: raven@themaw.net
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 23:23:54 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502152323340.8319@donald.themaw.net>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no> <20050215020414.GA953@uio.no>
	<20050215140754.GA26814@uio.no>
	<Pine.LNX.4.61.0502152246210.8175@donald.themaw.net>
	<20050215152604.GA4112@uio.no>
Mime-Version: 1.0
In-Reply-To: <20050215152604.GA4112@uio.no>
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

On Tue, 15 Feb 2005, Steinar H. Gunderson wrote:

> On Tue, Feb 15, 2005 at 10:47:12PM +0800, raven@themaw.net wrote:
>>> OK, I found the bug; autofs was not stopped on prerm (this was disabled to
>>> "fix" another bug). I've reverted the changes and made some workarounds;
>>> they are not relevant for autofs upstream, but will be part of the next
>>> Debian package.
>> Except I'd like a patch for my Debian kit please.
>
> http://home.samfundet.no/~sesse/autofs_handle-upgrades-cleanly.diff is
> basically what I've done.

Thanks.
Ian
