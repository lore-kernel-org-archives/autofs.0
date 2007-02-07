From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: invalid stat result with autofs 5
Date: Wed, 07 Feb 2007 11:58:55 +0100
Message-ID: <45C9B0EF.20900@inria.fr>
References: <4525182B.9010609@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4525182B.9010609@inria.fr>
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
To: autofs@linux.kernel.org

Guillaume Rousse wrote:
> See http://qa.mandriva.com/show_bug.cgi?id=26244
This seems to be fixed with 5.0.1rc3.

However, it is impossible to create new directories directly under mount
point, which is quite problematic for creating new users home directories:
[root@etoile ldapscripts]# mkdir /home/dir/foo
mkdir: cannot create directory `/home/dir/foo': No such file or directory.

From /var/log/messages
Feb  7 11:37:04 etoile automount[25264]: rmdir_path: lstat of foo failed.

From /proc/mounts
ou=auto.home.dir,ou=autofs,dc=msr-inria,dc=inria,dc=fr /home/dir autofs
rw,fd=5,pgrp=25264,timeout=300,minproto=5,maxproto=5,indirect 0 0
ou=auto.home.mi,ou=autofs,dc=msr-inria,dc=inria,dc=fr /home/mi autofs
rw,fd=10,pgrp=25264,timeout=300,minproto=5,maxproto=5,indirect 0 0

no-root-squash NFS option is set, so it is not a write permission
problem. Moreover, the problem doesn't exist if /home/dir is manually
mounted.
