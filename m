From: Benjamin Hanzelmann <benjamin.hanzelmann@cs.uni-dortmund.de>
Subject: 'nfsstat -m' shows many mounts - normal behavior?
Date: Fri, 10 Oct 2008 11:36:04 +0200
Message-ID: <48EF2204.2050806@cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hello everybody,

at work we're having trouble with undeletable directories.
We use autofs 4.1.4+debian-2.1ubuntu1 (Hardy).
Sometimes (possibly after many file operations for
example with maven, eclipse, svn) there are directories
that cannot be deleted anymore. Home directories
are mounted from a Solaris NFS server, which seems to be
running okay (nothing shows up server side if this happens).

On the client, 'nfsstat -m' shows many mount points inside
the home directory, one of them the directory that cannot
be deleted (see below, the directory this time was
'/ldaphome/hanzelm/workspace/ls5/jabc-core/jabc-editor/target/classes/de'.
'/home/hanzelm' is coming from a near-obsolete NIS auto_home,
but I'm working in /ldaphome.)

Is this normal behaviour for autofs/nfs?

Regards,
Benjamin Hanzelmann

>>>>>>> paste <<<<<<<<
hanzelm@ls5ray01:~# nfsstat -m
[...]
[ other user home directories ]
[...]

/ldaphome/hanzelm from ls5file02:/san02vol02pool/nfs/export/home02/hanzelm
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/home/hanzelm from ls5file02:/san02vol02pool/nfs/export/home02/hanzelm
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/.mozilla-thunderbird/ml8g9zbw.default/ImapMail/mail.speutel.de/INBOX.sbd/work--ls5.sbd
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/.mozilla-thunderbird/ml8g9zbw.default/ImapMail/mail.speutel.de/INBOX.sbd/work--ls5.sbd
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/da/text/Konzept from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/da/text/Konzept
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/.eclipse/org.eclipse.platform_3.3.0_1148896627 from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/.eclipse/org.eclipse.platform_3.3.0_1148896627
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/.metadata/.plugins from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/.metadata/.plugins
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/jabc-editor
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/jabc-editor
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/jabc-framework
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/jabc-framework
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/maven-server-plugin
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/maven-server-plugin
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/zounds
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/zounds
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/zounds-common
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/.metadata/.plugins/org.eclipse.core.resources/.projects/zounds-common
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02

/ldaphome/hanzelm/workspace/ls5/jabc-core/jabc-editor/target/classes/de
from
ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/workspace/ls5/jabc-core/jabc-editor/target/classes/de
 Flags:
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02


[...]
