From: Chris Croswhite <csc@cadence.com>
Subject: Re: Program map and submount problem
Date: Fri, 23 Jan 2004 14:34:23 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1074897263.30121.927.camel@d158140025182.Cadence.COM>
References: <Pine.LNX.4.44.0401232049020.4706-100000@raven.themaw.net>
Reply-To: csc@cadence.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401232049020.4706-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Mike Marion <mmarion@qualcomm.com>

okay 15th same message now.


 On Fri, 2004-01-23 at 04:52, Ian Kent wrote:
> On Fri, 23 Jan 2004, Mike Marion wrote:
> 
> > Wondering if anyone has seen this case with newer 4.1.0 daemon/module 
> > and direct map used via program (we have mounts in mounts in direct map 
> > so can't use built-in direct support).
> > 
> > mmarion @ linux-glab-1 54 [~]% zgrep submount /var/log/syslog.0.Z
> > Jan 22 23:43:10 linux-glab-1 automount[2171]: starting automounter 
> > version 4.1.0, path = /usr/local/projects/some/automount/submount, 
> > maptype = program, mapname = /etc/auto.projects.sh
> > Jan 22 23:43:27 linux-glab-1 automount[2229]: failed to mount 
> > /usr/local/projects/some/automount/submount/rpcinfo
> > Jan 22 23:49:21 linux-glab-1 automount[2171]: umount 
> > /usr/local/projects/some/automount/submount failed: retrying...
> > Jan 22 23:49:22 linux-glab-1 automount[2171]: umount 
> > /usr/local/projects/some/automount/submount failed: retrying...
> > Jan 22 23:49:23 linux-glab-1 automount[2171]: can't unmount 
> > /usr/local/projects/some/automount/submount
> > Jan 22 23:49:23 linux-glab-1 automount[2171]: shut down, path = 
> > /usr/local/projects/some/automount/submount
> > Jan 22 23:49:23 linux-glab-1 automount[2171]: failed to remove dir 
> > /usr/local/projects/some/automount/submount: Device or resource busy
> 
> What does auto.projects.sh issue when executed in this context.
> 
> > 
> > The above happens when one cd's into 
> > /usr/local/projects/some/automount/submount, which is not yet an NFS 
> > mount point, and does an ls of a few directories under there, which are 
> > NFS mounts.  The mounts work fine.  However, leave the shell idle in 
> 
> What mounts work fine. 
> 
> Ian
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
