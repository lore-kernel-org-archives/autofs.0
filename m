From: Simon Gao <gao@schrodinger.com>
Subject: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Fri, 11 Apr 2008 09:08:39 -0700
Message-ID: <47FF8D07.7080208@schrodinger.com>
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

Hi,

We have many RHEL 5.1 desktops running 2.6.18-53.1.14 X86_64. Many of 
them have core dump files related to autofs. The autofs package is
autofs-5.0.1-0.rc2.55.el5.3.

# strings core.2594 | head
@UUUU
@xUUU
PxUUU
QqUU
CORE
P*fqUU
dgqUU
CORE
automount
automount -DOSNAME=rhel -DOSREL=5

# strings core.3666 | head
@UUUU
 xUUU
@xUUU
BWUU
CORE
6xUUU
VWUU
XWUU
CORE
automount

What caused autofs to core dump? Is there a fix by upgrading to newer 
version?

Simon
