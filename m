From: Roland Pfretzschner <pfr@math.tu-dresden.de>
Subject: Re: Fwd: autofs Bug ?
Date: Tue, 6 Apr 2004 12:02:53 +0200 (CEST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200404061002.i36A2s905388@NGEW05.math.tu-dresden.de>
References: <20040405193100.24698.qmail@web41111.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040405193100.24698.qmail@web41111.mail.yahoo.com> from "John
	Saalwaechter" at Apr 05, 2004 12:31:00 
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org, John Saalwaechter <bababooey182@yahoo.com>
Cc: Roland Pfretzschner <pfr@math.tu-dresden.de>

Hi, John

> --- John Saalwaechter <bababooey182@yahoo.com> wrote:
> > Date: Fri, 26 Mar 2004 14:44:02 -0800 (PST)
> > From: John Saalwaechter <bababooey182@yahoo.com>
> > Subject: [autofs] autofs Bug ?
> > To: autofs@linux.kernel.org
> > 
> > Roland, I'm very interested in your comments.  I'm in an
> > environment with a relatively sophisticated automounter
> > setup, with Sun, SGI, HP-UX, and Linux machines.  The Linux
> > machines are mostly stock Red Hat 9, with its default autofs.
> > 
> > Occasionally the automounter on multiple Linux machines will
> > completely stop functioning, which correlates to them being
> > stuck in the "D" state in "ps ax" output.  Attempts to simply
> > stop and restart the automounters with
> > "/etc/init.d/autofs stop; /etc/init.d/autofs start" always
> > make the problem worse.  After the restart the load on the
> > Linux box will rise until it's high, and there will be multiple
> > automount daemons for the same mount point.  A full system
> > reboot is the only solution we have right now for this situation.
> > I also suspect that the affected systems are all multiprocessors.

My problem with Fedora Core 1 was a little bit different.
The automount did not only stop functioning, but the whole machine
was dead. Reset button was the only possible action.

But one of my tests showed a similar result as you wrote:
The following loop

  while true
  do ls ~user1 ~user2 /net/host1/usr >/dev/null ; sleep 1
     pkill -USR2 automount ; sleep 1 ; /etc/init.d/autofs start ; sleep 1
  done

accumulated more and more automount processes.

> > 
> > You mention sending the USR1 signal in the stop method, then
> > pausing, then sending USR2.  Why did you think to do that?  Can
> > you please post your modified /etc/init.d/autofs script, or at
> > least the stop method?  That would be greatly appreciated.

The original stop function in /etc/init.d/autofs of the
autofs-4.1.0-1 RPM looks as follows:
--------------------------------
           echo -n $"Stopping $prog:"
        if [ -z "`pidofproc $prog`" -a -z "`getmounts`" ]; then
                success $"$prog shutdown"
                RETVAL=0
        else
                killproc $DAEMON -USR2 2> /dev/null
                RETVAL=$?
        fi
        count=0
        while [ -n "`/sbin/pidof $DAEMON`" -a $count -lt 10 ] ; do
           killproc $DAEMON -USR2 2> /dev/null
           RETVAL=$?
           [ $RETVAL = 0 -a -z "`/sbin/pidof $DAEMON`" ] || sleep 3
           count=`expr $count + 1`
        done
        umount -a -f -t autofs
        rm -f /var/lock/subsys/autofs
        echo
--------------------------------
where the Variable DAEMON is set to /usr/sbin/automount ,
      the Variable prog   is set to automount , and the
function "killproc", defined in /etc/init.d/functions , sends the
given signal to the named processes.

In the above stop function, immediately after sending the USR2 signal in the 
else-Branch, the automount process is still alive, because it takes a while
to go down. And therefore, the while-loop begins working and sends a second USR2.
This was the moment when the automount process crashed, especially when there
were umountable (not busy) (Network-) filesystems mounted.

The workaround is simple and seems to help:

In the else-Branch above I replaced the USR2 by USR1 , 
and between "fi" and "count=0" I inserted "sleep 2".
The effect should be, that all umountable filesystems are umounted
before the automount process receives a USR2.
As said before, it seems to work.

Sincerely,

Roland Pfretzschner
---------------------------------------------------------------------------
Dr. Roland Pfretzschner                              pfr@math.tu-dresden.de
Sysadmin
University of Technology Dresden
Departement of Mathematics
Mommsenstr. 13
01062 Dresden, Germany
