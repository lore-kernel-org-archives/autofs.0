From: "Martin Dorey" <mdorey@bluearc.com>
Subject: automounted symlink to automount sometimes fails,
	doing DNS query of partial path
Date: Mon, 22 Jan 2007 21:52:07 -0800
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50C2E88F6@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

I've got a symbolic link that's auto-mounted which points to a different
auto-mount:

/net/mirror/mirror-link ->
/net/us-titan.us.dev.bluearc.com/Company/Engineering/Software/mirror

A script occasionally executes a binary from under this link:
/net/mirror/mirror-link/runtitan/ssc.  Most of the time, this works fine
(and we've been doing this on many machines tens of times a day for
weeks now), but, on two occasions now (that I know of) on two different
machines, this has failed leaving messages like this in the syslog:

Jan 22 18:14:27 wide automount[466]: >> /sbin/showmount: can't get
address for us-titan.us.dev.bluearc.com/Company
Jan 22 18:14:27 wide automount[466]: lookup(program): lookup for
us-titan.us.dev.bluearc.com/Company failed
Jan 22 18:14:27 wide automount[466]: failed to mount
/net/us-titan.us.dev.bluearc.com/Company

From looking at the userland source and running /etc/auto.net manually
and by turning on debugging when everything is working, I see that this
suggests the userland part has been asked to mount
us-titan.us.dev.bluearc.com/Company when it should have been asked to
mount us-titan.us.dev.bluearc.com.  But I don't know why.

The machine it happened on today is running a Debian
2.6.16-2-amd64-k8-smp.  aptitude show autofs reckons it's running
Version: 4.1.4-13.  According to
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=316378, that should
have mount locking disabled (after a previous discussion with Ian).
/etc/auto.net is, I believe, as distributed by Debian.

Today's occurrence left these related entries in /proc/mounts, seemingly
indefinitely:

us-titan.us.dev.bluearc.com:/CALLHOME
/net/us-titan.us.dev.bluearc.com/CALLHOME nfs
rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr
=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/ARCHIVE
/net/us-titan.us.dev.bluearc.com/ARCHIVE nfs
rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr
=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Install
/net/us-titan.us.dev.bluearc.com/Install nfs
rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr
=us-titan.us.dev.bluearc.com 0 0

mirror:/ /net/mirror nfs
rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr
=mirror 0 0
mirror:/u24 /net/mirror/u24 nfs
rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr
=mirror 0 0
mirror:/u24/tmp /net/mirror/u24/tmp nfs
rw,nosuid,nodev,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr
=mirror 0 0

The capitalization and number (3) of the us-titan mounts is interesting
- Install is OK but ARCHIVE and COMPANY should have been archive and
Company.  autofs should try to mount these exports:

$ /etc/auto.net us-titan.us.dev.bluearc.com
-fstype=nfs,hard,intr,nodev,nosuid,nonstrict,async \
	/Company us-titan.us.dev.bluearc.com:/Company \
	/FCVOL1 us-titan.us.dev.bluearc.com:/FCVOL1 \
	/Install us-titan.us.dev.bluearc.com:/Install \
	/Intranet us-titan.us.dev.bluearc.com:/Intranet \
	/SATAVOL1 us-titan.us.dev.bluearc.com:/SATAVOL1 \
	/Sustaining us-titan.us.dev.bluearc.com:/Sustaining \
	/Users us-titan.us.dev.bluearc.com:/Users \
	/archive us-titan.us.dev.bluearc.com:/archive \
	/backupdev us-titan.us.dev.bluearc.com:/backupdev \
	/backupit us-titan.us.dev.bluearc.com:/backupit \
	/backups-sustaining
us-titan.us.dev.bluearc.com:/backups-sustaining \
	/bluegle-search us-titan.us.dev.bluearc.com:/bluegle-search \
	/callhome us-titan.us.dev.bluearc.com:/callhome \
	/cms us-titan.us.dev.bluearc.com:/cms \
	/scratch us-titan.us.dev.bluearc.com:/scratch \
	/sustaining-mysql us-titan.us.dev.bluearc.com:/sustaining-mysql
\
	/svn us-titan.us.dev.bluearc.com:/svn \
	/test us-titan.us.dev.bluearc.com:/test
$

When it works, it mounts this many, and with this capitalization (the
others correctly fail with access denied):

us-titan.us.dev.bluearc.com:/test /net/us-titan.us.dev.bluearc.com/test
nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Users
/net/us-titan.us.dev.bluearc.com/Users nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/scratch
/net/us-titan.us.dev.bluearc.com/scratch nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/archive
/net/us-titan.us.dev.bluearc.com/archive nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Install
/net/us-titan.us.dev.bluearc.com/Install nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Company
/net/us-titan.us.dev.bluearc.com/Company nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Intranet
/net/us-titan.us.dev.bluearc.com/Intranet nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/backupdev
/net/us-titan.us.dev.bluearc.com/backupdev nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0
us-titan.us.dev.bluearc.com:/Sustaining
/net/us-titan.us.dev.bluearc.com/Sustaining nfs
rw,nosuid,nodev,vers=3,rsize=32768,wsize=32768,hard,intr,proto=tcp,timeo
=600,retrans=2,sec=sys,addr=us-titan.us.dev.bluearc.com 0 0

The machine which had this problem last week is running 2.6.18-3-686 and
autofs 4.1.4+debian-1.  I think its mount table cleared up after say
five minutes.  It also contained spuriously few, spuriously capitalized
mount entries (including at least ARCHIVE) before the problem went away.

I've tried to reproduce the problem on the latter machine today, by
starting a new automount using the same map, with a reduced timeout and
--debug and then trying to provoke race conditions and all sorts.  No
joy, but perhaps I'm not being sufficiently imaginative in my testing.

I've enabled --debug on auto.net and made sure daemon.* is being logged,
per http://people.redhat.com/~jmoyer/, and I await the problem happening
again.  But if the capitalization thing or anything else rings any bells
- if Debian is perhaps one or two patches short of a kernel, as it were
- I'd be glad of a short-cut.

Thanks,
-------------------------------------
Martin's Outlook, BlueArc Engineering
