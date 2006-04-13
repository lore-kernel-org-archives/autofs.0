From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: Re: kernel panic when accessing local filesystems on NFS
	server
Date: Thu, 13 Apr 2006 14:18:57 +0200
Message-ID: <443E41B1.50804@inria.fr>
References: <443CF70F.90001@inria.fr>
	<x49vete1wr5.fsf@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49vete1wr5.fsf@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Autofs is probably attempting a recursive bind mount.  This problem was
> fixed, upgrade your kernel.
> 
> 	http://lkml.org/lkml/2005/6/4/11
Thanks, this fixed the crash issue.

However, it seems automount is still taking priority on direct access if
a mount point is activated.

If my /etc/fstab says:
/dev/hda1 /home

and /etc/init.d/autofs status says:
/usr/sbin/automount /home/graves ldap
ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr

Any attempt to access /home/graves on graves host will mount it through
autofs, and access it through NFS, masking local filesystem and probably
wasting resources.

If however /etc/fstab has exactly the same mount point defined, it seems
the init script correctly filter it (it is configured, but not
activated), preventing the issue.

Is this expected behaviour ?
