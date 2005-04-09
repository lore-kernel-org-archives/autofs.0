From: Martin Ruppert <ruppert@Fh-Worms.de>
Subject: Re: autofs>3.9.99-4.0.0pre10-16 doesn't work any more for
	me
Date: Sat, 09 Apr 2005 17:53:33 +0200
Message-ID: <ify8bsndz6.fsf@mago.linux-lounge.it.fh-worms.de>
References: <E1DD8yC-0005oi-61@mago.wo.de> <20050409120352.GA12001@uio.no>
	<ifbr8o6m1u.fsf@mago.linux-lounge.it.fh-worms.de>
	<20050409151430.GA4432@uio.no>
Reply-To: ruppert@Fh-Worms.de
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050409151430.GA4432@uio.no> (Steinar H. Gunderson's message
	of "Sat, 9 Apr 2005 17:14:30 +0200")
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
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: autofs@linux.kernel.org, 300648@bugs.debian.org, ruppert@mago.linux-lounge.it.fh-worms.de

Hello,

On Sat, 9 Apr 2005 17:14:30 +0200, Steinar H Gunderson wrote:
> On Sat, Apr 09, 2005 at 04:51:09PM +0200, Martin Ruppert wrote:
>> i not only mount one partition, but a whole system (df -T shortened):
>> 
>> /dev/hda8      xfs ... /mnt/auto/hda8
>> /dev/hda5     ext2 ... /mnt/auto/hda8/boot
>> /dev/m/vm-u0   xfs ... /mnt/auto/hda8/usr
>> /dev/m/vm-v0   xfs ... /mnt/auto/hda8/var

> Hm, sounds like multimount stuff. I have absolutely no experience with that;
> Cc-ing upstream. (Ian: I have no idea whether this is supposed to work at all
> or not, I've never seen anything like this before. Keeping the rest of the
> mail intact so you get it all :-) )

> BTW, you _are_ aware that the default /etc/auto.master is empty now?

No, i'm not. My /etc/auto.master looks like this:

# $Id: auto.master,v 1.2 1997/10/06 21:52:03 hpa Exp $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# For details of the format look at autofs(5).
/mnt/auto               /etc/auto.misc
/mnt/net                /etc/auto.net
#/var/autofs/misc       /etc/auto.misc
#/var/autofs/net        /etc/auto.net

is there something wrong with that? 

> /* Steinar */

Best regards
M.Ruppert
