From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs4 - detect invalid direct mount requests
Date: Wed, 2 Jul 2008 09:54:59 -0700
Message-ID: <20080702095459.f3761ff4.akpm@linux-foundation.org>
References: <20080620051301.9988.94307.stgit@raven.themaw.net>
	<20080701141715.62a2132b.akpm@linux-foundation.org>
	<1214989192.3046.34.camel@raven.themaw.net>
	<x49tzf8pflh.fsf@segfault.boston.devel.redhat.com>
	<1215006622.3046.75.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1215006622.3046.75.camel@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Jeff Moyer <jmoyer@redhat.com>, linux-kernel@vger.kernel.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, 02 Jul 2008 21:50:21 +0800 Ian Kent <raven@themaw.net> wrote:

> > > serious bug fixes. It gets rid of an annoyance more than anything as the
> > > daemon still has to check for it.
> > >
> > > It isn't important or urgent, just useful.
> > 
> > And I'd still like to see a comment in there!  ;)
> 
> OK.
> 
> Andrew, could you drop that patch and I'll re-submit it with a better
> change log entry.

nope ;)

Today is try-to-get-rc8-mm1-to-work day and that's likely the last
2.6.26-rcX-mmY.  We need to get everything we can runtime tested a bit.
