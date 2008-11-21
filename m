From: Joe Pruett <joey@clean.q7.com>
Subject: now with simple setup, still getting occasional failures
Date: Fri, 21 Nov 2008 07:54:48 -0800 (PST)
Message-ID: <alpine.LRH.2.00.0811210744140.21285@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: autofs@linux.kernel.org

i have now changed my setup to be totally straightforward.  /home has 
normal direct mounts for everything, like:

shipper hyperion:/disk/0/home/shipper

auto.master has:

/home auto.home  --timeout=900

on a very lightly loaded system i am seeing the following error 1-2 times 
per day:

Nov 20 22:30:01 titan automount[1743]: do_mount_indirect: indirect trigger not valid or already mounted /home/shipper

shipper has 4 cron jobs that fires off every 30 minutes.  when this 
problem happens, just the first cron job fails, the rest run fine.

i have just turned on automount debugging logging, but from past 
experience that seems to mask most problems.

this is on centos 5 with stock kernel and autofs rpms:
autofs-5.0.1-0.rc2.88
kernel-2.6.18-92.1.18.el5

i have also enabled the nis netid feature so that i'm not using large 
amounts of privileged ports.

is there anything else i should be looking at?
