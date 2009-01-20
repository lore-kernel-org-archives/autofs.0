From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/4] Current state of Vals patches and the file
	map	lookup patches
Date: Tue, 20 Jan 2009 14:06:39 +0900
Message-ID: <1232427999.3200.17.camel@zeus.themaw.net>
References: <20090119121918.31454.61737.stgit@zeus.themaw.net>
	<20090120032611.GB1525@shell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090120032611.GB1525@shell>
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
To: Valerie Aurora Henson <vaurora@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Paul Wankadia <junyer@google.com>

On Mon, 2009-01-19 at 22:26 -0500, Valerie Aurora Henson wrote:
> On Mon, Jan 19, 2009 at 09:24:33PM +0900, Ian Kent wrote:
> > I've pulled in the patches that Val posted and made a couple of
> > minor changes. I also have what I think is just about what we
> > need to reduce the overhead of file map scanning.
> 
> Great, thank you!
> 
> > Check'em out please folks.
> 
> I have a crumpled post-it note on my desk saying "valgrind automount."
> How hard would this be to do while running the Connectathon suite?  It
> would sure make me feel better about these patches.

Oh yeah, I need to get onto cleaning that up and send it over so you can
have a look at it and the license statement. Sorry, I will get to it.

There may be something to be gained from running valgrind against
automount and I do so from time to time. Last time I did got a bunch of
leak records but I've been unable to track them down. You may have more
success.

As far as Connectathon goes that shouldn't be too hard to do but you
might find it's a bit painful.

The way the autofs Connectathon works is you run a setup script after
setting the values you want in the configuration. I found that running
it as root and opening up permissions on the export directory of the two
NFS servers needed and then closing them after works best. After that
the test suite assumes autofs is running so you can run "valgrind
automount -f" (I think that is the only option needed) to run in
foreground. We might need to change the log output code a bit, I'm not
sure.

The real problems start when you hit autofs hard then valgrind becomes
quite challenged. The whole thing gets really slow.

> 
> > I'm a little concerned about the "fix kernel includes" patch because
> > there should be more to it and I've altered it in line with that. I'm
> > not sure if we should post a kernel patch first, pull in the updated
> > kernel header files to the tar and finally make the other couple of
> > changes then. But then I may have it wrong so check it out.
> 
> Yeah, there's a trade-off there.  I think the approach you've taken is
> the most sensible, given that nothing makes me more insane than out of
> sync user and kernel code.

So I think I'll defer that patch for a little while then.

Ian
