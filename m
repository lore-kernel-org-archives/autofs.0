From: Jeff Layton <jtlayton@poochiereds.net>
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Sat, 09 Apr 2005 07:53:20 -0400
Message-ID: <1113047600.5008.33.camel@tleilax.poochiereds.net>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
	<1112470286.5015.20.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
	<424FC16B.4030006@poochiereds.net>
	<Pine.LNX.4.58.0504041017210.27508@wombat.indigo.net.au>
	<1112970073.21287.64.camel@barsoom.rdu.redhat.com>
	<16982.49692.27649.821821@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16982.49692.27649.821821@segfault.boston.redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

Ok, some quick comments before I start to rework some of this:

> 
> Yeah. the only issue there is that now you've got some bits of patch that
> just change the white space surrounding existing code.
> 

I considered that, but this patch replaces more code in mount_nfs.c than
it keeps, so I figured some false deltas were warranted. That said, I
didn't see too many of those even after running it through indent, and
those that did exist probably didn't match the "standard" anyway and
should have been changed.

> Exceeding 80 characters often means that there is too much nesting going on
> in your function.  This can be alleviated by breaking it up into smaller
> pieces (helper functions).  Other times, you'll find that you can reformat
> your logic to make it easier to read on the 80 column screens.
> 

You're probably correct here. I'll have to take a look and see where I
can break out the code into subroutines in a better fashion.

> 
> I've enclosed some initial comments on your implementation.  These all deal
> with coding style, and one obvious-looking bug.  Please do not be
> disheartened by this commentary.  You've bit off a big piece of pie for a
> first C project.  This was a needed overhaul, and we all thank you for
> stepping up to the plate.
> 

Not at all. This is the sort of commentary I was looking for :-). I'm
not sure what the bug is that you mention, however.

> >--- mount_nfs.c.orig	2005-01-10 08:28:29.000000000 -0500
> >+++ mount_nfs.c	2005-04-08 10:13:29.000000000 -0400
> >@@ -1,4 +1,4 @@
> >-#ident "$Id: mount_nfs.c,v 1.21 2005/01/10 13:28:29 raven Exp $"
> >+#ident "$Id: mount_nfs.c,v 1.12 2004/05/18 12:20:08 raven Exp $"
> 
> This is disturbing.  Granted, this patch is a major update (almost
> rewrite), but I hope you haven't missed any bugfixes between 1.12 and 1.21.
> 

When I started work on the 4.1.4_beta2 patch, I actually did a diff
between the 4.1.3 and 4.1.4_beta2 mount_nfs.c file. I then brought
forward any changes that were relevant to my mount_nfs.c. IIRC, there
wasn't much:

* switch to spawnll() and get rid of explicit locking
* look for 'ro' option in nfsoptions so we can pass it to mount_bind() 

I'm going to start working against the CVS code, so I'll pay more
attention to the ident line in the future.

> Declaring variables in the middle of code is just wrong.  Please put this
> at the top of the function.  You do this a couple of other places, too.
> Please also fix those.
> 

Aye, you are correct. I'll clean that up. I'll also clean up some of the
other suggestions you gave (extraneous braces and use returns instead of
breaks).

> Please replace this with a structure initialization routine.  You can lump
> the memory allocation in there, too.
> 

Good idea, I'll start work on this part.

> I'm not sure why you didn't just use the linked list routines found in
> sys/queue.h.
> 

I didn't know they existed. I'll look over them and probably use those
routines instead of mine.

> > +	/* bubblesort time! */
> 
> This code is *very* disgusting.  Surely there is a more elegant way to
> implement this?

I'm not sure what your objection is here. Is it the fact that it's a
bubblesort? Separating the parsing and sorting seems like a good idea to
me. We could switch to a different sorting algorithm, but for the small
numbers of stuff we'll be sorting, I don't think it's worth it.

Ian mentioned doing an ordered insertion into the list. The current code
tries to avoid pinging hosts unless there is no other way to distinguish
them. I'm not sure how we'd implement this with an ordered insertion.
It's certainly possible, but will make the code more complex.

I need some idea of what you are looking for...

-- Jeff
