From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs vs shrink_dcache_for_umount() problem
Date: Sat, 01 Jul 2006 09:45:36 +0800
Message-ID: <1151718336.2923.18.camel@raven.themaw.net>
References: <20060630032426.671acfac.akpm@osdl.org>
	<20060630030950.d9c75915.akpm@osdl.org>
	<12824.1151661289@warthog.cambridge.redhat.com>
	<200606300729.k5U7TXbs030525@shell0.pdx.osdl.net>
	<15084.1151661496@warthog.cambridge.redhat.com>
	<28248.1151662595@warthog.cambridge.redhat.com>
	<22007.1151667101@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <22007.1151667101@warthog.cambridge.redhat.com>
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
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, neilb@suse.de, aviro@redhat.com, autofs@linux.kernel.org

On Fri, 2006-06-30 at 12:31 +0100, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > But why was yum (or an RPM script) dinking with loop and
> > mounting/unmounting things?
> 
> It may have restarted the automounter... this may cause mounts and unmounts...
> 
> I've done a bit of probing, and when both ext3 and NFS go into the superblock
> squidger with a tree that only has a root dentry, that root dentry has a usage
> count of 1:
> 
> 	### Shrink root c629b088{1}
> 	-->shrink_dcache_for_umount_subtree(c629b088)
> 	- AT c629b088{0}
> 	  - consume c629b088{0}
> 	### Shrunk
> 
> 
> 	### Shrink root c621d710{1}
> 	-->shrink_dcache_for_umount_subtree(c621d710)
> 	- AT c621d710{0}
> 	  - consume c621d710{0}
> 	### Shrunk
> 
> But when autofs4 goes in there with a minimal tree:
> 
> 	### Shrink root c6b714b0{2}
> 	-->shrink_dcache_for_umount_subtree(c6b714b0)
> 	- AT c6b714b0{1}
> 	  - consume c6b714b0{1}
> 	BUG: Dentry c6b714b0{i=1a80,n=/} still in use (1) [unmount of autofs autofs]
> 	------------[ cut here ]------------
> 	kernel BUG at fs/dcache.c:618!
> 
> It's got a usage count of *2*.  That means the root dentry is still in use
> somewhere beyond the superblock s_root reference.
> 
> I think this in autofs4_fill_super() is the problem:
> 
> 	/*
> 	 * Take a reference to the root dentry so we get a chance to
> 	 * clean up the dentry tree on umount.
> 	 * See autofs4_force_release.
> 	 */
> 	sbi->root = dget(root);
> 
> autofs4 violates the assumptions that I was told I could make.  autofs4
> expects to clean up its dentries in autofs4_put_super(), when it should
> perhaps really be overloading the kill_sb() op and doing it before calling
> kill_anon_super().

Right you are. Sorry.
Looks like I've got a bit of work to do then.

The main reason this exists is that if the daemon is summarily killed
dentrys with a non-zero reference count can be left in the tree so they
need to be culled.

I wish I'd had time to pay more attention to the work your doing David.
A super brief overview would be really helpful if you have the time.

Sounds like all I need to do is move the function. Overloading kill_sb
sounds good. I'll investigate.

I really need to try and motivate myself to do some work on my house
this weekend so it may be a little while before I get back.

Ian
