From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs4 - expiring filesystem from under
	process
Date: Thu, 21 Apr 2005 17:34:22 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504211004020.4802@wombat.indigo.net.au>
References: <Pine.LNX.4.62.0504102044140.5212@donald.themaw.net>
	<16986.44640.269893.824019@segfault.boston.redhat.com>
	<Pine.LNX.4.62.0504202227130.8800@donald.themaw.net>
	<16998.50065.652052.980908@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16998.50065.652052.980908@segfault.boston.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Michael Blandford <michael@kmaclub.com>

On Wed, 20 Apr 2005, Jeff Moyer wrote:

> ==> Regarding Re: [PATCH 1/3] autofs4 - expiring filesystem from under process; raven@themaw.net adds:
> 
> raven> On Mon, 11 Apr 2005, Jeff Moyer wrote:
> >> ==> Regarding [PATCH 1/3] autofs4 - expiring filesystem from under
> >> process; raven@themaw.net adds:
> >> 
> >> Could also please explain how the following is handled:
> >> 
> >> expire process runs and issues AUTOFS_EXPIRE_MULTI, which sets
> >> AUTOFS_INF_EXPIRING in flags.  While the expire is in progress, another
> >> process access the directory in question, causing a call to
> >> try_to_fill_dentry.  try_to_fill_dentry sees the AUTOFS_INF_EXPIRING
> >> flag is set, and so calls autofs4_wait with notify set to NFY_NONE.
> >> However, when we take the wq sem, we find that the expire has finished,
> >> and thus create a new wq entry.  Because NFY_NONE is set, we don't tell
> >> the daemon.
> >> 
> >> So how will this process ever get woken up?
> >> 
> 
> raven> I've thought about this for quite a while and I think all that's
> raven> needed is to recognise that we're about to expire a dentry that's
> raven> not mounted anymore.
> 
> raven> Can you think of a case for which this patch fails?
> 
> I don't see how the patch you provided addresses the race between an expire
> event and a lookup.  The real issue here is that the checking of
> AUTOFS_INF_EXPIRING and the list operations associated therewith need to
> happen atomically.  Until this happens, we will have races.
> 
> The attached patch is more in line with how I think the problem should be
> fixed.  I have not yet tested or even compiled this.  Could you please look
> this over and comment?

Sorry about this but the test should be for a notify event of NFY_NONE not 
NFY_EXPIRE.

I started something similar to what you propose myself but I don't think 
it's needed to resolve the issue.

I'll reconsider, but ...

One possible issue with your proposal is that the dentry info may not 
yet exist for mount requests in directories that are not browsable (ie. 
via lookup) as at this point we have a newly created negative dentry that 
we are attempting to fill in. I'll have to check further to see if this is 
actually the case.

The point of the notify none is to "wait" until the expire operation 
is done then return a fail status so that the following lookup can perform 
the mount.

To explain.

In this case, during the path walk the cached lookup is called as the 
dentry concerned is present (it's dgot) until the very end of the expire. 
The cached lookup fails as the revalidate (NFY_NONE) returns fail and the 
dput allows d_invalidate to succeed. The path walk then calls real lookup 
which triggers a mount following the expire.

There may still be an oppertunity for a race between the time the 
autofs4_release function is called and before the dput is executed. I'll 
think more about that.

But, given the correct test, as far as the original issue you describe is 
concerned I think my recommended patch covers what's needed.

A single counter example is all that's needed.

Thanks for the help Jeff.

> 
> Do you have a reproducer test case for this, by the way?  That would be
> vastly useful.

Not easily any more. I may be able to get Nautilus to duplicate the 
situation as that's were I first saw it ages ago (but couldn't work out 
how to fix it).

This was with 2.6.0-test? but went away with later 2.6 releases.
You might be interested to know that my inability to properly fix this 
is the source nice call in the daemon.

Ian
