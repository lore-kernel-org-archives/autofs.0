From: Ian Kent <raven@themaw.net>
Subject: Re: invalid stat result with autofs 5
Date: Wed, 07 Feb 2007 23:12:11 +0900
Message-ID: <1170857531.3415.22.camel@raven.themaw.net>
References: <4525182B.9010609@inria.fr>  <45C9B0EF.20900@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45C9B0EF.20900@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Wed, 2007-02-07 at 11:58 +0100, Guillaume Rousse wrote:
> Guillaume Rousse wrote:
> > See http://qa.mandriva.com/show_bug.cgi?id=26244
> This seems to be fixed with 5.0.1rc3.
> 
> However, it is impossible to create new directories directly under mount
> point, which is quite problematic for creating new users home directories:
> [root@etoile ldapscripts]# mkdir /home/dir/foo
> mkdir: cannot create directory `/home/dir/foo': No such file or directory.
> 

I think we need more infomation here.

What is the kernel version and have any additional patches been added?
What is the version of autofs and have any patches been added?

I don't quite understand the problem description either.

What are the maps that are being used?
Is the browse (--ghost) option being used?
If we get a clear description of the problem then we may need a debug
log, but right now I wouldn't know what to look for.

It isn't possible to create directories in an autofs filesystem itself,
and never has been, as that is the responsibility of the user space
daemon. Due to changes in recent kernels and the fact that I got
criticized for autofs creating directories as root on NFS mounted file
systems the mount point directories that you wish to mount must already
exist on the remote server. autofs creating these directories is
considered a security risk.

If you wished to create directories on a remote server then the parent
directory must be mounted, one way or another, then given that you have
permission, you could create the directories.

> >From /var/log/messages
> Feb  7 11:37:04 etoile automount[25264]: rmdir_path: lstat of foo failed.
> 
> >From /proc/mounts
> ou=auto.home.dir,ou=autofs,dc=msr-inria,dc=inria,dc=fr /home/dir autofs
> rw,fd=5,pgrp=25264,timeout=300,minproto=5,maxproto=5,indirect 0 0
> ou=auto.home.mi,ou=autofs,dc=msr-inria,dc=inria,dc=fr /home/mi autofs
> rw,fd=10,pgrp=25264,timeout=300,minproto=5,maxproto=5,indirect 0 0
> 
> no-root-squash NFS option is set, so it is not a write permission
> problem. Moreover, the problem doesn't exist if /home/dir is manually
> mounted.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
