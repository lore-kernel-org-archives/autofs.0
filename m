From: raven@themaw.net
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Sat, 9 Apr 2005 11:41:08 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504091134000.1622@donald.themaw.net>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
	<1112470286.5015.20.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
	<424FC16B.4030006@poochiereds.net>
	<Pine.LNX.4.58.0504041017210.27508@wombat.indigo.net.au>
	<1112970073.21287.64.camel@barsoom.rdu.redhat.com>
	<16982.49692.27649.821821@segfault.boston.redhat.com>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 8 Apr 2005, Jeff Moyer wrote:

>
>> +/* remove a member from our doubly linked list */
>> +void lldrop(struct nfs_mount *ent)
>
> I'm not sure why you didn't just use the linked list routines found in
> sys/queue.h.
>
>> +	/* bubblesort time! */
>
> This code is *very* disgusting.  Surely there is a more elegant way to
> implement this?

Eliminate sort by ordered insertion to linked list perhaps?

btw since your in boots and all it would be much better if you worked 
against what's in CVS.

It's access in the usual way and can be found at:

pserver:anonymous@autofs.themaw.net:/root

Of course if your target is the RedHat rpm then you need to work against 
that code base.

Ian
