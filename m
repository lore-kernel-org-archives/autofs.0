From: Ian Kent <raven@themaw.net>
Subject: Re: Map overrides
Date: Thu, 13 Jul 2006 18:32:25 +0800
Message-ID: <1152786745.22284.2.camel@raven.themaw.net>
References: <20060712013858.GA29064@mail.iSKUNK.ORG>
	<1152674321.2930.28.camel@raven.themaw.net>
	<20060712041816.GC29064@mail.iSKUNK.ORG>
	<1152705813.2930.34.camel@raven.themaw.net>
	<20060713021103.GG29064@mail.iSKUNK.ORG>
	<1152765179.2929.11.camel@raven.themaw.net>
	<20060713074313.GH29064@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060713074313.GH29064@mail.iSKUNK.ORG>
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
Content-Type: text/plain; charset="us-ascii"
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

On Thu, 2006-07-13 at 03:43 -0400, Daniel Richard G. wrote:
> On Thu, 2006 Jul 13 12:32:59 +0800, Ian Kent wrote:
> > 
> > And having a quick look at the code suggests that it could be made to
> > function the way you require with some minor changes.
> 
> So this is all in lookup_multi.c, eh? Interesting.
> 
> This looks like it should do the trick... but since I'm not yet up on all 
> the subtleties, what sort of changes do you anticipate this needing?

The only thing I noticed in the brief look I had was that in the library
initialization routine it gives up if it can't open a map which is not
what we want. Changing it to succeed if at least one map works may be
all that's needed.

Ian
