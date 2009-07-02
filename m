From: Thomas Chan <tchan@ilm.com>
Subject: autofs stops working after a while with USE_MISC_DEVICE
Date: Thu, 2 Jul 2009 11:55:58 -0700 (PDT)
Message-ID: <alpine.LRH.2.00.0907021136230.2710@talon.lucasfilm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


I am using autofs 5.0.4 with the latest patches up to 12-Jun-2009 with 
the 2.6.29.1 kernel.

I noticed that after a while (overnight) new automounts would no longer 
work.

An strace shows:
rt_sigtimedwait(~[CHLD CONT RTMIN RT_1],

[pid 26289] 11:22:57 gettimeofday({1246558977, 61322}, NULL) = 0
[pid 26289] 11:22:57 futex(0x7f6f5db43160, FUTEX_WAKE_PRIVATE, 1) = 0
[pid 26289] 11:22:57 clock_gettime(CLOCK_REALTIME, {1246558977, 61421426}) = 0
[pid 26289] 11:22:57 futex(0x7f6f5db43124, FUTEX_WAIT_PRIVATE, 150501, {0, 999900574}) = -1 ETIMEDOUT (Connection timed out)
[pid 26289] 11:22:58 gettimeofday({1246558978, 61986}, NULL) = 0
[pid 26289] 11:22:58 futex(0x7f6f5db43160, FUTEX_WAKE_PRIVATE, 1) = 0
[pid 26289] 11:22:58 clock_gettime(CLOCK_REALTIME, {1246558978, 62086850}) = 0
[pid 26289] 11:22:58 futex(0x7f6f5db43124, FUTEX_WAIT_PRIVATE, 150503, {0, 999899150}) = -1 ETIMEDOUT (Connection timed out)

lsof shows that automount has 10288 files open, of which most of these 
are like:

automount 15539      root *217u     sock                0,4 
595374 can't identify protocol
automount 15539      root *218u     sock                0,4 
595376 can't identify protocol
automount 15539      root *219u     sock                0,4 
595378 can't identify protocol
automount 15539      root *220u     sock                0,4 
595380 can't identify protocol

Upon restarting autofs, these open files are cleared out and automount 
works, but the open files gradually build up again.

After setting USE_MISC_DEVICE=no, I no longer get the open file issue, but 
we are trying to remedy the autofs lazy unmount / cwd issue.

Any ideas would be appreciated.

Thomas
