From: Ian Kent <raven@themaw.net>
Subject: Re: Problem with autofs_home map
Date: Fri, 16 Nov 2007 15:21:15 +0900
Message-ID: <1195194075.3131.22.camel@raven.themaw.net>
References: <BAC1D28A5AB852439A6914CA7AB4E63F041EE76F@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAC1D28A5AB852439A6914CA7AB4E63F041EE76F@permls05.wde.woodside.com.au>
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
To: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Cc: autofs@linux.kernel.org

On Fri, 2007-11-16 at 12:46 +0900, Coe, Colin C. (Unix Engineer) wrote:
> Hi Ian
> 
> I've just seen autofs5 (yay!) in the RHEL4 channels so I'm giving it a
> shot but it's not looking good so far.
> 
> /rhome still isn't created and the real /home is still getting over
> ridden.  Also, automount5 is core dumping and /var/log/debug is still
> empty.

That's bad.

How about having a look at this I put together a while ago for testing.
Obviously most of this you've already done but will prove to be a good
check and then there's the gdb instructions as well.


If you think you have found a problem
-------------------------------------

- A problem that can be duplicated can be resolved.

  If the steps that lead to a problem are known and then problem can
  be reliably duplicated using these steps, then this is often enough
  to resolve the issue. Including these steps in a problem report is
  invaluable.

- Always capture log level "debug" syslog output.

  Including a syslog trace of autofs debug output can be very useful
  in understanding what has happened in the event of a problem.

  This can be done by performing the following steps:

  1) Direct all syslog facility "daemon" output to a logfile.

     To do this add an entry to /etc/syslog.conf for the facility
     "daemon":

     daemon.*			/var/log/daemon.debug

     and restart syslog using "service syslog restart".

  2) Enable debug logging in autofs version 5.
     To do this change the entry in /etc/sysconfig/autofs from

     #DEFAULT_LOGGING="none"

     to

     DEFAULT_LOGGING="debug"

     and restart autofs using "service autofs restart".

- In addition to the debug log, include
  - maps that exhibit the problem (along with the master map).
  - copy of /etc/nsswitch.conf.
  - copy of /etc/sysconfig/autofs.
  - version information of autofs and kernel (with "rpm -q autofs"
    and "uname -r").

- Obtain stack traces for an automounter that hangs or dumps core.

  In this situation it is very useful to determine what is going on
  within the automount program at the time of the crash. In particular
  it is useful to know the function calls leading up to the
  problem. This can be done by inspecting the program threads within
  gdb and getting a backtrace of the ones that appear to be in an
  unusual state.

  To do this:

  1) Ensure that the autofs-debuginfo package is installed.

  2) Run gdb against the hung process using

     gdb -p <automount pid> /usr/sbin/automount

     or against the core file

     gdb -c /core.<automount pid> /usr/sbin/automount

     Then list the program threads with

     (gdb) info threads

     Next, generate the stack traces for all threads with

     (gdb) thr a a bt

  3) Collect the information from above and include in problem report.
