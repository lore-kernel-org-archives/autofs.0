From: Marc Weber <marco-oweber@gmx.de>
Subject: automount and upstart
Date: Fri, 18 Dec 2009 04:33:03 +0100
Message-ID: <1261107009-sup-879@nixos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Consider this case:

a) start automount

b) cd /auto # automount can't unmount it

c) stop automount

  upstart will send SIGTERM to automount.
  automount replies by writing the debugging info
  "Got your signal, but won't quit because I can't umount /auto"

  upstart will then send SIGKILL after some time ..
  (Or I will)..

  However when this happens nobody umounts /auto and the submounts.

Fix: umount -l /auto could be run when SIGTERM is received.
This will ask the kernel to umount those remaining filesystems as soon
as possible. Does this make sense?

Marc Weber
