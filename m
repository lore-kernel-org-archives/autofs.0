From: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Subject: Automount log errors
Date: Tue, 18 Nov 2003 16:13:50 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1069200829.28347.3.camel@ugly>
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

I get these errors in logwatch from autofs:

Use of uninitialized value in hash element at
/etc/log.d/scripts/services/automount line 28, <STDIN> line 2.
Use of uninitialized value in hash element at
/etc/log.d/scripts/services/automount line 28, <STDIN> line 2.


The offending lines are:

while (defined($ThisLine = <STDIN>)) {
...
   elsif ($ThisLine =~ /^mount\(nfs\): nfs: mount failure .*:.* on .*$/)
{
      $Failed{$Mount}{'nfsm'}++;

This is on Fedora Core 1, using autofs-4.1.0-beta3.  Any ideas?

Thanks,

Forrest
