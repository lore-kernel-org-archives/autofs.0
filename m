From: Donald Arseneau <asnd@triumf.ca>
Subject: Signal USR1 does not force unmount
Date: 26 Sep 2005 19:48:59 -0700
Message-ID: <yfi8xxjb4ys.fsf@triumf.ca>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Hello maintainers,

According to the automount manual, signal USR1 is supposed to 
immediately cause unmounting of inactive filesystems, but
 
  killall -s USR1 automount

(and similar kill commands) has no noticable effect; one must 
wait for the regular expiry time before the system gets unmounted.

Signal USR2 does function as described, causing automount to
exit when filesystem is inactive.


Versions:

Linux automount version 4.1.3-114

Fedora Core (2.6.12-1.1378_FC3)

-- 
Donald Arseneau                          asnd@triumf.ca
