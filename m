From: Ian Kent <raven@themaw.net>
Subject: Re: 'nfsstat -m' shows many mounts - normal behavior?
Date: Mon, 27 Oct 2008 23:55:25 +0900
Message-ID: <1225119325.2990.36.camel@zeus.themaw.net>
References: <48EF2204.2050806@cs.uni-dortmund.de>
	<alpine.LFD.2.00.0810171204150.14838@raven.themaw.net>
	<4905D3C0.6050605@cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4905D3C0.6050605@cs.uni-dortmund.de>
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
To: Benjamin Hanzelmann <benjamin.hanzelmann@cs.uni-dortmund.de>
Cc: autofs@linux.kernel.org

On Mon, 2008-10-27 at 15:44 +0100, Benjamin Hanzelmann wrote:
> Sorry for taking my time to answer, busy days for me ATM... ;)

No this doesn't look right at all.
How about collecting and posting a debug log.
See http://people.redhat.com/jmoyer for information.

What kernel version are you using?

> 
> Ian Kent wrote:
> >> Hello everybody,
> >>
> >> at work we're having trouble with undeletable directories.
> >> We use autofs 4.1.4+debian-2.1ubuntu1 (Hardy).
> >> Sometimes (possibly after many file operations for
> >> example with maven, eclipse, svn) there are directories
> >> that cannot be deleted anymore. Home directories
> >> are mounted from a Solaris NFS server, which seems to be
> >> running okay (nothing shows up server side if this happens).
> >>
> >> On the client, 'nfsstat -m' shows many mount points inside
> >> the home directory, one of them the directory that cannot
> >> be deleted (see below, the directory this time was
> >> '/ldaphome/hanzelm/workspace/ls5/jabc-core/jabc-editor/target/classes/de'.
> >> '/home/hanzelm' is coming from a near-obsolete NIS auto_home,
> >> but I'm working in /ldaphome.)
> > 
> > What do your maps look like?
> 
> In the LDAP directory:
> 
> dn: ou=auto.master,o=orga
> objectClass: automountMap
> objectClass: top
> ou: auto.master
> 
> dn: cn=/ldaphome,ou=auto.master,o=orga
> objectClass: automount
> automountInformation: ldap:ou=auto.home,o=orga
> cn: /ldaphome
> 
> dn: ou=auto.home,o=orga
> objectClass: automountMap
> objectClass: top
> ou: auto.home
> 
> dn: cn=hanzelm,ou=auto.home,o=orga
> objectClass: automount
> automountInformation: \
> 	-rw,intr ls5file02:/san02vol02pool/nfs/export/home02/&
> cn: hanzelm
> 
> Naturally there are many more children to ou=auto.home,o=orga, one for
> every user (pretty standard setup, if my observations are correct. ;)
> 
> NIS:
> 
> auto_master:
> /home /etc/auto.home
> 
> auto_home:
> [...]
> hanzelm -rw,intr ls5file02:/san02vol02pool/nfs/export/home02/&
> [...]
> 
> >> Is this normal behaviour for autofs/nfs?
> 
> >>>>>>>>> paste <<<<<<<<
> >> hanzelm@ls5ray01:~# nfsstat -m
> >> /ldaphome/hanzelm from ls5file02:/san02vol02pool/nfs/export/home02/hanzelm
> >>  Flags:
> >> rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02
> >>
> >> /home/hanzelm from ls5file02:/san02vol02pool/nfs/export/home02/hanzelm
> >>  Flags:
> >> rw,vers=3,rsize=1048576,wsize=1048576,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02
> >>
> >> /ldaphome/hanzelm/.mozilla-thunderbird/ml8g9zbw.default/ImapMail/mail.speutel.de/INBOX.sbd/work--ls5.sbd
> >> from
> >> ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/.mozilla-thunderbird/ml8g9zbw.default/ImapMail/mail.speutel.de/INBOX.sbd/work--ls5.sbd
> >>  Flags:
> >> rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02
> >>
> >> /ldaphome/hanzelm/.eclipse/org.eclipse.platform_3.3.0_1148896627 from
> >> ls5file02:/san02vol02pool/nfs/export/home02/hanzelm/.eclipse/org.eclipse.platform_3.3.0_1148896627
> >>  Flags:
> >> rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retrans=2,sec=sys,addr=ls5file02
> [...]
> 
> Regards,
> Benjamin Hanzelmann
> 
