From: "William H. Taber" <wtaber@us.ibm.com>
Subject: Re: [RFC PATCH]autofs4: hang and proposed fix
Date: Wed, 30 Nov 2005 16:10:26 -0500
Message-ID: <438E1542.5070208@us.ibm.com>
References: <20051116101740.GA9551@RAM>	 <Pine.LNX.4.63.0511271807100.2406@donald.themaw.net>	 <438B3C34.2050509@us.ibm.com>	 <1133219572.27824.24.camel@localhost.localdomain>	 <Pine.LNX.4.58.0511290918060.26303@wombat.indigo.net.au>	 <438C82FB.50706@us.ibm.com>	 <Pine.LNX.4.58.0511300850450.32520@wombat.indigo.net.au>	 <1133369361.27824.61.camel@localhost.localdomain> <1133370251.8625.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1133370251.8625.38.camel@lade.trondhjem.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Badari Pulavarty <pbadari@gmail.com>, Ian Kent <raven@themaw.net>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>, smaneesh@in.ibm.com

Trond Myklebust wrote:
> On Wed, 2005-11-30 at 08:49 -0800, Badari Pulavarty wrote:
> 
>>On Wed, 2005-11-30 at 09:02 -0500, Ian Kent wrote:
>>
>>>On Tue, 29 Nov 2005, William H. Taber wrote:
>>>
>>>
>>>>Ian Kent wrote:
>>>>
>>>>>We'll need to do an analysis of all callers of the revalidate method.
>>>>
>>>>You are right. Searching through the sources, it would appear that I 
>>>>missed fixing autofs and devfs.  Everyone else just defines a revalidate 
>>>>routine but doesn't call one.  You may find devfs to be interesting 
>>>>because they have code to determine whether they need to release the 
>>>>i_sem lock or not.  I am working on an updated patch to include the 
>>>>changes needed for these two modules.
>>>
>>>I've looked at devfs before but that bit of code sounds interesting to me.
>>>
>>>The other thing that concerns me is that we may be increasing the latency 
>>>of some code paths that need to be really fast. I was thinking that 
>>>perhaps it might be good to try a change more in line with the locking 
>>>used in link_patch_walk (ie. i_sem free revalidate) rather than that used 
>>>in lookup_one_len. My only justification being that lookup is called to 
>>>create stuff where revalidate is called to check stuff. I've been 
>>>poking around and this change looks fairly difficult as well (I seem to 
>>>remember you also looked at this).
>>>
>>>Anyway, I'm keen to have a look at your patch.
>>>Thanks much for your interest and help.
>>>
>>>Ian
>>>
>>
>>Again, I am posting Will's latest patch on his behalf.
>>
>>Any thoughts on how acceptable are the VFS changes ?
> 
> 
> That will slow link_path_walk() for commonly accessed shared directories
> (/lib, /usr/share,...) down to a crawl.
> 
> Instead of having lock-free lookups of cached dentries, you are suddenly
> serialising everybody in the parent directory.
> 
> Cheers,
>   Trond
> 
Fair enough.  But what do we do?  The original problem was that we were 
seeing deadlocks on /net because the autofs was not releasing the parent 
i_sem when it pended in its revalidate routine.  There was a race in 
which a process could be waiting on the revalidate before the automount 
demon ran but the  automount demon needed the parent i_sem to be able to 
do the mount.

I was proposing this patch to make it easy for the automounter (and 
devfs) to be able to release the parent i_sem if they were going to 
pend.  But as I described in a previous post, I am not sure that it is 
safe in the case of a rename, to allow a filesystem to release the 
parent i_sem in any event.  Oops.  I missed the s_vfs_rename_sem in the 
superblock which serializes renames on a given filesystem.  And since 
renames across filesystems are not allowed, I guess it shouldn't be a 
problem after all.

So I guess that a sufficient fix is for the autofs to add code similar 
to that in devfs so that the revalidate code can decide whether or not 
it needs to release the parent i_sem.  The best fix would be to take the 
code out of devfs and put it into fs/namei.c as an exported function (or 
into fs.h as an inline function) so that it only has to be changed in 
one place the next time the lookup code changes.  It may be an ugly fix 
but the alternative is to be consistent in our locking when we call 
d_revalidate and I don't see an easy solution to that problem.

Will
