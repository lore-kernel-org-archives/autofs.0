From: Ian Kent <raven@themaw.net>
Subject: Re: [BUG] 5.0.0_beta1: does not auto-unmount
Date: Tue, 02 Oct 2007 21:13:55 +0800
Message-ID: <1191330835.26331.151.camel@raven.themaw.net>
References: <200709261123.41401.vda.linux@googlemail.com>
	<200709300225.16952.vda.linux@googlemail.com>
	<1191305360.26331.53.camel@raven.themaw.net>
	<200710021033.27651.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200710021033.27651.vda.linux@googlemail.com>
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

On Tue, 2007-10-02 at 10:33 +0100, Denys Vlasenko wrote:
> On Tuesday 02 October 2007 07:09, Ian Kent wrote:
> > > I tried 5.0.2 today, summary:
> > > 
> > > -s --stderr       missing
> > > -f --foreground   works, not mentioned in help text
> > 
> > Are you sure you applied the additional foreground logging patch (well
> > actually if you test 5.0.2 you should really apply all the patches
> > listed in patch_order-5.0.2 to get a "current state" view).
> 
> Hmmm... no.
> 
> > Are you the same person that originally contributed these patches?
> > I have the name "Denis Vlasenko" in the original patch emails.
> 
> Yes. "Denys" is my country's officialdom's idea how to transliterate
> my name into Latin letters. [idiots]

HaHaha, right.

> 
> > Anyway, I never quite completely apply the patches but what we have now
> > is fairly close. In particular I haven't provided a distinct "log to
> > stderr". Over the considerable time this has been present I've rarely
> > needed to use the foreground option but when I have I've always wanted
> > to send the log to my tty. Especially since you can just redirect the
> > output if you need to when running in foreground.
> 
> I don't understand you. Currently, even it --foreground mode
> automount logs everything to syslog, IIRC.
> Hot do you redirect that? To where?

The recent patch for foreground logging will send everything to stderr
unconditionally. I should have realized you wouldn't get this bit,
sorry.

> 
> I want to be able to direct log to be on stderr or stdout
> (I log each daemon's output separately by capturing those).

Yep, got it.
Hopefully the patch I mentioned above will do what's needed.

Ian
