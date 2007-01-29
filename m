From: "Martin Dorey" <mdorey@bluearc.com>
Subject: Re: automounted symlink to automount sometimes fails,
	doing DNS query of partial path
Date: Mon, 29 Jan 2007 12:13:54 -0800
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50C3D441E@us-email.terastack.bluearc.com>
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
To: Ian Kent <raven@themaw.net>, Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

> I suspect that 2.6.18 (or even 17) will help with Martins problem.

In my original post, I said:

>> The machine which had this problem last week is running 2.6.18-3-686
and
>> autofs 4.1.4+debian-1.  I think its mount table cleared up after say
five
>> minutes.  It also contained spuriously few, spuriously capitalized
mount
>> entries (including at least ARCHIVE) before the problem went away.

Ian correctly divined that I was (disingenuously, sorry) being ambiguous
about whether it *had* been running 2.6.18 at the time of the problem.
That was because I couldn't think of an easy way to prove it one way or
the other.  I've given it some more thought and realized that I still
have old enough auth.log entries.  These convince me that my
recollection was right - that I was already running 2.6.18 at the time
of the first occurrence of the problem.

Jan  8 18:20:12 duezer sudo:  martind : TTY=pts/2 ;
PWD=/home/martind/work/misc ; USER=root ; COMMAND=/usr/X11R6/bin/apt-get
install linux-image-2.6.18-3-686
Jan  8 18:21:39 duezer sudo:  martind : TTY=pts/2 ;
PWD=/home/martind/work/misc ; USER=root ; COMMAND=/sbin/reboot

Jan 13 14:59:38 duezer sudo:  martind : TTY=pts/0 ;
PWD=/home/martind/work/parrot ; USER=root ; COMMAND=/bin/umount
/net/us-titan.us.dev.bluearc.com/ARCHIVE/

This is the same machine (and kernel) on which I later tried but failed
to reproduce the problem (and on which it still hasn't recurred in the
intervening time).  I can't help but suspect that the spurious
capitalization of some of the mount point names - like ARCHIVE - is a
clue.  I wonder what could cause that?
-------------------------------------
Martin's Outlook, BlueArc Engineering
