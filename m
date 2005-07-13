From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs 4.1.4 no-unlink patch
Date: Wed, 13 Jul 2005 14:06:06 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0507131358420.12373@wombat.indigo.net.au>
References: <42D2CBC6.200@redhat.com>
	<Pine.LNX.4.63.0507130025160.3058@donald.themaw.net>
	<17108.3307.273123.353057@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17108.3307.273123.353057@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Chris Feist <cfeist@redhat.com>

On Tue, 12 Jul 2005, Jeff Moyer wrote:

> ==> Regarding Re: [autofs] [PATCH] autofs 4.1.4 no-unlink patch; Ian Kent <raven@themaw.net> adds:
> 
> raven> On Mon, 11 Jul 2005, Chris Feist wrote:
> >> Ian,
> >> 
> >> We've been hearing some reports of autofs removing entire home
> >> directories when mounts expire.  It appears that this could be some sort
> >> of race condition in the walk_tree code, where when the function starts
> >> the directory is unmounted and then autofs unlinks files in the the
> >> directory that is supposed to be umounted.  I've attached a patch to the
> >> rm_unwanted_fn which adds some additional checks before we unlink
> >> anything, and it prevents autofs from unlinking files (since I'm pretty
> >> sure that autofs never creates a regular file).  Let me know what you
> >> think.
> 
> raven> Yes. There doesn't seem to be enough checking and the !S_ISLNK
> raven> doesn't look quite right. Your right, the only objects in the autofs
> raven> filesystem are directories and symlinks.
> 
> raven> A mount happening during an expire might lead to this. But it
> raven> shouldn't be able to happen due to the nature of the state machine.
> 
> raven> I'll have to keep looking.
> 
> Right, it shouldn't be able to happen, I agree.  However, we've seen 2
> occurrences of this in the wild.  Even if/when we fix this problem
> properly, I would lobby to put in these extra checks.  They certainly don't
> hurt anything, and they make the code more robust.  I certainly wouldn't
> like it if autofs deleted all of my files!
> 

Of course.

I'll have a look and publish it as an important patch.

It would be good to understand what's happening as well.

I've never seen this happen before. I wonder what changes we've done in 
this area lately. Mind that !S_ISLNK has been there since 4.0.0per?? and 
looks way wrong.

Ian
