From: Ion Badulescu <lists@cs.columbia.edu>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 20:16:27 -0400 (EDT)
Sender: nfs-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309122013380.9830-100000@moisil.badula.org>
References: <3F62601A.5000105@intel.com>
Mime-Version: 1.0
Return-path: <nfs-admin@lists.sourceforge.net>
In-Reply-To: <3F62601A.5000105@intel.com>
Errors-To: nfs-admin@lists.sourceforge.net
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: nfs@lists.sourceforge.net, autofs@linux.kernel.org

On Fri, 12 Sep 2003, Arun Sharma wrote:

> Ion Badulescu wrote:
> > 
> > I don't know if it's the same issue, but I've seen it many many times 
> > while testing amd's autofs functionality. It occurs when a non-empty 
> > autofs filesystem is unmounted, e.g. if it has some leftover 
> > subdirectories from previous mounts. Therefore I'd say it's quite 
> > clearly an autofs issue, at least in my case.
> 
> Do you have a case that can deterministically reproduce the issue ? 

Oh yeah, easily. Kill the automounter while some things are mounted,
unmount everything by hand but do not rmdir the mountpoints. When you
unmount the autofs filesystem itself, you will get the self destruct
message.

> Everytime I've seen it, it's during an unmount by /usr/sbin/automount
> after the mount has expired. It's usually coupled with a temporarily
> unreachable NFS server.

So maybe this is a different issue than the one I am describing...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
