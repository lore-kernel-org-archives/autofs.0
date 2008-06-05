From: Shane <squindler@gmail.com>
Subject: multi-level deep ldap automount possible?
Date: Thu, 5 Jun 2008 15:42:24 +0930
Message-ID: <10badf220806042312p6ca4adf0h5836a8e046f2075a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hello,

Hoping someone can help me figure out if its possible to do
multi-level deep automounts via ldap. I've seen a few examples of this
using files but can't get it to work using LDAP.

eg I want:
server1:/export/protemp  -  /nfs/tmp/production
server2:/export/tmp/weekly  -  /nfs/tmp/weekly
server2:/export/tmp/hourly  -  /nfs/tmp/hourly

pseudo ldap implementation
cn=nfs,ou=auto.master: ldap: ou=auto.nfs  objectClass = automountMap
cn=tmp,ou=auto.nfs: ldap ou=outo.tmp,ou=auto.nfs  objectClass = automount
ou=auto.tmp,ou=auto.nfs: objectClass automountMap
cn=production,ou=auto.tmp,ou=auto.nfs: -rw,hard,intr,tcp
server1:/export/protemp  objectClass = automount
...

It more or less makes sense to me why automount isn't picking this up
- I'm using RedHat derivatives to the automount init status command
gives me a list of configured automounts which is basically everything
in auto.master - so automount isn't loading the map for /nfs/tmp
(ou=auto.tmp,ou=auto.nfs) ... not sure how to make this happen ... I
tried having both /nfs and /nfs/tmp under auto.master but that didn't
work either.

So -
a) is this possible?
b) whats the "correct" way to implement on the LDAP server side?
c) possible alternate solution?

TIA,
Shane.
