From: Ian Kent <raven@themaw.net>
Subject: Re: /net (lazy mounts) doesn't see new shares
Date: Thu, 18 Oct 2007 09:25:19 +0800
Message-ID: <1192670720.3148.9.camel@raven.themaw.net>
References: <14ac2b9d0710170933u7fc05093s6d108ef0c59ca74c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <14ac2b9d0710170933u7fc05093s6d108ef0c59ca74c@mail.gmail.com>
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
To: Noam Meltzer <tsnoam@gmail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-10-17 at 18:33 +0200, Noam Meltzer wrote:
> Hi all,
> 
> I have come across the following problem with the following versions of autofs:
> autofs-5.0.1-0.rc2.42 (available with RHEL5 GA)
> autofs-4.1.3-187 (available with RHEL4 u4)
> 
> I have the following scenario:
> 1. nfs client (called "rhel5") which can access an nfs server (called
> "meydele").
> 2. this are the shares  on the nfs server:
> 
> root@meydele:~# cat /etc/exports
> /home   172.16.2.129(rw,async,no_subtree_check)
> /var    172.16.2.129(rw,async,no_subtree_check)
> /bin    172.16.2.129(rw,async,no_subtree_check)
> 
> 3. I have a process which keeps /net/meydele used (for example bash
> process with current directory "/net/meydele/home/noam").
> 
> 4. I add a new share to the nfs-server (for example:
> /tmp 172.16.2.129(rw,async,no_subtree_check)
> )
> 
> 5. the nfs client will not be able to see the new share /net/meydele
> until all mounts under it will be umounted.
> 
> 6. This is what I see in syslog when I turn debugging (-d) on:
> 
> Oct 17 19:10:58 rhel5 automount[4573]: mount(nfs): mounted
> meydele:/home on /net/meydele/home
> Oct 17 19:10:58 rhel5 automount[4573]: mounted /net/meydele/home
> Oct 17 19:11:01 rhel5 automount[4573]: mount still busy /net
> Oct 17 19:11:13 rhel5 automount[4573]: attempting to mount entry
> /net/meydele/tmp
> Oct 17 19:11:13 rhel5 automount[4573]: failed to mount /net/meydele/tmp
> Oct 17 19:11:13 rhel5 automount[4573]: attempting to mount entry
> /net/meydele/tmp
> Oct 17 19:11:13 rhel5 automount[4573]: failed to mount /net/meydele/tmp
> Oct 17 19:11:13 rhel5 automount[4573]: attempting to mount entry
> /net/meydele/tmp
> Oct 17 19:11:13 rhel5 automount[4573]: failed to mount /net/meydele/tmp
> 
> 
> 
> Is there any way to work around this problem?

Not really.

> I suspect that the problem is because automount calls /etc/auto.net
> for /net/meydele only when there are nothing mounted there, otherwise
> it calls a cached map in the memory. (but maybe I'm wrong, I haven't
> read the source code)

From the viewpoint of autofs v4 it has to mount all exports at first
access and can't see changes until the tree is expired away.

As far as autofs v5 goes the problem is similar.
I tried to make the hosts map sensitive to export changes but found this
problematic because of the potential dependencies on already mounted
nested mounts within the mount tree.

Improvements to the hosts map in version 5 aren't planned at the moment
I'm sorry, given the difficulty of making this work.

Ian
