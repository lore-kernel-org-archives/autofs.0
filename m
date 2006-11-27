From: Ian Kent <raven@themaw.net>
Subject: Re: local filesystems: regression from autofs4 to autofs5
Date: Mon, 27 Nov 2006 18:19:57 +0800
Message-ID: <1164622798.3178.7.camel@localhost>
References: <456AB5A5.9080203@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <456AB5A5.9080203@inria.fr>
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

On Mon, 2006-11-27 at 10:53 +0100, Guillaume Rousse wrote:
> I've got troubles on a host with autofs v5, where all local file access
> to a NFS-exported filesystem triggers a new mount:

All local file accesses?
So are you saying accessing /etc or /var will mount everything in the
map below?

What process is requesting the mounts?

> 
> /home/graves/clerger on /home/graves/clerger type none (rw,bind)
> /home/graves/clerger/ParserRuns on /home/graves/clerger/ParserRuns type
> none (rw,bind)
> /home/graves/clerger/ParserRuns/results5 on
> /home/graves/clerger/ParserRuns/results5 type none (rw,bind)
> /home/graves/clerger/ParserRuns/results5/dbdir on
> /home/graves/clerger/ParserRuns/results5/dbdir type none (rw,bind)
> /home/graves/clerger/ParserRuns/results5/dbdir/mine.dat on
> /home/graves/clerger/ParserRuns/results5/dbdir/mine.dat type none (rw,bind)
> /home/graves/clerger/fom-meta on /home/graves/clerger/fom-meta type none
> (rw,bind)
> /home/graves/clerger/fom-meta/config on
> /home/graves/clerger/fom-meta/config type none (rw,bind)
> ...
> 
> /etc/fstab says:
> /dev/hda7       /home/graves    ext3    defaults 1 2
> 
> LDAP says:
> # auto.home.graves, autofs, village.inria.fr
> dn: ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr
> objectClass: top
> objectClass: automountMap
> ou: auto.home.graves
> 
> # /, auto.home.graves, autofs, village.inria.fr
> dn: cn=/,ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr
> objectClass: top
> objectClass: automount
> cn: /
> automountInformation: -fstype=nfs,hard,intr,nosuid,nfsvers=3
> graves:/home/graves/&
> 
> This seems to be a regression compared to autofs v4, where this was not
> occuring. The kernel is 2.6.17-6mdv, based on 2.6.17.14.
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
