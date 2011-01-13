From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.4 and 5.0.5 do not remove ghost entries
 upon SIGHUP
Date: Thu, 13 Jan 2011 15:50:42 +0800
Message-ID: <1294905042.2757.42.camel@perseus>
References: <20110111183424.7f0f7ad4@cs.bgu.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=BjaCjchKELRzmz3k3WFagPWtFtk=;
	b=YcuY3Po90gJcJ+vd9GbEewml5sWu4TumDe08sZZJlgn9JRHEs+3bd/t5+T9CJum6j5TT1WN4yMGYQ1fb5B/UpVqzjPCxodnEOvws+81fu3A1aVFnbcVzDO5+mSDlvmfnC+Htg+YnvmA1dKqRfDSZlPSVfcBH77JyyWlVsqqXpeo=
In-Reply-To: <20110111183424.7f0f7ad4@cs.bgu.ac.il>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Orlov <orlovm@cs.bgu.ac.il>
Cc: autofs@linux.kernel.org

On Tue, 2011-01-11 at 18:34 +0200, Michael Orlov wrote:
> Hi,
> 
> (I have sent this message on Oct 27, but nothing appears in the
> archives for that month - hopefully it's not a duplicate message.)
> 
> I think this is a bug - if it is not, I will be glad if someone
> corrects me. I am using autofs on Gentoo.

You will need to duplicate this with all the current 5.0.5 patches on
kernel.org applied to get serious interest in this here.

> 
> In auto.master, put
>   /mnt/test  /etc/auto.test  --ghost
> 
> In auto.test, put
>   floppy -fstype=auto :/dev/fd0
> (or anything similar)
> 
> 1. start autofs
> 2. see that /mnt/test/floppy exists
> 3. remove or comment out the "floppy" line in auto.test
> 4. send SIGHUP to autofs
> 
> After these actions, in autofs 5.0.4 / 5.0.5 (but not
> 5.0.3), /mnt/test/floppy still exists - it is not removed after SIGHUP.
> 
> This is problematic, for example, when auto.test is maintained via
> udev. Full restart of a service from a udev-invoked script is very
> error-prone.
> 
> Thanks,
> Michael
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
