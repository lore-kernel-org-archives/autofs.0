From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Fri, 8 Apr 2005 13:40:44 -0400
Message-ID: <16982.49692.27649.821821@segfault.boston.redhat.com>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
	<1112470286.5015.20.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
	<424FC16B.4030006@poochiereds.net>
	<Pine.LNX.4.58.0504041017210.27508@wombat.indigo.net.au>
	<1112970073.21287.64.camel@barsoom.rdu.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1112970073.21287.64.camel@barsoom.rdu.redhat.com>
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
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [PATCH] replicated mounts fix, also possible bug in beta2?; Jeffrey Layton <jtlayton@poochiereds.net> adds:

> Ok, here's an updated patch. I did end up using 'indent' to do it. This
> is the first time I've used it, but it seems to have done a pretty
> decent job.

Yeah. the only issue there is that now you've got some bits of patch that
just change the white space surrounding existing code.

> Some of the lines are still over 80 cols, but most of those are strings
> in debug statements that are in heavily nested sections of code -- it
> was either go over 80 columns or violate the 8 char tab rule. I went
> with the former. Let me know what you think.

Exceeding 80 characters often means that there is too much nesting going on
in your function.  This can be alleviated by breaking it up into smaller
pieces (helper functions).  Other times, you'll find that you can reformat
your logic to make it easier to read on the 80 column screens.


I've enclosed some initial comments on your implementation.  These all deal
with coding style, and one obvious-looking bug.  Please do not be
disheartened by this commentary.  You've bit off a big piece of pie for a
first C project.  This was a needed overhaul, and we all thank you for
stepping up to the plate.

-Jeff

>--- mount_nfs.c.orig	2005-01-10 08:28:29.000000000 -0500
>+++ mount_nfs.c	2005-04-08 10:13:29.000000000 -0400
>@@ -1,4 +1,4 @@
>-#ident "$Id: mount_nfs.c,v 1.21 2005/01/10 13:28:29 raven Exp $"
>+#ident "$Id: mount_nfs.c,v 1.12 2004/05/18 12:20:08 raven Exp $"

This is disturbing.  Granted, this patch is a major update (almost
rewrite), but I hope you haven't missed any bugfixes between 1.12 and 1.21.

> -		p += strspn(p, " \t,");
> -		delim = strpbrk(p, "(, \t:");
> -		if (!delim)
> +	/* now, deal with each whitespace separated chunk in turn */
> +	int i;

Declaring variables in the middle of code is just wrong.  Please put this
at the top of the function.  You do this a couple of other places, too.
Please also fix those.

> +		} else {
> +			currentmount = calloc(1, sizeof(struct nfs_mount));
> +			if (!currentmount) {
> +				error(MODPREFIX "calloc: %m");
> +				return 1;
> +			}
> +			lastmount->next = currentmount;
> +			currentmount->host = NULL;
> +			currentmount->bind = 1;
> +			currentmount->weight = 0;
> +			currentmount->path = p;
> +			currentmount->pingstat = NOTPINGED;
> +			currentmount->pingtime = 0;
> +			currentmount->next = NULL;
> +			currentmount->prev = lastmount;

Please replace this with a structure initialization routine.  You can lump
the memory allocation in there, too.

> +			lastmount = currentmount;
>  			break;
> +		}

Simply return 0 here.

> +			/* if it's a ',' turn it into a \0 */
> +			if (delim && *delim == ',') {
>  				*delim = '\0';
> -				w = atoi(weight);
> +				p = ++delim;

This sort of comment is useless.  Get rid of it.

> +			} else {
> +				break;
>  			}

No need for the braces, here.

> +/* remove a member from our doubly linked list */
> +void lldrop(struct nfs_mount *ent)

I'm not sure why you didn't just use the linked list routines found in
sys/queue.h.

> +	/* bubblesort time! */

This code is *very* disgusting.  Surely there is a more elegant way to
implement this?


Well, that should give you enough to work on for now.  I'll review in more
detail on the next iteration.

Thanks,

Jeff
