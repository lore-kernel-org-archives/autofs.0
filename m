From: Ian Kent <raven@themaw.net>
Subject: Re: [BUG] 5.0.0_beta1: does not auto-unmount
Date: Tue, 02 Oct 2007 14:09:20 +0800
Message-ID: <1191305360.26331.53.camel@raven.themaw.net>
References: <200709261123.41401.vda.linux@googlemail.com>
	<200709272114.11469.vda.linux@googlemail.com>
	<1190949750.3464.4.camel@raven.themaw.net>
	<200709300225.16952.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709300225.16952.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Sun, 2007-09-30 at 02:25 +0100, Denys Vlasenko wrote:
> > > autofs-5.0.2 still references www.kernel.org/pub/linux/daemons/autofs/v4/:
> > > 
> > > # grep -r /v4 .
> > > ./INSTALL:     from http://www.kernel.org/pub/linux/daemons/autofs/v4.
> > > ./autofs.spec:Source: ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-%{version}.tar.gz
> > > ./gentoo/net-fs/autofs/autofs-5.0.2.ebuild:SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v4"
> > 
> > Ha, missed that completely.
> > Thnks.
> > 
> > > 
> > > What do you think about removing autofs-5.0.0_beta1.tar.* from .../v4 directory
> > > in order to prevent confusion?
> > 
> > Yes, I'd like to but I was a bit concerned that distros that pull these
> > tarballs might expect them to be present.
> > 
> > Maybe I could encourage an update if I did, which would be desirable.
> 
> I mean, by removing 5.0.0beta from v4 directory you will avoid having
> confused users thinking that 5.0.0_beta1 is latest.

Yes, I think I will remove all the v5 specific stuff from the v4
directory at the same time I post 5.0.3.

It's been quite a while and people that have version 5 should be aware
of updates and really should be using later versions.

> 
> I tried 5.0.2 today, summary:
> 
> -s --stderr       missing
> -f --foreground   works, not mentioned in help text

Are you sure you applied the additional foreground logging patch (well
actually if you test 5.0.2 you should really apply all the patches
listed in patch_order-5.0.2 to get a "current state" view).

Are you the same person that originally contributed these patches?
I have the name "Denis Vlasenko" in the original patch emails.

Anyway, I never quite completely apply the patches but what we have now
is fairly close. In particular I haven't provided a distinct "log to
stderr". Over the considerable time this has been present I've rarely
needed to use the foreground option but when I have I've always wanted
to send the log to my tty. Especially since you can just redirect the
output if you need to when running in foreground.

Ian
