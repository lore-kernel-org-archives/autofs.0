From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta2 release
Date: Tue, 15 Feb 2005 15:07:54 +0100
Message-ID: <20050215140754.GA26814@uio.no>
References: <Pine.LNX.4.61.0502142233210.1653@donald.themaw.net>
	<20050215014857.GA26216@uio.no> <20050215020414.GA953@uio.no>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050215020414.GA953@uio.no>
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
To: autofs@linux.kernel.org

On Tue, Feb 15, 2005 at 03:04:14AM +0100, Steinar H. Gunderson wrote:
> Any good ideas? Stripping the --exec would be the easiest solution, but
> perhaps also the ugliest...

OK, I found the bug; autofs was not stopped on prerm (this was disabled to
"fix" another bug). I've reverted the changes and made some workarounds; they
are not relevant for autofs upstream, but will be part of the next Debian
package.

/* Steinar */ 
-- 
Homepage: http://www.sesse.net/
