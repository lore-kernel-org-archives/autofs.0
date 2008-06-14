From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 00/10] Kernel patch series
Date: Sat, 14 Jun 2008 11:30:18 +0800
Message-ID: <1213414218.18072.22.camel@raven.themaw.net>
References: <20080612044425.25151.58126.stgit@raven.themaw.net>
	<Pine.LNX.4.64.0806131746240.19942@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0806131746240.19942@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>


On Fri, 2008-06-13 at 18:13 -0700, Jim Carter wrote:
> On Thu, 12 Jun 2008, Ian Kent wrote:
> 
> > Here are the kernel patches I recommend we use while testing
> > the submount hang problem.
> > 
> > Some are upstream in recent kernels while others address known
> > problems. They were amde against a 2.6.24 source base but should
> > apply to earlier kernels. They may not be in thier final state
> > as testing is still being done.
> > --snip--
> > Ian Kent (8):
> >       autofs4 - fix pending mount race.
> >       autofs4 - use lookup intent flags to trigger mounts
> >       autofs4 - don't release directory mutex if called in oz_mode
> >       autofs4 - use look aside list for lookups
> >       autofs4 - don't make expiring dentry negative
> >       autofs4 - fix mntput, dput order bug
> >       autofs4 - fix sparse warning in waitq.c:autofs4_expire_indirect()
> >       autofs4 - check for invalid dentry in getpath
> > 
> > Jeff Moyer (2):
> >       autofs4 - use struct qstr in waitq.c
> >       autofs4 - fix incorrect return from root.c:try_to_fill_dentry()
> 
> Unfortunately some of the patches didn't go on cleanly.  I'm using kernel 
> 2.6.22.17, specifically SuSE's kernel-source-2.6.22.17-0.1 updated package 
> and the "default" kernel.  Applying to a pristine copy of the source I had 
> these failures:
> 
> autofs4-dont-make-expiring-dentry-negative  
>     #I had to do this one by hand, but I'm pretty sure I got the right
>     #locations and there were no screwups.
> autofs4-use-look-aside-list-for-lookups 
>     #Hunk 8 at 763: in root.c in autofs4_dir_symlink 
>     #after inode = autofs4_get_inode(dir->i_sb, ino); at 698 and ENOMEM 
>     #test my source (outside the patch) has d_instantiate(dentry, inode); 
>     #yours has d_add(dentry, inode);  I did not make this change.
>     #Hunk 12 at 914 in autofs4_dir_mkdir
>     #Identical code; I left this one alone also.

This isn't good.

I'll need to make a set of patches for 2.6.22 as it sounds like there is
at least one prior patch not present.

Don't waste any more time on this until I can get an updated patch set
to you.

> 
> In addition, there was a compilation error, an instance of "unhashed", 
> which I changed to "expiring".  This was in root.c in autofs4_lookup at
> 552, in the if(expiring) block, it said dentry = unhashed (which is 
> undefined) and I changed it to dentry = expiring.  
> 
> Surely one of these hacks was a misjudgment.  After I stopped the daemon, 
> removed the module, installed the new module, and restarted the daemon,
> on the first attempt to automount something (all my automounts involve 
> submounts), it complained in syslog:
> 
> Jun 13 17:40:14 serval automount[11652]: do_mount_autofs_indirect: failed 
>     to mount autofs path /net/julia
> Jun 13 17:40:14 serval automount[11652]: rmdir_path: lstat of /net/julia 
>     failed
> Jun 13 17:40:14 serval automount[11652]: handle_mounts: mount of /net/julia 
>     failed!
> Jun 13 17:40:14 serval automount[11652]: mount_mount: mount(autofs): failed 
>     to create submount for /net/julia
> 
> (This was repeated every few seconds, likely because my shell was statting 
> this dir repeatedly.)  When I stopped the daemon I got a kernel panic.
> 
> Likely there's no point debugging this -- blame it on version skew.  And of 
> course it's going to take some digging to find out for sure just which 
> patches have been applied to these kernel sources.  How do you suggest we 
> proceed?  

You could just try without the kernel patches.
I'm not sure how it will go but it sounds like this kernel doesn't have
(fairly) recent patches that are meant to fix a deadlock issue which you
might encounter.

For some reason I though you were working from a 2.6.24 kernel, sorry.

Ian
