From: "s. lele" <satlele@yahoo.co.in>
Subject: Query about autofs4 module
Date: Fri, 17 Dec 2004 12:52:01 +0000 (GMT)
Message-ID: <20041217125201.55052.qmail@web8404.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

Their was one problem reported as follows:
RHEL3 U3 X86 system generates automount messages to
/var/log/messages that look like: 
automount[<pid>]: BUG: <mount_point> already mounted 

After checking the following bugzilla web-link:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132831,
the problem was found due to autofs module.
autofs module need to be unloaded and autofs4 module
need to be loaded.
The following steps steps should hopefully resolve the
problem:
# service autofs stop
# rmmod autofs
# service autofs start
which should show autofs4 module in "lsmod" command. 

My query is as follows:
Before unloading autofs module and loading autofs4
module, just want to confirm if the following autofs
options will be honoured  with autofs4 module in NIS
environment (used for automounting) without any
problem:

test
-hard,tcp,intr,bg,rsize=32768,wsize=32768,retry=100
xxxx:/export/home/home_00/test
/usr/sbin/automount /home yp auto.home --timeout 3600
-XXX=i686-pc-linux2.4.21-ZZZ

Thanks for your help.

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
