From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - detect invalid direct mount requests
Date: Thu, 03 Jul 2008 09:57:47 +0800
Message-ID: <1215050268.3046.84.camel@raven.themaw.net>
References: <20080620051301.9988.94307.stgit@raven.themaw.net>
	<20080701141715.62a2132b.akpm@linux-foundation.org>
	<1214989192.3046.34.camel@raven.themaw.net>
	<x49tzf8pflh.fsf@segfault.boston.devel.redhat.com>
	<1215006622.3046.75.camel@raven.themaw.net>
	<20080702095459.f3761ff4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080702095459.f3761ff4.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org


On Wed, 2008-07-02 at 09:54 -0700, Andrew Morton wrote:
> On Wed, 02 Jul 2008 21:50:21 +0800 Ian Kent <raven@themaw.net> wrote:
> 
> > > > serious bug fixes. It gets rid of an annoyance more than anything as the
> > > > daemon still has to check for it.
> > > >
> > > > It isn't important or urgent, just useful.
> > > 
> > > And I'd still like to see a comment in there!  ;)
> > 
> > OK.
> > 
> > Andrew, could you drop that patch and I'll re-submit it with a better
> > change log entry.
> 
> nope ;)

Hahahaha, OK.

> 
> Today is try-to-get-rc8-mm1-to-work day and that's likely the last
> 2.6.26-rcX-mmY.  We need to get everything we can runtime tested a bit.

Yep, understood.

Ian
