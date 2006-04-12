From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: newbie autofs problem
Date: Wed, 12 Apr 2006 14:37:00 -0400
Message-ID: <x49odz61vzn.fsf@segfault.boston.redhat.com>
References: <20060410154504.GD1223@pollo.upc.es>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060410154504.GD1223@pollo.upc.es> (pablo roldan's message of
	"Mon, 10 Apr 2006 17:45:04 +0200")
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
Content-Transfer-Encoding: 7bit
To: pablo.roldan@upc.edu
Cc: autofs@linux.kernel.org

==> Regarding [autofs] newbie autofs problem; pablo.roldan@upc.edu adds:

pablo.roldan> Hi, I'm using autofs to automount the home dirs of my users,
pablo.roldan> distributed among several machines. The config files are:

pablo.roldan> ***** /etc/auto.master: ***** /home /etc/auto_home ***** end
pablo.roldan> /etc/auto.master *****

pablo.roldan> ***** /etc/auto_home: ***** canalias -rsize=8192,wsize=8192
pablo.roldan> e04:/homes/& jmbenita -rsize=8192,wsize=8192 e05:/homes/& ...
pablo.roldan> ***** end /etc/auto_home *****

pablo.roldan> Until now, it was all working fine. A few days ago I moved
pablo.roldan> the directory e04:/homes from / to a (larger) partition,
pablo.roldan> which I now mount as /homes:

Did you make sure that no clients had the file system mounted?  You simply
can't move things around like this and expect it to work.

pablo.roldan> ***** /etc/fstab: ***** # /etc/fstab: static file system
pablo.roldan> information.  # #<file sys> <mount point> <type> <options>
pablo.roldan> <dump> <pass> /dev/sda3 / ext3 rw,errors=remount-ro 0 1
pablo.roldan> /dev/sda2 none swap rw 0 0 none /proc proc defaults 0 0 none
pablo.roldan> /proc/bus/usb usbdevfs defaults /dev/fd0 /floppy auto
pablo.roldan> users,noauto 0 0 /dev/sda5 /usr ext3 defaults 0 2 /dev/sda6
pablo.roldan> /homes ext3 defaults 0 2 ***** end /etc/fstab *****

pablo.roldan> Since that moment, I am having problems accessing anything
pablo.roldan> below /home. For instance, I can't do

pablo.roldan> 	ls /home

pablo.roldan> because the shell hangs. It just becomes irresponsive.

On the client system?  I'm surprised it hangs, but ESTALE would be very
likely.  Alt-Sysrq-t will show where the ls is hanging out.  However, this
really sounds like an administrative error.  Reboot the client.

The automounter logs to /var/log/messages.  You should check there for any
error messages if you feel this isn't purely a user error.

-Jeff
