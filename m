From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [ANNOUNCE] autofs 4.1.4 beta1 release
Date: Thu, 27 Jan 2005 03:02:31 +0100
Message-ID: <20050127020231.GB5087@uio.no>
References: <Pine.LNX.4.61.0501262151370.1716@donald.themaw.net>
	<20050126151344.GA841@uio.no>
	<Pine.LNX.4.61.0501262320080.1890@donald.themaw.net>
	<20050126161454.GA9417@uio.no>
	<Pine.LNX.4.58.0501270916190.20105@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501270916190.20105@wombat.indigo.net.au>
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

(I'm still on the list, no need to Cc me :-) )

On Thu, Jan 27, 2005 at 09:21:10AM +0800, Ian Kent wrote:
> The Debian side of things really refers to the merging of patches I 
> found in the packages (as best as I could) and some init script changes 
> which you are, no doubt checking.

Well, I'm afraid I can't check that you got all the Debian-specific init
script changes right, as I don't really know or understand half the problems
these patches were fixing (and the code they modified seems to have been
mostly rewritten). As long as you actually reviewed the changes, I guess we
should be OK. If there'll be a 4.1.4-beta2 (with the missing patches I
noticed), I'll be happy to put that in experimental and see if people get it
to work properly without regressions. :-)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
