From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Tue, 22 Nov 2005 23:52:06 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
	<1132674350.4039.52.camel@brilong-lnx>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1132674350.4039.52.camel@brilong-lnx>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

On Tue, 22 Nov 2005, Brian Long wrote:

> On Tue, 2005-11-22 at 09:39 -0500, Brian Long wrote:
> > I have an auto.master deployed to thousands of hosts and it looks like
> > this:
> > 
> > /misc   /etc/auto.misc          --timeout=60
> > /auto   /etc/auto.indirect      rsize=32768,wsize=32768,tcp
> > /users  auto_home               rw,hard,intr,rsize=32768,wsize=32768,tcp
> > 
> > As you can see, /users comes from NIS auto.home map.  In our case,
> > auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
> > beyond (autofs-4.1.3-130), trying to stat (ls) /users/no-such-user takes
> > roughly 12-15 seconds.  In RHEL 3 U3 (autofs-4.1.3-12), it returns
> > immediately.  This is a regression in my opinion.
> > 
> > After looking at tcpdump data, it appears automounter is downloading the
> > entire auto.home map when it fails to lookup "no-such-user".  This
> > results in a > 700KB transfer from the NIS server  :(
> > 
> > In the older autofs version, it does NOT do this.  I have opened a Red
> > Hat issue tracker (82760), but in parallel I wanted to ask this list if
> > this is known behavior and if there is any way I can disable the
> > download of the entire auto.home map using /etc/sysconfig/autofs or
> > auto.master options to the automount program.
> 
> FYI, in looking at the strace output from the automount process once it
> downloads auto.home, it goes through all 34,000+ entries and tries to
> rmdir /users/<entry>.  This fails 34,000 times.  Why the heck would it
> behave like this?

Wasn't aware I did that. That's something I'll have to sort out.

Ian
