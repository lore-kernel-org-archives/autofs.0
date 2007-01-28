From: Ian Kent <raven@themaw.net>
Subject: Re: Race condition in autofs 4.1.4
Date: Sun, 28 Jan 2007 15:40:57 +0900
Message-ID: <1169966458.3554.11.camel@raven.themaw.net>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1169864306.3595.17.camel@raven.themaw.net>
	<20070127131016.GA18035@pool.math.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070127131016.GA18035@pool.math.tu-berlin.de>
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

On Sat, 2007-01-27 at 14:10 +0100, Jan Christoph Nordholz wrote:
> Hi Ian and Lukas,
> 
> (stepping up as the new maintainer of autofs in Debian, taking over the
> work of Steinar Gundersson)

Cool.

> 
> I'm discussing the matter with the util-linux maintainer: the patch in
> question question is included in Debian's autofs package, but not in
> util-linux. I've only had time for a quick glance though, because I'll
> leave for a week of vacation soon. I'll keep you informed.

And that patch is also in the patches directory of the 5.0.1-rc3
tarball. It is mainly to demonstrate the bug so people know what to
check. It did seem to improve things somewhat but is not a complete
solution but is all we have atm.

It's been quite a while since I looked at this so it's difficult to
remember, but ...

I think the main problem was in the function lock_fatab().

The close at the bottom of the loop was in the wrong position which was
causing the flock to be released frequently for all waiting process.
This caused the retry count to be used up quickly leading to an
additional waiter going ahead anyway, without the lock, along with the
lock holder which often resulted in corruption in /etc/mtab.

Ian
