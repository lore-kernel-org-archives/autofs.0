From: Jeff Moyer <jmoyer@redhat.com>
Subject: RFT: new autofs test package with map expiry changes
Date: Thu, 5 Aug 2004 16:11:48 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16658.38020.371365.856850@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
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
Cc: Michael Blandford <michael@kmaclub.com>, raven@themaw.net

Hello,

I've put together a package with a recent version of Ian's map expiry
code.  Please test this code so we can shake bugs out more quickly.
Detailed bug reports would be most appreciated.  I also posted a kernel
patch against 2.6.7, which is _required_.  autofs-4.1.3-11 is the version
with these changes.

To be perfectly redundant, this stuff quite probably will break.  Run it on
test systems only!

Packages are at the usual place:
     http://people.redhat.com/jmoyer/

Please let me know if you have any questions, and thanks in advance for
running this stuff!

-Jeff
