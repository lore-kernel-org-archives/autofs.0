From: "Stephen Biggs" <sbiggs@nvidia.com>
Subject: Automounter stops mounting home directories.
Date: Thu, 19 Jun 2008 10:58:53 -0700
Message-ID: <A2ECBF49F352C24F9DF65BB529DCBC7014E02D1D@hqemmail01.nvidia.com>
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
Cc: Ian Kent <raven@themaw.net>

[root@server1 root]# /usr/sbin/automount --version

Linux automount version 5.0.3

Directories:
        config dir:     /etc/sysconfig
        maps dir:       /etc
        modules dir:    /usr/lib/autofs

Compile options:


[root@server1 root]# uname -a
Linux l-xterm-13 2.6.24 #2 SMP PREEMPT Wed Feb 6 13:33:24 PST 2008 i686
i686 i386 GNU/Linux
[root@server1 root]#

Active options in /etc/sysconfig/autofs are:
DEFAULT_TIMEOUT=600
DEFAULT_BROWSE_MODE="no"
DEFAULT_LOGGING="debug"

All vanilla.

A situation occurs where indirectly automounted home directories stop
being mounted at login.

First is seen in /var/log messages:
Jun 19 09:30:56 server1 automount[18399]: statemachine:1383: got
unexpected signal -2147417261!
... The same message occurs once more 15 seconds later... I don't know
what may have happened to cause this, I don't believe I have ever seen
this before and this may be a red herring; possibly due to some other
hardware related issue?

Then, trying to do 'kill -USR1 `pgrep automount` ; kill -HUP `pgrep
automount`' gives this in the messages:

Jun 19 10:32:23 server1 automount[18399]: do_notify_state: signal 10
Jun 19 10:32:23 server1 automount[18399]: master.c:986: assertion
failed: ap->state == ST_READY
Jun 19 10:32:23 server1 automount[18399]: master_notify_state_change:
sig 10 switching /home from 2 to 3

...in response to the USR1 signal.

It looks like it is stuck in some sort of expire limbo.  It was quite
possible that the NFS server did not respond to the mount or unmount
request from the automounter and sent the automounter into some sort of
black hole.

In response to the HUP signal:
Jun 19 10:32:29 server1 automount[18399]: re-reading master map
auto.master
Jun 19 10:32:29 server1 automount[18399]: lookup_nss_read_master:
reading master files auto.master
Jun 19 10:32:29 server1 automount[18399]: parse_init: parse(sun): init
gathered global options: (null)
Jun 19 10:32:29 server1 automount[18399]: lookup_read_master:
lookup(file): read entry /home

...but directories are still not being mounted.  The automounter seems
to be running correctly, but not responding to mount requests.

Our only solution now is to kill -9 the automounter and rpciod (to force
any pending mount/umount requests to fail immediately) and then restart
the automounter.  This works but still truncates the pwd of any process
that is accessing an automounted directory due to the 'umount -l' at
automount startup.

Is this a known problem and will Ian's patches take care of this? TIA.

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
