From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - detect invalid direct mount requests
Date: Wed, 02 Jul 2008 21:50:21 +0800
Message-ID: <1215006622.3046.75.camel@raven.themaw.net>
References: <20080620051301.9988.94307.stgit@raven.themaw.net>
	 <20080701141715.62a2132b.akpm@linux-foundation.org>
	 <1214989192.3046.34.camel@raven.themaw.net>
	 <x49tzf8pflh.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <x49tzf8pflh.fsf@segfault.boston.devel.redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org


On Wed, 2008-07-02 at 09:42 -0400, Jeff Moyer wrote:
> Ian Kent <raven@themaw.net> writes:
> 
> > On Tue, 2008-07-01 at 14:17 -0700, Andrew Morton wrote:
> >> On Fri, 20 Jun 2008 13:13:03 +0800
> >> Ian Kent <raven@themaw.net> wrote:
> >> 
> >> > autofs v5 dierct and offset mounts within an autofs filesystem are
> >> > triggered by existing autofs triger mounts so the mount point dentry
> >> > must be positive. If the mount point dentry is negative then the
> >> > trigger doesn't exist so we can return fail immediately.
> >> > 
> >> > Signed-off-by: Ian Kent <raven@themaw.net>
> >> > 
> >> > ---
> >> > 
> >> >  fs/autofs4/waitq.c |    4 ++++
> >> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >> > 
> >> > 
> >> > diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
> >> > index cd21fd4..ae637d9 100644
> >> > --- a/fs/autofs4/waitq.c
> >> > +++ b/fs/autofs4/waitq.c
> >> > @@ -307,6 +307,10 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct dentry *dentry,
> >> >  	if (sbi->catatonic)
> >> >  		return -ENOENT;
> >> >  
> >> > +	if (!dentry->d_inode &&
> >> > +	    (sbi->type & (AUTOFS_TYPE_DIRECT | AUTOFS_TYPE_OFFSET)))
> >> > +		return -ENOENT;
> >> > +
> >> >  	name = kmalloc(NAME_MAX + 1, GFP_KERNEL);
> >> >  	if (!name)
> >> >  		return -ENOMEM;
> >> 
> >> A good changelog would allow little old me to determine whether this
> >> patch should be merged into 2.6.25 and/or 2.6.26 and/or 2.6.27.  This
> >> wasn't a good changelog :(
> >
> > Sorry, I guess I shouldn't have included it along with the other more
> > serious bug fixes. It gets rid of an annoyance more than anything as the
> > daemon still has to check for it.
> >
> > It isn't important or urgent, just useful.
> 
> And I'd still like to see a comment in there!  ;)

OK.

Andrew, could you drop that patch and I'll re-submit it with a better
change log entry.

Ian



