From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Bug#299298: autofs: set -e still too strong
Date: Sun, 13 Mar 2005 13:32:55 +0100
Message-ID: <20050313123255.GA1855@uio.no>
References: <E1DARve-0008Na-00@bohr.home>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1DARve-0008Na-00@bohr.home>
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
To: Tim Connors <tconnors+reportbug@astro.swin.edu.au>, 299298@bugs.debian.org
Cc: autofs@linux.kernel.org

On Sun, Mar 13, 2005 at 11:10:42PM +1100, Tim Connors wrote:
> If restarting autofs when a mountpoint is busy, or if the daemon has
> been killed manually, then the script never gets around to doing
> anything, failing midsentence, without printing an proper error
> message, because the start-stop-daemon isn't protected, despite the
> error code being explicitly checked thereafter:
> 
> 30600,43>  /etc/init.d/autofs restart
> Stopping automounter:1-0-23:03:30, Sun Mar 13 root@bohr:/home/tconnors (bash)

I'll forward this upstream, but I think in general "set -e" makes a lot more
sense than just silently go on if anything unexpected would fail. To me, it
looks like the init script should simply check the return value of
start-stop-daemon; I don't think just removing "set -e" is the magic bullet.

(Rest of the mail kept for Ian and the others on the autofs mailing list :-) )

> Since it makes sense to run restart when the daemon could possibly be
> not there (since restart is the automatic thing to do upon an
> upgrade), and since it makes sense to restart the daemon when a
> mountpoint is busy (new processes will get the new mountpoint with new
> mount flags, old processes will continue to use the stale mount
> point), then I think the proper thing to do is to print the message,
> and then just continue as before.
> 
> Is `set -e' really the right thing to do?  I think a wise man
> (possibly Dijkstra) once said "don't check for errors you don't
> explicitly know how to handle".  Since we already check for all
> conceivable errors, then does an extra `set -e' help anything?  It
> only seems to cause us to not issue correct errors when we really do
> fail -- see also bug 295480.
> 
> Relevant trace follows:
> 
> 30599,42> bash -x /etc/init.d/autofs restart
> + FLAGS='defaults 21'
> + DAEMON=/usr/sbin/automount
> ...
> + debian restart
> + set -e
> + case "$1" in
> + debian stop
> + set -e
> + case "$1" in
> + echo -n 'Stopping automounter:'
> Stopping automounter:+ umount_loopback
> ++ LC_ALL=C
> ++ awk '!/^#/ && $1 ~ /^\/dev\/loop/ && $2 != "/" {print $2}' /proc/mounts
> + loops=
> ++ LC_ALL=C
> ++ awk '!/^#/ && $1 ~ /^automount/ {print $2}' /proc/mounts
> + automounts=/var/autofs/net
> ++ LC_ALL=C
> ++ awk '!/^#/ && $1 ~ /^\/dev\/loop/ && $2 != "/" {print $1}' /proc/mounts
> + loopmnts=
> + any=0
> ++ ls /var/run/autofs/_var_autofs_net.pid
> + for file in '`ls /var/run/autofs/*.pid 2>/dev/null`'
> + '[' -e /var/run/autofs/_var_autofs_net.pid ']'
> + any=1
> ++ head -n 1 /var/run/autofs/_var_autofs_net.pid
> + pid=31598
> ++ ps -wwo cmd= 31598
> ++ sed -e 's,.* --pid-file=/var/run/autofs/\([^ ]*\)\.pid.*,\1,; s,_,/,g'
> + mnt=
> + start-stop-daemon --stop --quiet --retry USR2/20 --pidfile /var/run/autofs/_var_autofs_net.pid --exec /usr/sbin/automount
> 1-0-23:01:24, Sun Mar 13 root@bohr:/home/tconnors (bash)

/* Steinar */
-- 
Homepage: http://www.sesse.net/
