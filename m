From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [BUG] 5.0.0_beta1: does not auto-unmount
Date: Sun, 30 Sep 2007 02:25:16 +0100
Message-ID: <200709300225.16952.vda.linux@googlemail.com>
References: <200709261123.41401.vda.linux@googlemail.com>
	<200709272114.11469.vda.linux@googlemail.com>
	<1190949750.3464.4.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1190949750.3464.4.camel@raven.themaw.net>
Content-Disposition: inline
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

> > autofs-5.0.2 still references www.kernel.org/pub/linux/daemons/autofs/v4/:
> > 
> > # grep -r /v4 .
> > ./INSTALL:     from http://www.kernel.org/pub/linux/daemons/autofs/v4.
> > ./autofs.spec:Source: ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-%{version}.tar.gz
> > ./gentoo/net-fs/autofs/autofs-5.0.2.ebuild:SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v4"
> 
> Ha, missed that completely.
> Thnks.
> 
> > 
> > What do you think about removing autofs-5.0.0_beta1.tar.* from .../v4 directory
> > in order to prevent confusion?
> 
> Yes, I'd like to but I was a bit concerned that distros that pull these
> tarballs might expect them to be present.
> 
> Maybe I could encourage an update if I did, which would be desirable.

I mean, by removing 5.0.0beta from v4 directory you will avoid having
confused users thinking that 5.0.0_beta1 is latest.

I tried 5.0.2 today, summary:

-s --stderr       missing
-f --foreground   works, not mentioned in help text

I didn't go further, can't say whether it works for me.
Will test 5.0.3 whenever you want.
--
vda
