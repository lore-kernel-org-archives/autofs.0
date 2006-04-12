From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: kernel panic when accessing local filesystems on NFS server
Date: Wed, 12 Apr 2006 14:48:15 +0200
Message-ID: <443CF70F.90001@inria.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hello.

Since last reboot, I encounter heavy troubles when trying to access
local filesystems also advertised by LDAP as available for auto-mounting.

/etc/fstab:
...
/dev/hdb1 /home/graves/ftp ext3 defaults 1 2

/etc/exports:
...
/home/graves/ftp/pub    *.inria.fr(ro,async,all_squash,insecure)

/etc/init.d/autofs status:
...
/usr/sbin/automount --timeout=60 /home/graves ldap
ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr

LDAP client map:
# auto.home.graves, autofs, village.inria.fr
dn: ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automountMap
ou: auto.home.graves

# /, auto.home.graves, autofs, village.inria.fr
dn: cn=/,ou=auto.home.graves,ou=autofs,dc=village,dc=inria,dc=fr
objectClass: top
objectClass: automount
cn: /
automountInformation: -fstype=nfs,hard,intr graves:/home/graves/&

When autofs is not activated, ls /home/graves/ftp works OK. As soon as
autofs is activated, ls /home/graves/ftp triggers immediate kernel
panics (can't handle kernel paging request). This is happening on a
mandriva 10.2, running kernel 2.6.11-13mdk, with autofs 4.1.4. It is
also a recent problem, which didn't occured earlier.

It seems I have to hide client maps to servers exporting them. Which is
quite difficult as I use LDAP precisely to propagate a centralised
configuration. But even if my configuration is wrong, autofs ought to be
a little more robust here.
