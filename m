From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Automatic reloading of file maps?
Date: 19 May 2004 17:23:09 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <ufaekpgt5te.fsf@epithumia.math.uh.edu>
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Under older versions of autofs, changes in file maps are automatically
picked up by the automount daemons.  I can just push out a new set of
maps and they are used without tickling the daemons at all; the next
time the filesystem is mounted, the new entry is used.  That doesn't
seem to work now (under 4.1.2) and I'm wondering if this is expected
behavior.

 - J<
