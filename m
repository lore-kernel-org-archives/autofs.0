From: raven@themaw.net
Subject: Re: Program map and submount problem (fwd)
Date: Sat, 24 Jan 2004 10:50:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0401241047040.1751@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Thanks to the crap mail server at my ISP here is one of several messages 
that haven't made it to the autofs list.

On the other hand the list mail server seems a little flaky. Peter should 
I contact Rees and ask him to check it out?

Ian

---------- Forwarded message ----------
Date: Fri, 23 Jan 2004 20:52:14 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Program map and submount problem

On Fri, 23 Jan 2004, Mike Marion wrote:

> Wondering if anyone has seen this case with newer 4.1.0 daemon/module 
> and direct map used via program (we have mounts in mounts in direct map 
> so can't use built-in direct support).
> 
> mmarion @ linux-glab-1 54 [~]% zgrep submount /var/log/syslog.0.Z
> Jan 22 23:43:10 linux-glab-1 automount[2171]: starting automounter 
> version 4.1.0, path = /usr/local/projects/some/automount/submount, 
> maptype = program, mapname = /etc/auto.projects.sh
> Jan 22 23:43:27 linux-glab-1 automount[2229]: failed to mount 
> /usr/local/projects/some/automount/submount/rpcinfo
> Jan 22 23:49:21 linux-glab-1 automount[2171]: umount 
> /usr/local/projects/some/automount/submount failed: retrying...
> Jan 22 23:49:22 linux-glab-1 automount[2171]: umount 
> /usr/local/projects/some/automount/submount failed: retrying...
> Jan 22 23:49:23 linux-glab-1 automount[2171]: can't unmount 
> /usr/local/projects/some/automount/submount
> Jan 22 23:49:23 linux-glab-1 automount[2171]: shut down, path = 
> /usr/local/projects/some/automount/submount
> Jan 22 23:49:23 linux-glab-1 automount[2171]: failed to remove dir 
> /usr/local/projects/some/automount/submount: Device or resource busy

What does auto.projects.sh issue when executed in this context.

> 
> The above happens when one cd's into 
> /usr/local/projects/some/automount/submount, which is not yet an NFS 
> mount point, and does an ls of a few directories under there, which are 
> NFS mounts.  The mounts work fine.  However, leave the shell idle in 

What mounts work fine. 

Ian
