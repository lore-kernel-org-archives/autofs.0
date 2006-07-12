From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: Map overrides
Date: Wed, 12 Jul 2006 00:18:16 -0400
Message-ID: <20060712041816.GC29064@mail.iSKUNK.ORG>
References: <20060712013858.GA29064@mail.iSKUNK.ORG>
	<1152674321.2930.28.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1152674321.2930.28.camel@raven.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>

On Wed, 2006 Jul 12 11:18:41 +0800, Ian Kent wrote:
> 
> This is done (not to well in v4) in the mount_nfs.c module as the mount
> syntax (at least in autofs maps not, mount itself) allows it.

I should've been more clear: This would be completely apart from the 
replicated-server-selection mechanism. My example might not have been the 
best, as it presents this parallel that has to be disavowed.

Another scenario: Say that you have a (read-only) volume that's normally 
NFS-mounted. Imagine a framework that would allow you to copy that volume 
in its entirety to your local disk, and then have autofs "mount" the volume 
by symlinking the local copy. Whether it be to avoid network latency, or 
because you're on a laptop and want to go off-net.

So there's nothing going on here w.r.t. checking whether an NFS/AFS server 
is up. It's about overriding what autofs would usually do---to have a 
program map return the (special-case) local path, preempting the usual 
LDAP/Hesiod request. (And if and only if the program map gives no answer, 
go ahead and do the LDAP/Hesiod lookup.)

> It's not as simple to do as first appears.
> To extend it to cater for multiple source formats would be really messy.

My intuition was that it would involve extending struct master / 
master_mapent in some way, so that a single indirect map mountpoint could 
have multiple definitions. (Or perhaps the structure could stay the same--- 
it does appear to be in a linked list---and the restriction lifted on the 
uniqueness of indirect map mountpoints?)

I mean, what you would have in the configuration file is something like

	/mit	program,hesiod:/sbin/myprogmap
	/mit	ldap,hesiod://foo/ou=auto.indirect,dc=mit,dc=edu

i.e. two entries that could be completely independent, and are no different 
syntactically from what exists now. Just that autofs would try them in 
order when resolving a key in /mit.

> Perhaps one way to approach this would be to teach the hesoid lookup
> module to convert these entries into the format that mount_nfs.c can use
> to perform the selection. For example if one of the entries is localhost
> then autofs will perform a bind mount. We would probably need to teach
> mount_afs.c something similar.

Eeegh... I really wasn't thinking that the modules would have to be aware 
of this.

> It's probably not sensible to mix AFS and NFS in the same entry anyway.

Why not? :) Imagine a (public, read-only) volume that's normally 
AFS-mounted, but has an NFS backup. As NFS is dead easy to set up, it's a 
good option for emergency use.

> So no, not that simple.

I hope this is due to my not having conveyed the idea very well....


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
