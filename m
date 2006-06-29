From: "Martin Dorey" <mdorey@bluearc.com>
Subject: deliberate? deadlock when one automount depends on another
Date: Thu, 29 Jun 2006 10:35:32 -0700
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF509D14A07@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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

I have a couple of maps in auto.master:

/home auto.home	-hard,intr,rsize=32768,wsize=32768
/u auto.u	-hard,intr,rsize=32768,wsize=32768

One of the entries in auto.home refers to a directory automounted via
the auto.u map:

usbuilder :/u/u60/Development/users/&

The entry in auto.u says:

u60 -proto=tcp,hard,intr,rsize=32768,wsize=32768
us-titan.terastack.bluearc.com:/Company

If /u/u60 is already mounted, I can mount /home/usbuilder promptly and
without problem.  If /u/u60 isn't mounted, I get this every time:

Jun 29 09:20:29 duezer automount[27601]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
Jun 29 09:20:29 duezer automount[27601]: mount(nfs): nfs: mount failure
us-titan.terastack.bluearc.com:/Company on /u/u60
Jun 29 09:20:29 duezer automount[27601]: failed to mount /u/u60
Jun 29 09:20:56 duezer automount[28138]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
Jun 29 09:20:56 duezer automount[28138]: mount(nfs): nfs: mount failure
us-titan:/svn on /net/us-titan/svn
Jun 29 09:21:00 duezer automount[28143]: aquire_lock: can't lock lock
file timed out: /var/lock/autofs
Jun 29 09:21:00 duezer automount[28143]: mount(nfs): nfs: mount failure
us-titan.terastack.bluearc.com:/Company on /u/u60
Jun 29 09:21:00 duezer automount[28143]: failed to mount /u/u60
Jun 29 09:21:00 duezer automount[27599]: >> mount: special device
/u/u60/Development/users/usbuilder does not exist
Jun 29 09:21:00 duezer automount[27599]: failed to mount /home/usbuilder

My guess is that there's effectively a deadlock here - that autofs has
already locked /var/lock/autofs to mount /home/usbuilder and then finds
it has to mount /u/u60 and tries to acquire the same lock again.  If I'm
wrong, and it's more interesting than I think, then you'll probably want
more than I've gathered from http://people.redhat.com/jmoyer/:

From dpkg --status autofs: Version: 4.1.4-10.  From uname -r:
2.6.16-1-686-smp.  (That's a Debian stock kernel.)

The workaround is obvious and not problematic for me.  I just wondered
if this behavior was intentional.  I don't see the problem on autofs 3
(Debian's autofs version 3.9.99-4.0.0pre10-20, 2.6.13.4-d865-satasata-uk
(a non-stock kernel).)
-------------------------------------
Martin's Outlook, BlueArc Engineering
