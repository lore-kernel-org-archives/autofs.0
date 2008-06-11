From: Ian Kent <raven@themaw.net>
Subject: Re: Is there a known problem with recent Fedora
	systems	core dumping?
Date: Wed, 11 Jun 2008 22:37:02 +0800
Message-ID: <1213195022.4994.67.camel@raven.themaw.net>
References: <E1K4BIO-0007Ps-00@mta2.cl.cam.ac.uk>
	<x49fxrk83kf.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49fxrk83kf.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Piete Brooks <Piete.Brooks@cl.cam.ac.uk>


On Wed, 2008-06-11 at 10:10 -0400, Jeff Moyer wrote:
> Piete Brooks <Piete.Brooks@cl.cam.ac.uk> writes:
> 
> > I've not managed to get a useful backtrace from the core dumps I get, but is 
> > there a known problem with the recent (6 .. 9) Fedora RPMs?
> > We use recursive mounts, but I think I've seen it when they aren't being used.
> > Basically a core dump appears in / and some part of the automount space stops 
> > working (but other bits still work).
> >
> > Under Fedora Core 6 (autofs-5.0.1-0.rc3.33) it happened to just one research 
> > group (who do things differently from everyone else), but as of Fedora 9 
> > (autofs-5.0.3-15) it appears to happen to others (e.g. me!).
> > It's intermittent (e.g. about once per day)
> >
> > Has anyone come across such a problem?

There have been a few over time but autofs-5.0.1-0.rc3.33 is way old
now. I'd recommend building a later source rpm to start with.

It is unlikely the above problems are the same.
A later package revision and more info is needed.

> 
> If you are using ldap for your maps, then yes, and upgrading openssl
> will fix your problems.  If not, then I'll have to defer to Ian on this.

But of course we've seen a recent problem on f9, not specifically autofs
though. Should be an update out for that soon though.

Ian
