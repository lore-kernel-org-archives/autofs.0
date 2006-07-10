From: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Subject: automount removes mountpoint upon exit
Date: Mon, 10 Jul 2006 12:59:34 +0200
Message-ID: <44B23316.7050808@ant.uni-bremen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi list,

We use automount 4.1.3 in our Kubuntu cluster.
In this cluster, all machines mount their nfsroot ro for security 
reasons, except for one "master" machine which is used to maintain the 
nfsroot.
I discovered that every time the master machine shuts down, all the 
autofs mountpoints are removed. If another machine reboots while the 
master machine is down, autofs is unable to recreate the mountpoints and 
thus fails.

Is there any way to keep automount from removing the mountpoint upon exit?

Thanks for your help,

Heinrich Rebehn

University of Bremen
Physics / Electrical and Electronics Engineering
- Department of Telecommunications -

Phone : +49/421/218-4664
Fax   :            -3341
