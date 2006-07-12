From: Ian Kent <raven@themaw.net>
Subject: Re: Map overrides
Date: Wed, 12 Jul 2006 11:18:41 +0800
Message-ID: <1152674321.2930.28.camel@raven.themaw.net>
References: <20060712013858.GA29064@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060712013858.GA29064@mail.iSKUNK.ORG>
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

On Tue, 2006-07-11 at 21:38 -0400, Daniel Richard G. wrote:
> [The "next-gen LDAP schema" problem will have to simmer for a while, but in 
> the meantime, I've another little nut to crack on this list]
> 
> 
> Map overrides. I'd like to have an indirect map that is normally pulled 
> from LDAP/Hesiod/etc.---but not necessarily 100% of the time. Sometimes, a 
> key will have to map to something other than the "canonical" location, and 
> on a locally-visible-only basis at that.
> 
> 
> Real-life example: Let's say I have a straightforward NFS-homedir setup, 
> and a user "foo". So you'd typically see e.g.
> 
> 	fuzzball:/srv/users/foo on /nfshome/foo type nfs
> 
> But what if, for some reason, the workstation cannot contact the fuzzball 
> server? (Assume no server replication.) Then, I'd like to create a 
> temporary homedir, e.g.
> 
> 	/nfshome/foo -> /var/tmphomedir/foo	(symlink)
> 
> so that the user can at least log in and check mail et al.
> 
> (There are other use cases, but this is probably the least convoluted one I 
> can think of. Note: My scenario would be with AFS, but I used NFS above 
> because it really shouldn't matter.)
> 
> 
> Right now, I can sort-of get this behavior via a program map, one that 
> returns the /var/*** path when necessary. Of course, if I want LDAP/Hesiod 
> lookups to be the common case, then those have to be built into the program 
> map as well, making autofs's built-in lookup code redundant. Right now, I 
> can't say to autofs "First, check if program map A returns some 
> special-case path; if not, then use whatever directory service B says."
> 
> This would be a sort of failover for maps, in general terms: if the first 
> map doesn't succeed, try the second one, and so on. This is a bit iffy when 
> you're talking about directory services failing, because that usually 
> involves a longish timeout. But a program map can fail immediately, thereby 
> making itself transparent at the top of such a failover stack.
> 
> 
> First of all, is there a way to do this currently?
> 
> If not, should I expect any difficulty in implementing this? On the 
> configuration side, I would think that extending the syntax to support this 
> behavior should be straightforward: just allow multiple entries for the 
> same mountpoint in auto.master.

This is done (not to well in v4) in the mount_nfs.c module as the mount
syntax (at least in autofs maps not, mount itself) allows it.

It's not as simple to do as first appears.
To extend it to cater for multiple source formats would be really messy.

Perhaps one way to approach this would be to teach the hesoid lookup
module to convert these entries into the format that mount_nfs.c can use
to perform the selection. For example if one of the entries is localhost
then autofs will perform a bind mount. We would probably need to teach
mount_afs.c something similar. It's probably not sensible to mix AFS and
NFS in the same entry anyway.

So no, not that simple.

Ian
