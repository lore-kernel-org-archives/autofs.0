From: Sev Binello <sev@bnl.gov>
Subject: automount hung
Date: Fri, 18 Mar 2005 15:02:40 -0500
Message-ID: <423B33E0.3020109@bnl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


Has anyone had the experience where the automount daemon seems to freeze ?
It will not expire anything, nor mount anything new ?

An strace on automount shows thats it's stuck on the following line....

# strace -p 3719
Process 3719 attached - interrupt to quit
futex(0x24720c, FUTEX_WAIT, 2, NULL


Tried to activate strace by accessing automatically mounted
filesystems, but saw now activity in automount using strace.
Also, no entry appeared in /etc/mtab.


Thanks
-Sev
