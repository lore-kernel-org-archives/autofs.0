From: Ian Kent <raven@themaw.net>
Subject: Re: a couple of bugs in autofs
Date: Fri, 31 Oct 2008 16:32:39 +0900
Message-ID: <1225438359.2946.82.camel@zeus.themaw.net>
References: <510ca9b40810302235v6ab05c8bk117d4991bb70f198@mail.gmail.com>
	<1225436514.2946.74.camel@zeus.themaw.net>
	<510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <510ca9b40810310011o458ff36ftbcce12c850ae172e@mail.gmail.com>
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
To: Paul Wankadia <junyer@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2008-10-31 at 18:11 +1100, Paul Wankadia wrote:
> On Fri, Oct 31, 2008 at 6:01 PM, Ian Kent <raven@themaw.net> wrote:
> 
> >> auto.master:
> >>
> >>      1  /home   /etc/auto.home
> > ^^^^^^^^
> > What is this?
> >
> > Of course you have:
> > /home /etc/auto.home
> > don't you?
> 
> Yes, I simply included the line number, but I see that it was a little
> confusing. Mea culpa.

I can't reproduce this using /etc/auto.master but your loading from
another location, right?

Before you do anything else move your auto.master outside of /home,
either /home it won't be there when autofs starts or it will go away
when /home is mounted by autofs.

Ian
