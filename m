From: raven@themaw.net
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Sun, 3 Apr 2005 12:03:22 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
	<1112470286.5015.20.camel@tleilax.poochiereds.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1112470286.5015.20.camel@tleilax.poochiereds.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org


Thanks for that.

As you probably realise adding this to the current beta is not a good idea 
as this needs to stabilise to go to release. Making a significant change 
like this at this time is a bad idea. So it's 4.1.5. At least your not 
alone, I have a couple of other patches.

I'll have a look.

One think I noticed is that there are places where there's a 4 character 
indent. While that's present in other places in the code I prefer a 
straight 8 char tab for all indents. Long lines are really bad as well 
and we should try our best to keep them short. I try to keep lines to 80 
chars (but often don't succeed).

The usual thinking is that if the code needs to be indented to far it 
needs to be restructured.

Anyway they're my goals.

On Sat, 2 Apr 2005, Jeff Layton wrote:

> On Sun, 2005-04-03 at 00:53 +0800, raven@themaw.net wrote:
>> Yes. That part of the code is a bit broken.
>> I've been working on it and I hope beta3 will work better.
>>
>> One of the things that the replcated server code is meant to do is avoid
>> trying to mount to servers that aren't responding. How does your
>> implementation handle this?
>>
>> One of the things that needs to be done here as well is to implement a
>> proximity metric. Like order of precedence of localhost, local subnet and
>> rest of world. How do you sort your list of hosts?
>>
>
> The code sorts by "bindness" (determines whether the mount is on the
> local machine), weight, and then RPC ping time in that order.  Hosts
> whose names cannot be resolved are dropped from the list. Hosts that do
> not respond to pings are sorted to the end of the list. When pinging
> hosts, I start with a 100ms ping time and then fall back to a 10s ping
> time if the host doesn't respond with the short timeout. This patch also
> configures the ping check by the mount options -- if the mount options
> specify tcp,nfsvers=3, the ping check is done accordingly.
>
> I only ping hosts in order to differentiate between them. That way we
> minimize the time that it would take to ping all of the hosts in the
> list if we have some that are close enough to not time out on the short
> ping.
>
> I do not sort by "local subnet" as you mention above, as the existing
> code doesn't either. The manpage says it does, but the is_local_addr()
> code only checks to see if the address of the host matches an address on
> the local machine. I'd like to add that in a later patch, but I'm
> concentrating on moving the code to this scheme first without losing any
> existing functionality.
>
>
>>>
>>> The problem I've hit is that the latest version (autofs-4.1.4_beta2)
>>> seems to break replicated mounts. The newest version no longer seems to
>>> pass the entire mount string to mount_mount() in mount_nfs.c -- it only
>>> seems to pass the first mount in a (whitespace separated) list. This is
>>> a show-stopper for my patch, but also seems to break replicated mounts
>>> in the existing code as well (unless I'm missing something).
>>
>> That can't be right.
>> get_best_mount is called in mount_mount with the mount entry string to
>> check ping times etc.
>>
>
> My code actually does away with get_best_mount() and replaces it with
> two routines, parse_mount_string() and sort_mounts(). In any case, the
> beta2 code seems to have broken something as it doesn't seem to pass the
> entire mount string to mount_mount() as the 4.1.3 code did. Can you
> confirm whether that's the case, or whether I'm doing something horribly
> wrong?
>
>>>
>>> In any case, the current revision of my mount_nfs.c is at:
>>>
>>> http://poochiereds.net/svn/autofs/autofs-4.1.4_beta2/modules/mount_nfs.c
>>
>> I can'r seem to view this.
>> Patches are really the only way to do this.
>>
>
> I'll cut and paste the diff below...
>
>>>
>>> I can generate diffs if you like, but the patch is pretty large (an
>>> overhaul, really), so it's probably easier to look at the file itself.
>>>
>>> I believe it retains all of the current functionality of mount_nfs.c,
>>> but I can't really test on the latest rev it until I work out the
>>> problem above. I got the basic code working on the RHEL-patched version
>>> of autofs, so it's pretty close.
>>
>> One of the biggest problems is ensuring existing functionality is
>> retained. It's really hard work.
>>
>
> Indeed, my overarching goal is not to produce any regressions. With a
> change this big, it might be tough, but I think I've made a good effort
> at it. My testing so far (with the 4.1.3 RHEL version of the patch)
> indicates that it works, and does fail over to the next mount if the
> first fails to.
>
> Here's the patch in its current state -- it probably needs more work,
> but I think it's pretty close. It should apply cleanly to the beta2
> code. Let me know if it doesn't:
>
> -------------------------------[snip]------------------------
>
> --- mount_nfs.c.orig	2005-04-02 14:19:33.000000000 -0500
> +++ mount_nfs.c	2005-04-02 08:12:26.000000000 -0500
> @@ -1,4 +1,4 @@
> -#ident "$Id: mount_nfs.c,v 1.21 2005/01/10 13:28:29 raven Exp $"
> +#ident "$Id: mount_nfs.c,v 1.12 2004/05/18 12:20:08 raven Exp $"
> /* ----------------------------------------------------------------------- *
>  *
>  * mount_nfs.c - Module for Linux automountd to mount an NFS filesystem,
> @@ -6,6 +6,7 @@
>  *
>  *   Copyright 1997 Transmeta Corporation - All Rights Reserved
>  *   Copyright 1999-2000 Jeremy Fitzhardinge <jeremy@goop.org>
> + *   Copyright 2005 Jeff Layton/Red Hat <jlayton@redhat.com>
>  *
>  *   This program is free software; you can redistribute it and/or modify
>  *   it under the terms of the GNU General Public License as published by
> @@ -31,12 +32,47 @@
> #include <netinet/in.h>
> #include <linux/nfs.h>
> #include <linux/nfs2.h>
> +#include <linux/nfs3.h>
> +#include <stdlib.h>
>
> #define MODULE_MOUNT
> #include "automount.h"
>
> #define MODPREFIX "mount(nfs): "
>
> +/*
> + * FIXME: this should really be determined dynamically, though this should be
> + * large enough for any sane use of autofs.
> +*/
> +#define MAX_REPL_MOUNTS 128
> +
> +/* Short timeout for RPC pings */
> +#define SHORT_SECS 0
> +#define SHORT_USEC 100000
> +
> +/* Long timeout for RPC pings */
> +#define LONG_SECS 10
> +#define LONG_USEC 0
> +
> +/* ping status enum */
> +enum pingstat {
> +    NOTPINGED    = 0,
> +    SHORT_TIMEO  = 1,
> +    LONG_TIMEO   = 2,
> +    SUCCESS      = 3 };
> +
> +/* define a structure for encapsulating an nfs mount */
> +struct nfs_mount {
> +        char *host;
> +        char *path;
> +        int weight;
> +	int local;
> +	int bind;
> +	int pingstat;
> +	double pingtime;
> +	struct nfs_mount *next,*prev;
> +};
> +
> int mount_version = AUTOFS_MOUNT_VERSION;	/* Required by protocol */
>
> static int udpproto;
> @@ -59,14 +95,15 @@
> 	else
> 		port_discard = htons(9);	/* 9 is the standard discard port */
>
> -	/* Make sure we have the local mount method available */
> +	/* Make sure we have the bind mount method available */
> 	if (!mount_bind)
> 		mount_bind = open_mount("bind", MODPREFIX);
>
> 	return !mount_bind;
> }
>
> -int is_local_addr(const char *host, const char *host_addr, int addr_len)
> +/* check to see if the server's address is an address on the client itself */
> +int is_bind_addr(const char *host, const char *host_addr, int addr_len)
> {
> 	struct sockaddr_in src_addr, local_addr;
> 	int src_len = sizeof(src_addr);
> @@ -105,253 +142,379 @@
>
> 	return 1;
> }
> +
> /*
> - * Given a mount string, return (in the same string) the
> - * best mount to use based on weight/locality/rpctime
> - * - return -1 and what = '\0' on error,
> - *           1 and what = local mount path if local bind,
> - *     else  0 and what = remote mount path
> + * Given a copy of the mount string (p) and a pointer to a nfs_mount struct
> + * (listhead), parse the mount string and populate a linked list with
> + * nfs_mount structs. Return 1 on error and 0 on success.
>  */
> -int get_best_mount(char *what, const char *original, int longtimeout, int skiplocal)
> -{
> -	char *p = what;
> -	char *winner = NULL;
> -	char *is_replicated = NULL;
> -	int winner_weight = INT_MAX, local = 0;
> -	double winner_time = 0;
> -	char *delim;
> -	int sec = (longtimeout) ? 10 : 0;
> -	int micros = (longtimeout) ? 0 : 100000;
> -
> -	if (!p) {
> -		*what = '\0';
> -		return -1;
> +int parse_mount_string(char *p,struct nfs_mount *listhead) {
> +    char *delim;
> +    char *entity[MAX_REPL_MOUNTS];
> +    char *currentpath = "";
> +    int numwords = 0; /* number of whitespace separated words */
> +    struct nfs_mount *currentmount = NULL;
> +    struct nfs_mount *lastmount = NULL;
> +
> +    lastmount = listhead;
> +
> +    /* break up mountstring into whitespace separated pieces */
> +    while (p && *p) {
> +	p += strspn(p," \t");
> +            delim = strpbrk(p, " \t");
> +            if (delim) {
> +                    *delim = '\0';
> +                    entity[numwords] = p;
> +                    p = ++delim;
> +            } else {
> +                    entity[numwords] = p;
> +                    break;
> +            }
> +        ++numwords;
> +    }
> +
> +    /* now, deal with each whitespace separated chunk in turn */
> +    int i;
> +    for (i=0; i<=numwords; ++i) {
> +	p = entity[i];
> +	debug(MODPREFIX "Working on %s",p);
> +
> +	/* get the path section out first -- everything to right of the ':' */
> +	delim = strpbrk(p,":");
> +	if (delim) {
> +	    *delim = '\0';
> +	    currentpath = ++delim;
> +	/* if there is no ':', then treat this as a bind mount and move on */
> +	} else {
> +	    currentmount = calloc(1,sizeof(struct nfs_mount));
> +	    if (!currentmount) {
> +		error(MODPREFIX "calloc: %m");
> +		return 1;
> +    	    }
> +	    lastmount->next = currentmount;
> +	    currentmount->host = NULL;
> +	    currentmount->bind = 1;
> +	    currentmount->weight = 0;
> +	    currentmount->path = p;
> +	    currentmount->pingstat = NOTPINGED;
> +	    currentmount->pingtime = 0;
> +	    currentmount->next = NULL;
> +	    currentmount->prev = lastmount;
> +	    lastmount = currentmount;
> +	    break;
> 	}
>
> -	/*
> -	 * If it's not a replicated server map entry we need
> -	 * to only check for a local mount and return the mount
> -	 * string
> -	 */
> -	is_replicated = strpbrk(p, "(,");
> -	if (skiplocal)
> -		return local;
>
> +	/* now lets break up the host/weight section */
> +	p = entity[i];
> 	while (p && *p) {
> -		char *next;
> -		unsigned int ping_stat = 0;
> -
> -		p += strspn(p, " \t,");
> -		delim = strpbrk(p, "(, \t:");
> -		if (!delim)
> -			break;
> -
> -		/* Find lowest weight whose server is alive */
> -		if (*delim == '(') {
> -			char *weight = delim + 1;
> -			unsigned int alive;
> -
> -			*delim = '\0';
> -
> -			delim = strchr(weight, ')');
> -			if (delim) {
> -				int w;
> -
> -				*delim = '\0';
> -				w = atoi(weight);
> -
> -				alive = rpc_ping(p, sec, micros);
> -				if (w < winner_weight && alive) {
> -					winner_weight = w;
> -					winner = p;
> -				}
> -			}
> -			delim++;
> -		}
> +	    currentmount = calloc(1,sizeof(struct nfs_mount));
> +	    if (!currentmount) {
> +		error(MODPREFIX "calloc: %m");
> +		return 1;
> +    	    }
> +	    lastmount->next = currentmount;
> +	    currentmount->host = p;
> +	    currentmount->weight = 0;
> +	    currentmount->path = currentpath;
> +	    currentmount->pingstat = NOTPINGED;
> +	    currentmount->pingtime = 0;
> +	    currentmount->next = NULL;
> +	    currentmount->prev = lastmount;
> +	    currentmount->bind = 0;
> +	    lastmount = currentmount;
> +
> +	    delim = strpbrk(p,",(");
> +	    /* if it's a ',' turn it into a \0 */
> +	    if (delim && *delim == ',') {
> +		*delim = '\0';
> +	        p = ++delim;
> +
> +	    /* if it's a ( then what follows is a weight */
> +	    } else if (delim && *delim == '(') {
> +		*delim = '\0';
> +		p = ++delim;
> +		delim = strpbrk(p,")");
> +		if (!delim)
> +		    return 1;
> +		*delim = '\0';
> +		currentmount->weight = atoi(p);
> +	        p = ++delim;
> +		p += strspn(p,",");
> +
> +	    /* no more delimiters, so end the loop */
> +	    } else {
> +		break;
> +	    }
> +	}
> +    }
>
> -		if (*delim == ':') {
> -			*delim = '\0';
> -			next = strpbrk(delim + 1, " \t");
> -		} else if (*delim != '\0') {
> -			*delim = '\0';
> -			next = delim + 1;
> -		} else
> -			break;
> -
> -		/* p points to a server, next is our next parse point */
> -		if (!skiplocal) {
> -			/* First, check if it's up and if it's localhost */
> -			struct hostent *he;
> -			char **haddr;
> -
> -			he = gethostbyname(p);
> -			if (!he) {
> -				error(MODPREFIX "host %s: lookup failure", p);
> -				p = next;
> -				continue;
> -			}
> +    return 0;
> +}
>
> -			/* Check each host in round robin list */
> -			for (haddr = he->h_addr_list; *haddr; haddr++) {
> -				local = is_local_addr(p, *haddr, he->h_length);
> -
> -				if (local < 0)
> -					continue;
> -
> -				if (local) {
> -					winner = p;
> -					break;
> -				}
> -			}
> -
> -			if (local < 0) {
> -				local = 0;
> -				p = next;
> -				continue;
> -			}
> +/* remove a member from our doubly linked list */
> +void lldrop(struct nfs_mount *ent) {
>
> -			if (local)
> -				break;
> -		}
> +    if ( ent->next ) {
> +        (ent->next)->prev = ent->prev;
> +    }
> +
> +    if ( ent->prev ) {
> +        (ent->prev)->next = ent->next;
> +    }
>
> -		/*
> -		 * If it's not local and it's a replicated server map entry
> -		 * is it alive
> -		 */
> -		if (!local && is_replicated && !(ping_stat = rpc_ping(p, sec, micros))) {
> -			p = next;
> -			continue;
> -		}
> +    free(ent);
> +}
>
> -		/* compare RPC times if there are no weighted hosts */
> -		if (winner_weight == INT_MAX) {
> -			int status;
> -			double resp_time;
> -			unsigned int vers = NFS2_VERSION;
> -			unsigned int proto = RPC_PING_UDP;
> -
> -			if (ping_stat) {
> -				vers = ping_stat & 0x00ff;
> -				proto = ping_stat & 0xff00;
> -			}
> +/* swap 2 adjacent list entries. Presumes that they are adjacent and that
> +   1 comes before 2. Also presumes both are valid entries. */
> +void llswap(struct nfs_mount *ent1, struct nfs_mount *ent2) {
> +    (ent1->prev)->next = ent2;
> +    ent1->next = ent2->next;
> +    if (ent2->next) {
> +        (ent2->next)->prev = ent1;
> +    }
> +    ent2->prev = ent1->prev;
> +    ent1->prev = ent2;
> +    ent2->next = ent1;
> +}
>
> -			status = rpc_time(p, vers, proto, sec, micros, &resp_time);
> -			/* did we time the first winner? */
> -			if (winner_time == 0) {
> -				if (status) {
> -					winner = p;
> -					winner_time = resp_time;
> -				} else
> -					winner_time = 6;
> -			} else {
> -				if ((status) && (resp_time < winner_time)) {
> -					winner = p;
> -					winner_time = resp_time;
> -				}
> -			}
> +/* free an entire (NULL terminated) linked list */
> +void llcleanup(struct nfs_mount *currentmount) {
> +    struct nfs_mount *nextmount;
> +    while (currentmount) {
> +	nextmount = currentmount->next;
> +	free(currentmount);
> +	currentmount = nextmount;
> +    }
> +}
> +
> +/*
> + * sort a linked list of mounts, based on "bindness", weight, and RPC ping
> + */
> +void sort_mounts(struct nfs_mount *nfs_mount_head, unsigned int vers, unsigned int proto)
> +{
> +    struct hostent *he;
> +    char **haddr;
> +    int bind, status;
> +    struct nfs_mount *currentmount = nfs_mount_head->next;
> +    struct nfs_mount *nextmount;
> +
> +    /* check for bind mount first, because we're copying Sun's broken scheme */
> +    while (currentmount) {
> +	if (currentmount->bind)
> +	    continue;
> +
> +	he = gethostbyname(currentmount->host);
> +	if (!he) {
> +	    error(MODPREFIX "host %s: lookup failure, removing from list", currentmount->host);
> +	    nextmount = currentmount->next;
> +	    lldrop(currentmount);
> +	    currentmount = nextmount;
> +	    continue;
> +	}
> +
> +	/* Check each host in round robin list */
> +	for (haddr = he->h_addr_list; *haddr; haddr++) {
> +	    bind = is_bind_addr(currentmount->host, *haddr, he->h_length);
> +	    if (bind < 0)
> +		continue;
> +
> +	    if (bind) {
> +		currentmount->bind = 1;
> +		break;
> +	    }
> +	}
> +	currentmount = currentmount->next;
> +    }
> +
> +    /* bubblesort time! */
> +    int changed = 1;
> +    debug(MODPREFIX "Starting bubblesort");
> +    while (changed) {
> +	changed = 0;
> +        currentmount = nfs_mount_head->next;
> +        while (currentmount->next) {
> +	    nextmount = currentmount->next;
> +	    debug(MODPREFIX "currentmount = %s:%s, nextmount = %s:%s", currentmount->host,currentmount->path,nextmount->host,nextmount->path);
> +
> +	    /* bind mount check */
> +	    if (currentmount->bind < nextmount->bind) {
> +		debug(MODPREFIX "bind swap currentmount=%d nextmount=%d",currentmount->bind,nextmount->bind);
> +	        llswap(currentmount,nextmount);
> +	        changed = 1;
> +	        currentmount = nextmount;
> +		continue;
> +	    } else if (currentmount->bind > nextmount->bind) {
> +	        currentmount = nextmount;
> +		continue;
> +	    }
> +
> +	    /* weight check */
> +	    if (currentmount->weight > nextmount->weight) {
> +		debug(MODPREFIX "weight swap currentmount=%d nextmount=%d",currentmount->weight,nextmount->weight);
> +	        llswap(currentmount,nextmount);
> +	        changed = 1;
> +	        currentmount = nextmount;
> +		continue;
> +	    } else if (currentmount->weight < nextmount->weight) {
> +	        currentmount = nextmount;
> +		continue;
> +	    }
> +
> +	    /* ping check -- first check if we have a ping time for each */
> +	    if (currentmount->pingstat == NOTPINGED) {
> +		status = rpc_time(currentmount->host,vers,proto,SHORT_SECS,SHORT_USEC,&currentmount->pingtime);
> +		if (!status) {
> +		    debug(MODPREFIX "short timeout ping failure for %s",currentmount->host);
> +		    currentmount->pingstat = SHORT_TIMEO;
> +		} else {
> +		    debug(MODPREFIX "short pingtime for %s == %g",currentmount->host,currentmount->pingtime);
> +		    currentmount->pingstat = SUCCESS;
> 		}
> -		p = next;
> -	}
> +	    }
>
> -	debug(MODPREFIX "winner = %s local = %d", winner, local);
> -
> -	/*
> -	 * We didn't find a weighted winner or local and it's a replicated
> -	 * server map entry
> -	 */
> -	if (!local && is_replicated && winner_weight == INT_MAX) {
> -		/* We had more than one contender and none responded in time */
> -		if (winner_time != 0 && winner_time > 5) {
> -			/* We've already tried a longer timeout */
> -			if (longtimeout) {
> -				/* SOL: Just pick the first one */
> -				winner = what;
> -			}
> -			/* Reset string and try again */
> -			else {
> -				strcpy(what, original);
> -
> -				debug(MODPREFIX
> -				      "all hosts rpc timed out for '%s', "
> -				      "retrying with longer timeout",
> -				      original);
> -
> -				return get_best_mount(what, original, 1, 1);
> -			}
> +	    if (nextmount->pingstat == NOTPINGED) {
> +		status = rpc_time(nextmount->host,vers,proto,SHORT_SECS,SHORT_USEC,&nextmount->pingtime);
> +		if (!status) {
> +		    debug(MODPREFIX "short timeout ping failure for %s",nextmount->host);
> +		    nextmount->pingstat = SHORT_TIMEO;
> +		} else {
> +		    debug(MODPREFIX "short pingtime for %s == %g",nextmount->host,nextmount->pingtime);
> +		    nextmount->pingstat = SUCCESS;
> 		}
> -	}
> -
> -	/* No winner found so bail */
> -	if (!winner) {
> -		*what = '\0';
> -		return 0;
> -	}
> -
> -	/*
> -	 * We now have our winner, copy it to the front of the string,
> -	 * followed by the next :string<delim>
> -	 */
> -
> -	/* if it's local */
> -	if (!local)
> -		strcpy(what, winner);
> -	else
> -		what[0] = '\0';
> -
> -	/* We know we're only reading from p, so discard const */
> -	p = (char *) original + (winner - what);
> -	delim = what + strlen(what);
> +	    }
> +
> +	    /* hosts that don't respond get moved to the end of the list, rather than removed */
> +	    if ( currentmount->pingstat == SUCCESS && nextmount->pingstat == SUCCESS ) {
> +		    if ( currentmount->pingtime > nextmount->pingtime ) {
> +		        debug(MODPREFIX "pingtime swap: %s == %g, %s == %g",currentmount->host,currentmount->pingtime,nextmount->host,nextmount->pingtime);
> +			llswap(currentmount,nextmount);
> +			changed = 1;
> +		    }
> +		    currentmount = nextmount;
> +		    continue;
> +	    } else if ( nextmount->pingstat == SUCCESS ) {
> +		    debug(MODPREFIX "pingstat swap: %s == %d, %s == %d",currentmount->host,currentmount->pingstat,nextmount->host,nextmount->pingstat);
> +		    llswap(currentmount,nextmount);
> +		    changed = 1;
> +	            currentmount = nextmount;
> +		    continue;
> +	    } else if ( currentmount->pingstat == SUCCESS ) {
> +	            currentmount = nextmount;
> +		    continue;
> +	    }
> +
> +	    /* we fall thru to here if neither host has a successful ping */
> +	    if ( currentmount->pingstat == SHORT_TIMEO ) {
> +		status = rpc_time(currentmount->host,vers,proto,LONG_SECS,LONG_USEC,&currentmount->pingtime);
> +		if (!status) {
> +		    debug(MODPREFIX "long timeout ping failure for %s",currentmount->host);
> +		    currentmount->pingstat = LONG_TIMEO;
> +		} else {
> +		    debug(MODPREFIX "long pingtime for %s == %g",currentmount->host,currentmount->pingtime);
> +		    currentmount->pingstat = SUCCESS;
> +		}
> +	    }
>
> -	/* Find the colon (in the original string) */
> -	while (*p && *p != ':')
> -		p++;
> +	    if ( nextmount->pingstat == SHORT_TIMEO ) {
> +		status = rpc_time(nextmount->host,vers,proto,LONG_SECS,LONG_USEC,&nextmount->pingtime);
> +		if (!status) {
> +		    debug(MODPREFIX "long timeout ping failure for %s",nextmount->host);
> +		    nextmount->pingstat = LONG_TIMEO;
> +		} else {
> +		    debug(MODPREFIX "long pingtime for %s == %g",nextmount->host,nextmount->pingtime);
> +		    nextmount->pingstat = SUCCESS;
> +		}
> +	    }
>
> -	/* skip : for local paths */
> -	if (local)
> -		p++;
> +	    if ( currentmount->pingstat == SUCCESS && nextmount->pingstat == SUCCESS ) {
> +		    if ( currentmount->pingtime > nextmount->pingtime ) {
> +		        debug(MODPREFIX "pingtime swap: %s == %g, %s == %g",currentmount->host,currentmount->pingtime,nextmount->host,nextmount->pingtime);
> +			llswap(currentmount,nextmount);
> +			changed = 1;
> +		    }
> +	    } else if ( nextmount->pingstat == SUCCESS ) {
> +		    debug(MODPREFIX "pingstat swap: %s == %g, %s == %g",currentmount->host,currentmount->pingtime,nextmount->host,nextmount->pingtime);
> +		    llswap(currentmount,nextmount);
> +		    changed = 1;
> +	    }
>
> -	/* copy to next space or end of string */
> -	while (*p && *p != ' ' && *p != '\t')
> -		*delim++ = *p++;
> +	    currentmount = nextmount;
>
> -	*delim = '\0';
> +	}
> +    }
> +    debug(MODPREFIX "Ending bubblesort");
>
> -	return local;
> }
>
> +/* the main routine -- from the info given, pick a filesystem and mount it */
> int mount_mount(const char *root, const char *name, int name_len,
> 		const char *what, const char *fstype, const char *options,
> 		void *context)
> {
> -	char *colon, *fullpath;
> -	char *whatstr;
> +	char *fullpath = NULL;
> +	char *whatstr = NULL;
> +	char *mntstrcopy = NULL;
> 	char *nfsoptions = NULL;
> -	int local, err;
> 	int nosymlink = 0;
> -	int ro = 0;            /* Set if mount bind should be read-only */
> +	int error = 0;
> +	int ro = 0;
> +        struct nfs_mount *nfs_mount_head = NULL;
> +        unsigned int vers = NFS2_VERSION;
> +        unsigned int proto = RPC_PING_UDP;
>
> -	debug(MODPREFIX "root=%s name=%s what=%s, fstype=%s, options=%s",
> +	debug(MODPREFIX " root=%s name=%s what=%s, fstype=%s, options=%s",
> 	      root, name, what, fstype, options);
>
> -	whatstr = alloca(strlen(what) + 1);
> +	/* whatstr -- this is what we pass to spawnl or mount_bind later*/
> +	whatstr = calloc(strlen(what) + 1,sizeof(char));
> 	if (!whatstr) {
> -		error(MODPREFIX "alloca: %m");
> -		return 1;
> +		error(MODPREFIX "calloc: %m");
> +		error = 1;
> +		goto cleanup;
> +	}
> +
> +	/* mount string for parsing, we chop this up in the parse routine */
> +	mntstrcopy = calloc(strlen(what) + 1, sizeof(char));
> +	if (!mntstrcopy) {
> +		error(MODPREFIX "calloc: %m");
> +		error = 1;
> +		goto cleanup;
> 	}
> -	strcpy(whatstr, what);
> +	strncpy(mntstrcopy,what,strlen(what)+1);
> +
> +	/* full path of mount point */
> +	fullpath = calloc(strlen(root) + name_len + 2, sizeof(char));
> +	if (!fullpath) {
> +		error(MODPREFIX "calloc: %m");
> +		error = 1;
> +		goto cleanup;
> +	}
> +
> +        /* declare a struct to be first linked list entry, this won't hold
> +           a real entry but should never change */
> +        nfs_mount_head = calloc(1,sizeof(struct nfs_mount));
> +        if (!nfs_mount_head) {
> +	    error(MODPREFIX "calloc: %m");
> +	    error = 1;
> +	    goto cleanup;
> +        }
>
> 	/* Extract "nosymlink" pseudo-option which stops local filesystems
> -	   from being symlinked */
> +	   from being symlinked, and check for tcp and nfsvers= options */
> 	if (options) {
> 		const char *comma;
> 		char *nfsp;
> 		int len = strlen(options) + 1;
>
> -		nfsp = nfsoptions = alloca(len + 1);
> -		if (!nfsoptions)
> -			return 1;
> -
> -		memset(nfsoptions, '\0', len + 1);
> +		/* an nfsoptions string that we'll use later */
> +		nfsp = nfsoptions = calloc(len + 1, sizeof(char));
> +		if (!nfsoptions) {
> +			error(MODPREFIX "calloc: %m");
> +			error = 1;
> +			goto cleanup;
> +		}
>
> 		for (comma = options; *comma != '\0';) {
> 			const char *cp;
> @@ -380,108 +543,145 @@
> 			      nfsoptions, nfsp, nfsoptions + len,
> 			      nfsp - nfsoptions, len);
> #endif
> -			if (strncmp("nosymlink", cp, end - cp + 1) == 0)
> +			/* if it's nosymlink, set flag and skip copying it to nfsoptions
> +			 * if the flag declares tcp or an nfs version set ping proto
> +			 * and version appropriately. Also look for 'ro' option so we
> + 			 * can pass this to mount_bind if need be.
> +			 */
> +			if (strncmp("nosymlink", cp, end - cp + 1) == 0) {
> 				nosymlink = 1;
> -			else {
> -				/* Check for options that also make sense
> -				   with bind mounts */
> -				if (strncmp("ro", cp, end - cp + 1) == 0)
> -					ro = 1;
> -				/* and jump over trailing white space */
> -				memcpy(nfsp, cp, comma - cp + 1);
> -				nfsp += comma - cp + 1;
> +				continue;
> +			} else if (strncmp("tcp", cp, end - cp + 1) == 0) {
> +				proto = RPC_PING_TCP;
> +			} else if (strncmp("nfsvers=3", cp, end - cp + 1) == 0) {
> +				vers = NFS3_VERSION;
> +			} else if (strncmp("ro", cp, end - cp + 1) == 0) {
> +				ro = 1;
> 			}
> -		}
> -
> -		debug(MODPREFIX "nfs options=\"%s\", nosymlink=%d, ro=%d",
> -		      nfsoptions, nosymlink, ro);
> -	}
>
> -	local = 0;
> -
> -	colon = strchr(whatstr, ':');
> -	if (!colon) {
> -		/* No colon, take this as a bind (local) entry */
> -		local = 1;
> -	} else if (!nosymlink) {
> -		local = get_best_mount(whatstr, what, 0, 0);
> -		if (!*whatstr) {
> -			warn(MODPREFIX "no host elected");
> -			return 1;
> +			/* and jump over trailing white space */
> +			memcpy(nfsp, cp, comma - cp + 1);
> +			nfsp += comma - cp + 1;
> 		}
> -		debug(MODPREFIX "from %s elected %s", what, whatstr);
> -	}
>
> -	fullpath = alloca(strlen(root) + name_len + 2);
> -	if (!fullpath) {
> -		error(MODPREFIX "alloca: %m");
> -		return 1;
> +		debug(MODPREFIX "nfs options=\"%s\", nosymlink=%d, nfsvers=%d, proto=%d", nfsoptions, nosymlink, vers, proto);
> 	}
>
> +	/* get full path of mountpoint */
> 	if (name_len)
> 		sprintf(fullpath, "%s/%s", root, name);
> 	else
> 		sprintf(fullpath, "%s", root);
>
> -	if (local) {
> -		/* Local host -- do a "bind" */
> -
> -		const char *bind_options = ro ? "ro" : "";
> -
> +	/* parse the mount string and get the nfs_mount struct linked list */
> +	error = parse_mount_string(mntstrcopy,nfs_mount_head);
> +	if (error)
> +	    goto cleanup;
> +
> +	/* sort the linked list */
> +	sort_mounts(nfs_mount_head,vers,proto);
> +
> +	/* now try to mount them in turn */
> +	struct nfs_mount *currentmount = nfs_mount_head->next;
> +	int status = 0;
> +	int dir_created = 0;
> +	int mounted = is_mounted(_PATH_MOUNTED,fullpath);
> +
> +	/* log final sorted list for debugging */
> +	if (do_debug) {
> +	    int i = 0;
> +	    while (currentmount) {
> +		debug(MODPREFIX "%d: host=%s, path=%s, weight=%d",i,currentmount->host,currentmount->path,currentmount->weight);
> +		currentmount = currentmount->next;
> +		++i;
> +	    }
> +	    currentmount = nfs_mount_head->next;
> +	}
> +
> +	/* error out with a debug message if it's already mounted */
> +	if (mounted)
> +		debug(MODPREFIX "BUG: %s is already mounted!",fullpath)
> +
> +	error = 1;
> +	while (currentmount && !mounted) {
> +	    error = 0;
> +            debug(MODPREFIX "attempting mount: host=%s path=%s weight=%d",currentmount->host,currentmount->path,currentmount->weight);
> +
> +	    /* see if this qualifies for a bind mount -- currentmount->bind
> +	     * is set or currentmount->host is NULL */
> +	    if ((currentmount->bind && !nosymlink) || !currentmount->host) {
> 		debug(MODPREFIX "%s is local, doing bind", name);
>
> -		return mount_bind->mount_mount(root, name, name_len,
> -					       whatstr, "bind", bind_options,
> -					       mount_bind->context);
> -	} else {
> -		/* Not a local host - do an NFS mount */
> -		int status, existed = 1;
> +		/* pass the ro flag if it was specified */
> +		const char *bind_options = ro ? "ro" : "";
>
> -		debug(MODPREFIX "calling mkdir_path %s", fullpath);
> +		error = mount_bind->mount_mount(root, name, name_len,
> +				                currentmount->path, "bind", bind_options,
> +					        mount_bind->context);
>
> +	    } else {
> +		/* otherwise this is an NFS mount */
> 		status = mkdir_path(fullpath, 0555);
> 		if (status && errno != EEXIST) {
> 			error(MODPREFIX "mkdir_path %s failed: %m", fullpath);
> -			return 1;
> -		}
> -
> -		if (!status)
> -			existed = 0;
> -
> -		if (is_mounted(_PATH_MOUNTED, fullpath)) {
> -			error(MODPREFIX
> -			  "warning: %s is already mounted", fullpath);
> -			return 0;
> +			error = 2;
> +		} else if (status) {
> +			error = 0;
> +		} else {
> +			dir_created = 1;
> 		}
>
> -		if (nfsoptions && *nfsoptions) {
> +		/* attempt to mount if there's no error */
> +		if (!error) {
> +		    sprintf(whatstr,"%s:%s",currentmount->host,currentmount->path);
> +		    if (nfsoptions && *nfsoptions) {
> 			debug(MODPREFIX "calling mount -t nfs " SLOPPY
> 			      " -o %s %s %s", nfsoptions, whatstr, fullpath);
>
> -			err = spawnll(LOG_NOTICE,
> +			error = spawnll(LOG_NOTICE,
> 				     PATH_MOUNT, PATH_MOUNT, "-t",
> 				     "nfs", SLOPPYOPT "-o", nfsoptions,
> 				     whatstr, fullpath, NULL);
> -		} else {
> +		    } else {
> 			debug(MODPREFIX "calling mount -t nfs %s %s",
> 			      whatstr, fullpath);
> -			err = spawnll(LOG_NOTICE,
> +			error = spawnll(LOG_NOTICE,
> 				     PATH_MOUNT, PATH_MOUNT, "-t",
> 				     "nfs", whatstr, fullpath, NULL);
> +		    }
> 		}
> +	    }
>
> -		if (err) {
> -			if ((!ap.ghost && name_len) || !existed)
> -				rmdir_path(name);
> +	    if (error == 2) {
> +		debug(MODPREFIX "unable to create mountpoint %s. Not attempting any further mounts!",fullpath);
> +		error = 1;
> +		break;
> +	    }
>
> -			error(MODPREFIX "nfs: mount failure %s on %s",
> -			      whatstr, fullpath);
> -			return 1;
> -		} else {
> -			debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
> -			return 0;
> +	    currentmount = currentmount->next;
> +	    mounted = is_mounted(_PATH_MOUNTED,fullpath);
> +	}
> +
> +	/* cleanup time -- remove directory if there was an error and we created it */
> +	if (error) {
> +		debug(MODPREFIX "mount of %s on %s failed!", whatstr, fullpath);
> +		if ( dir_created || (!ap.ghost && name_len )) {
> +			rmdir_path(name);
> 		}
> +	} else {
> +		debug(MODPREFIX "mounted %s on %s", whatstr, fullpath);
> 	}
> +
> +    /* clean up any memory we allocated */
> +    cleanup:
> +	free(whatstr);
> +	free(mntstrcopy);
> +	free(fullpath);
> +	free(nfsoptions);
> +	llcleanup(nfs_mount_head);
> +
> +	return error;
> +
> }
>
> int mount_done(void *context)
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
