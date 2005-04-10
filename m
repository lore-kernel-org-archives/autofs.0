From: Martin Ruppert <ruppert@Fh-Worms.de>
Subject: Re: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more
	for me
Date: Sun, 10 Apr 2005 18:25:45 +0200
Message-ID: <ifvf6uwqd2.fsf@mago.linux-lounge.it.fh-worms.de>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
	<20050409151430.GA4432@uio.no>
	<Pine.LNX.4.62.0504101029160.1694@donald.themaw.net>
Reply-To: ruppert@Fh-Worms.de
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0504101029160.1694@donald.themaw.net>
	(raven@themaw.net's
	message of "Sun, 10 Apr 2005 10:30:12 +0800 (WST)")
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org, 300648@bugs.debian.org, ruppert@mago.linux-lounge.it.fh-worms.de, Martin Ruppert <ruppert@Fh-Worms.de>

On Sun, 10 Apr 2005 10:30:12 +0800 (WST), raven  wrote:
> On Sat, 9 Apr 2005, Steinar H. Gunderson wrote:
>> On Sat, Apr 09, 2005 at 04:51:09PM +0200, Martin Ruppert wrote:
>>> i not only mount one partition, but a whole system (df -T shortened):
>>> 
>>> /dev/hda8      xfs ... /mnt/auto/hda8
>>> /dev/hda5     ext2 ... /mnt/auto/hda8/boot
>>> /dev/m/vm-u0   xfs ... /mnt/auto/hda8/usr
>>> /dev/m/vm-v0   xfs ... /mnt/auto/hda8/var
>> 
>> Hm, sounds like multimount stuff. I have absolutely no experience with that;
>> Cc-ing upstream. (Ian: I have no idea whether this is supposed to work at all
>> or not, I've never seen anything like this before. Keeping the rest of the
>> mail intact so you get it all :-) )

> So what exactly is the problem?

> I can't see any failures in the log.

yes, because the log is of autofs-3.9.99-4.0.0pre10-16, and any higher
version doesn't work any more, as the subject says. 

> Ian

M.Ruppert
