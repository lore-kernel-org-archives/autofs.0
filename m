From: Roland Pfretzschner <pfr@math.tu-dresden.de>
Subject: autofs Bug ?
Date: Wed, 24 Mar 2004 12:49:48 +0100 (CET)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200403241149.i2OBnmM05081@NGEW05.math.tu-dresden.de>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org
Cc: Roland Pfretzschner <pfr@math.tu-dresden.de>

Hi there,

I have installed autofs-4.1.0-1 on a Fedora Core 1 System with
Kernel 2.4.22-1.2174.nptlsmp

Often the System crashes, when an USR2 Signal is sent
to an automount process.
This happens under the following conditions:

- there exists a (Network-) filesystem actually mounted
  by that automount process and
- this filesystem is umountable (not busy), but still mounted.
- the Kernel is a smp-Kernel
  (2.4.22-1.2174.nptlsmp or 2.4.22-1.2115.nptlsmp)

Note: autofs-3.1.7-42 does the same thing.
      The problem did not occur under Single Processor Kernels

My workaround for the first time is changing the "stop" function in
/etc/init.d/autofs
Send USR1 instead of USR2, wait a little bit, and then send USR2.
This seems to help avoiding the crash.

Sincerely,

Roland Pfretzschner
---------------------------------------------------------------------------
Dr. Roland Pfretzschner                              pfr@math.tu-dresden.de
Sysadmin
University of Technology Dresden
Departement of Mathematics
Mommsenstr. 13
01062 Dresden, Germany
