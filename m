From: Raymond Prach <rprach@us.ibm.com>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Thu, 8 Apr 2004 11:04:17 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
References: <Pine.LNX.4.58.0404081922100.3363@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============70482629766358906=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404081922100.3363@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

This is a multipart message in MIME format.
--===============70482629766358906==
Content-Type: multipart/alternative;
	boundary="=_alternative 0052CA3604256E70_="

This is a multipart message in MIME format.
--=_alternative 0052CA3604256E70_=
Content-Type: text/plain; charset="US-ASCII"

It would be good if I could duplicate this reliably. Perhaps then I could 
work out what is happening. Can you help with a description of the 
scenario or a simple script?

Unfortunately the script is not simple, and neither is our environment. ;) 
However, what seems to happen is this:

1. The script reads from the home directories of a large number of users
2. Users' home directories, by and large, are located on their 
workstations, which are AIX 5.1
3. Thus, via autofs, the server mounts a whole bunch of home directories 
using NFS (v2, over UDP, if that matters) from a whole bunch of AIX 
workstations -- say 20 at a time
4. Eventually, the script attempts to mount a home directory from a 
workstation that is down or has been removed from the network, so it waits 
around for a long time for the mount attempt to time out
5. While it is waiting for this mount attempt to fail, a bunch of mounts 
that autofs previously mounted time out due to inactivity, so autofs 
unmounts them
6. At this point, the "self destruct" message appears in the syslog
7. Lather, rinse, repeat.

I hope that is somewhat helpful, or at least informative.

I can't really do much unless you are willing to duplicate this 
against, at least autofs-4.1.1 (4.1.2 is latest), together with the kernel 

patches for autofs4. I haven't tested 2.4.25 but the 2.4.22 patch applies 
OK against 2.4.24.

Ehhh. Unfortunately these are at least nominally production systems, and 
I'm loath to start applying bleeding-edge patches to them when it doesn't 
look like it will make the problem go away. Are there other advantages to 
switching to autofs4? (Also, off-topic, but my 2.4.25 kernel has an 
autofs4 module. What is the difference between that autofs4 and the 
autofs4 you are talking about?)

What patch was this? I must have missed it.

From kernel.org: o A patch by Greg Banks to help fix the "VFS: Busy inodes 
after unmount." problem that occurs if autofs expires the mountpoint while 
an NFS sillydelete is still pending. Now didn't have high hopes for this 
patch, as I don't think that what we're seeing has anything to do with 
sillydeletes (or indeed that any are being performed), but I was running 
out of ideas here.

Not much help here aye! Sorry.

No, this is as informative as anything I've encountered so far. Thanks 
very much for taking the time to answer my questions. 

Raymond Prach

--=_alternative 0052CA3604256E70_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2><tt>It would be good if I could duplicate this reliably.
Perhaps then I could <br>
work out what is happening. Can you help with a description of the <br>
scenario or a simple script?</tt></font>
<br>
<br><font size=2 face="sans-serif">Unfortunately the script is not simple,
and neither is our environment. ;) However, what seems to happen is this:</font>
<br>
<br><font size=2 face="sans-serif">1. The script reads from the home directories
of a large number of users</font>
<br><font size=2 face="sans-serif">2. Users' home directories, by and large,
are located on their workstations, which are AIX 5.1</font>
<br><font size=2 face="sans-serif">3. Thus, via autofs, the server mounts
a whole bunch of home directories using NFS (v2, over UDP, if that matters)
from a whole bunch of AIX workstations -- say 20 at a time</font>
<br><font size=2 face="sans-serif">4. Eventually, the script attempts to
mount a home directory from a workstation that is down or has been removed
from the network, so it waits around for a long time for the mount attempt
to time out</font>
<br><font size=2 face="sans-serif">5. While it is waiting for this mount
attempt to fail, a bunch of mounts that autofs previously mounted time
out due to inactivity, so autofs unmounts them</font>
<br><font size=2 face="sans-serif">6. At this point, the &quot;self destruct&quot;
message appears in the syslog</font>
<br><font size=2 face="sans-serif">7. Lather, rinse, repeat.</font>
<br>
<br><font size=2 face="sans-serif">I hope that is somewhat helpful, or
at least informative.</font>
<br>
<br><font size=2><tt>I can't really do much unless you are willing to duplicate
this <br>
against, at least autofs-4.1.1 (4.1.2 is latest), together with the kernel
<br>
patches for autofs4. I haven't tested 2.4.25 but the 2.4.22 patch applies
<br>
OK against 2.4.24.</tt></font>
<br>
<br><font size=2 face="sans-serif">Ehhh. Unfortunately these are at least
nominally production systems, and I'm loath to start applying bleeding-edge
patches to them when it doesn't look like it will make the problem go away.
Are there other advantages to switching to autofs4? (Also, off-topic, but
my 2.4.25 kernel has an autofs4 module. What is the difference between
that autofs4 and the autofs4 you are talking about?)</font>
<br>
<br><font size=2><tt>What patch was this? I must have missed it.</tt></font>
<br>
<br><font size=2><tt>From kernel.org: o A patch by Greg Banks to help fix
the &quot;VFS: Busy inodes after unmount.&quot; problem that occurs if
autofs expires the mountpoint while an NFS sillydelete is still pending.
Now didn't have high hopes for this patch, as I don't think that what we're
seeing has anything to do with sillydeletes (or indeed that any are being
performed), but I was running out of ideas here.</tt></font>
<br>
<br><font size=2><tt>Not much help here aye! Sorry.</tt></font>
<br>
<br><font size=2><tt>No, this is as informative as anything I've encountered
so far. Thanks very much for taking the time to answer my questions. </tt></font>
<br>
<br><font size=2><tt>Raymond Prach</tt></font>
<br>
--=_alternative 0052CA3604256E70_=--


--===============70482629766358906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============70482629766358906==--

