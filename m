From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: LDAP questions
Date: Fri, 15 Apr 2005 12:45:54 -0500
Message-ID: <ufa8y3krl0t.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

I'm trying to migrate towards LDAP and away from homebrew map
distribution.  My test setup is running FC3, autofs-4.1.3-114.  So far
I've been successful, but I have a couple of questions.  I apologize
for the length of this but I think these are mostly related.

Is there any documentation on how mount entries retrieved from LDAP
are cached?  I'm seeing entries sticking around long after they've
been deleted from the map and I'm wondering if there's any timeout for
positive hits.  I'm also not seeing any type of negative caching.

I noticed that I see a lot of messages like this one, accessing /home/mike:

lookup(ldap): got answer, but no first entry for (&(objectclass=automount)(cn=mike))

I'm using the NIS schema, not the automount schema.  The LDAP server
shows these searches:

SRCH base="nisMapName=auto.home,dc=math,dc=uh,dc=edu" scope=2 deref=0
filter="(&(objectClass=nisObject)(cn=mike))"
SRCH attr=cn nisMapEntry
SEARCH RESULT tag=101 err=0 nentries=1 text=

SRCH base="nisMapName=auto.home,dc=math,dc=uh,dc=edu" scope=2 deref=0 filter="(&(?=undefined)(cn=mike))"
SRCH attr=cn automountInformation
SEARCH RESULT tag=101 err=0 nentries=0 text=

Note how the first search returns an entry.  Should I just ignore
these log messages, or can I turn off use of the automount schema
somehow?  (The master map is in LDAP too, so theoretically the daemon
should be able to figure out which schema I'm using when it starts up
and could stick to it.)

I noticed that running "man" takes ages now.  The default manpath for
some reason has a bunch of references to points under /usr/local,
which so happens to be managed by autofs.  Each time man tries to stat
one of these paths, it takes about a second.  From strace -r:

0.000068 stat64("/usr/local/share/man/en_US.UTF-8", 0xbfff947c) = -1 ENOENT (No such file or directory)
0.921225 stat64("/usr/local/share/man/en", 0xbfff947c) = -1 ENOENT (No such file or directory)
1.001739 stat64("/usr/local/share/man", 0xbfff94ac) = -1 ENOENT (No such file or directory)
1.082108 stat64("/usr/kerberos/bin/man", 0xbfffb52c) = -1 ENOENT (No such file or directory)
0.000074 stat64("/usr/kerberos/bin/MAN", 0xbfffb52c) = -1 ENOENT (No such file or directory)

So each time /usr/local/share/man or something under it is referenced,
there is a one second pause and for each pause the following two lines
are logged:

lookup(ldap): got answer, but no first entry for (&(objectclass=nisObject)(cn=/))
lookup(ldap): got answer, but no first entry for (&(objectclass=automount)(cn=/))

I don't believe that the delay is coming from the LDAP server.  It's
logs only have single second resolution, but the BIND, SRCH and SEARCH
RESULT lines generally all happen within the same second.

Any hints or pointers would be appreciated.

 - J<
