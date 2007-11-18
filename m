From: Ian Kent <raven@themaw.net>
Subject: Re: ENOENT on first reference to an automounted file
Date: Sun, 18 Nov 2007 11:46:03 +0900
Message-ID: <1195353963.3087.22.camel@raven.themaw.net>
References: <mailman.446.1194400455.3098.autofs@linux.kernel.org>
	<A44FC620-7AAA-445C-B93F-13EA66AA7DF7@isolar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A44FC620-7AAA-445C-B93F-13EA66AA7DF7@isolar.dyndns.org>
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
To: autofs@linux.kernel.org

On Sat, 2007-11-17 at 13:25 -0800, Greg Earle wrote:
> On Nov 6, 2007, at 8:53 PM EST, Dan Halbert <halbert@everyzing.com>  
> wrote:
> 
> > Greg Earle wrote:
> >> We use NIS for our maps, but just for fun, I decided to test
> >> turning "--ghost" *on* (we default to it off, and we also use
> >> "-nobrowse" on our Suns, so we like to keep them consistent),
> >> and ...
> >>
> > Greg, try the latest kernel, 2.6.9-55.0.12, which is now available  
> > from
> > RedHat and has also gone downstream to various other RH-source-based
> > distributions. This works for us. I agree your ghost/non-ghost
> > differences are odd and do not match my experience. But I see
> > differences also based on client load.
> 
> I see that Red Hat just announced/released RHEL 4 Update 6
> yesterday:
> 
> https://www.redhat.com/archives/nahant-list/2007-November/msg00068.html
> 
> It appears that this includes kernel 2.6.9-67.  Can I safely
> assume that this new release quashes this pesky ENOENT bug
> once and for all?

Try it out.
All I can say is that the 4.6 release kernel has the patches that were
used in 2.6.9-55.0.12 to resolve the problem.

> 
> More interestingly/importantly, RHEL 4 Update 6 includes autofs5
> as a "Technology Preview".  How does the autofs5 code in this
> new release compare with the mainline code in RHEL 5 Update 1,
> and is it considered robust enough to use in a production
> environment that depends heavily (as in, "life or death" -
> we use the automounter for *everything*) on automounting?

It's the same as is in RHEL 5 U1, except for some changes to allow
autofs and autofs5 to be installed at the same time. You still need to
use "one or the other", not both.

I'll be keeping RHEL 4 autofs5 in sync with RHEL 5 autofs.

Tech Preview was our only option to get this into RHEL4 as autofs
version 4 is already included as a core package, which must continue to
be included.

> 
> We started our RHEL 4 Update 5 upgrade cycle a month and a
> half ago but were stopped dead in our tracks by this bug.
> 
> Now that we have a workaround ("--ghost"), we are planning
> on pushing ahead, but I need to know whether I should try
> recommending that we instead move to Update 6 rather than
> continue to use Update 5 with a Band-Aid.

The kernel revision 2.6.9-55.0.12 isn't really a band-aid, it contains a
correction.

Whether you go 4.6 with autofs5 is a decision you'll need to make
yourself after suitable testing. There is of course the issue that a
Tech Preview isn't officially supported so you may have trouble logging
bugs. But then you can always report them here and I can log bugs if
needed. 

Ian
