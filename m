From: Arun Sharma <arun.sharma@intel.com>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 17:08:58 -0700
Sender: nfs-admin@lists.sourceforge.net
Message-ID: <3F62601A.5000105@intel.com>
References: <200309122333.h8CNXbW09877@moisil.badula.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <nfs-admin@lists.sourceforge.net>
In-Reply-To: <200309122333.h8CNXbW09877@moisil.badula.org>
Errors-To: nfs-admin@lists.sourceforge.net
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ion Badulescu <lists@news.cs.columbia.edu>
Cc: nfs@lists.sourceforge.net, autofs@vger.kernel.org

Ion Badulescu wrote:
> 
> I don't know if it's the same issue, but I've seen it many many times 
> while testing amd's autofs functionality. It occurs when a non-empty 
> autofs filesystem is unmounted, e.g. if it has some leftover 
> subdirectories from previous mounts. Therefore I'd say it's quite 
> clearly an autofs issue, at least in my case.

Do you have a case that can deterministically reproduce the issue ? 

> Do you see it when shutting down the automounter, or in other cases as 
> well?

Everytime I've seen it, it's during an unmount by /usr/sbin/automount after the mount has expired. It's usually coupled with a temporarily unreachable NFS server.

	-Arun



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
