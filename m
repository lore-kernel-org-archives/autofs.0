From: Ian Kent <raven@themaw.net>
Subject: Re: autofs changes process's current working directory
Date: Fri, 09 Oct 2009 13:58:09 +0800
Message-ID: <4ACED0F1.9050909@themaw.net>
References: <bd985a450909070436x2ddf0fa8l3b20e908f2f2e3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <bd985a450909070436x2ddf0fa8l3b20e908f2f2e3c5@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Antonio Messina <arcimboldo@gmail.com>
Cc: autofs@linux.kernel.org

Antonio Messina wrote:
> Hi all,
> 
> I'm experiencing a problem with autofs. It seems that when a process
> is inside an automounted nfs filesystem, if I restart the automount
> daemon the current working directory of the process is changed and a
> few leading directory are removed leading to a non-existent cwd.

That's right.

It's because, with older user space and kernel, the mount is detached
from the mount tree by a "umount -l" at restart when trying to cleanup
stale mounts.

Note that this is a non-trivial problem and took a long time to fix.

What autofs and kernel are you using?

> 
> I have to say, however, that the process will continue to see the
> current directory: for instance, if we are running a shell, a "ls"
> will gives you the correct answer, I can edit files (but vi
> complains about not finding the file when saving) and the "pwd"
> command returns the right directory.

Yes, but it depends on what you do.

A "cd ." in a shell will fix things but that's not much help for binary
applications that cannot be changed. You really have no choice but to
update to a user space and kernel that fixes this.

That isn't without it's own set of problems though. Such as, a restart
will happily "re-connect" to a pre-existing mount to a dead server.
People used to "kill -9" the daemon and just start autofs again to fix
this type of problem and init script options "forcestart" and
"forcerestart" were added to allow the previous broken behaviour to be used.

> 
> In order to reproduce the problem I've wrote a very simple program:
> 
> #include <unistd.h>
> #include <stdio.h>
> #include <sys/stat.h>
> 
> int main(){
>   /* check if the current directory is right */
>   char lpath[1024];
>   int res;
>   getcwd(lpath, 1024);
>   res = access(lpath,F_OK);
>   if(0 != res)
>       printf("Error! My CWD is %s but it doens't exists!\n", lpath);
>   else
>       printf("My CWD is %s and it exists\n", lpath);
>   return res;
> }
> 
> 
> a simple session follows:
> 
> [root@pc-amessina ~]# cd /home/RAID3-D3/vmware
> [root@pc-amessina vmware]# ~/cwdcheck
> My CWD is /home/RAID3-D3/vmware and it exists
> [root@pc-amessina vmware]# service autofs restart
> Stopping autofs:                                                [  OK  ]
> Starting autofs:                                                [  OK  ]
> [root@pc-amessina vmware]# ~/cwdcheck
> Error! My CWD is /vmware but it doens't exists!
> 
> 
> My auto.master is:
> 
> /home /etc/auto.home  -rw,soft,intr,rsize=8192,wsize=8192,sync
> 
> my auto.home is very long but the relevant line is:
> 
> RAID3-D3 climaserv3:/RAID3/D3
> 
> (we mount a few different filesystems from the climaserv3 machine,
> but they are exported separately by the server)
> 
> My system is:
> 
> [root@pc-amessina ~]# uname -a
> Linux pc-amessina.ictp.it 2.6.24.7-desktop-2mnb #1 SMP Thu Oct 30
> 18:03:14 EDT 2008 i686 Intel(R) Core(TM)2 Duo CPU     E8400  @
> 3.00GHz GNU/Linux
> 
> [root@pc-amessina ~]# cat /etc/redhat-release
> Mandriva Linux release 2008.1 (Official) for i586
> 
> [root@pc-amessina ~]# rpm -q autofs
> autofs-5.0.4-7mdv2008.1
> 
> 
> Logs from automount follows:
> 
> Sep  3 12:55:33 localhost automount[11856]: Starting automounter
> version 5.0.4, master map auto.master
> Sep  3 12:55:33 localhost automount[11856]: using kernel protocol
> version 5.00
> Sep  3 12:55:33 localhost automount[11856]: mounted indirect on
> /home with timeout 900, freq 225 seconds
> Sep  3 12:55:53 localhost automount[11856]: attempting to mount
> entry /home/RAID3-D3
> Sep  3 12:55:53 localhost automount[11856]: mount(nfs): mounted
> climaserv3:/RAID3/D3 on /home/RAID3-D3
> Sep  3 12:55:53 localhost automount[11856]: mounted /home/RAID3-D3
> Sep  3 12:55:59 localhost automount[11856]: 1 remaining in /home
> Sep  3 12:55:59 localhost automount[11856]: filesystem /home still busy
> Sep  3 12:56:04 localhost automount[11915]: Starting automounter
> version 5.0.4, master map auto.master
> Sep  3 12:56:04 localhost automount[11915]: using kernel protocol
> version 5.00
> Sep  3 12:56:04 localhost automount[11915]: mounted indirect on
> /home with timeout 900, freq 225 seconds
> Sep  3 12:56:09 localhost automount[11915]: attempting to mount
> entry /home/RAID3-D3
> Sep  3 12:56:09 localhost automount[11915]: mount(nfs): mounted
> climaserv3:/RAID3/D3 on /home/RAID3-D3
> Sep  3 12:56:09 localhost automount[11915]: mounted /home/RAID3-D3
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
