From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/6] autofs4 - remove string terminator check
Date: Mon, 27 Oct 2008 17:55:41 -0700
Message-ID: <20081027175541.3567e585.akpm@linux-foundation.org>
References: <20081023023513.4508.54940.stgit@raven.themaw.net>
	<20081023023522.4508.27987.stgit@raven.themaw.net>
	<20081027133131.f2011d28.akpm@linux-foundation.org>
	<1225153622.2938.1.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1225153622.2938.1.camel@zeus.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

On Tue, 28 Oct 2008 09:27:02 +0900
Ian Kent <raven@themaw.net> wrote:

> On Mon, 2008-10-27 at 13:31 -0700, Andrew Morton wrote:
> > On Thu, 23 Oct 2008 10:35:22 +0800
> > Ian Kent <raven@themaw.net> wrote:
> > 
> > > Remove unnecessary string terminator check.
> > 
> > Why is it unnecessary?
> > 
> > Does this change alter behaviour in any way?
> > 
> > Does it fix a bug?
> 
> Umm .... it was done in response to your comment, quoted below ...

umm, the number of patches I've handled recently overflowed a u16. 
Please don't rely on my memory!  Plus "read akpm's mind" isn't a very
useful changelog.

Please send a new and complete changelog for this patch?
