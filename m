From: Ian Kent <raven@themaw.net>
Subject: Re: Fedora 8 And Autofs
Date: Wed, 13 Aug 2008 10:51:35 +0800
Message-ID: <1218595897.3148.3.camel@raven.themaw.net>
References: <13624.9146.qm@web54302.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <13624.9146.qm@web54302.mail.re2.yahoo.com>
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
To: ttran7700@yahoo.com
Cc: autofs@linux.kernel.org


On Tue, 2008-08-12 at 16:03 -0700, Thanh Tran wrote:
> I'm sorry if this is a repost.  I'm not sure if the 1st one got
> through.  I've been using autofs just fine on Fedora 5.  I recently
> upgraded to Fedora 8.  I ran yum install autofs to get the latest.
> Then, I updated my auto.master file to match my old one under Fedora

So what is in your auto.master?

>  5.  It does not seem to work.  The autofs does not seem to load my
> master mount file.  I checked hal and it's happy as a clam.  It sees

Any messages in the system log.
What has hal got to do with this?

>  new devices being added when I plug my usb cdrom and usb memory
> stick.  I looked at the autofs script in /etc/init.d and compared it
> to the one on Fedora 5 and they totally different.  Could someone
> please direct me to a tutorial?  I never had this much trouble on
> Fedora 5.
> 
> 
>       
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
