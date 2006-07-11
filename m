From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount removes mountpoint upon exit
Date: Tue, 11 Jul 2006 10:29:56 -0400
Message-ID: <x49r70skye3.fsf@redhat.com>
References: <44B23316.7050808@ant.uni-bremen.de>
	<x494pxp1ql7.fsf@segfault.boston.redhat.com>
	<44B3B06F.90006@ant.uni-bremen.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44B3B06F.90006@ant.uni-bremen.de> (Heinrich Rebehn's message of
	"Tue, 11 Jul 2006 16:06:39 +0200")
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
To: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] automount removes mountpoint upon exit; Heinrich Rebehn <rebehn@ant.uni-bremen.de> adds:

rebehn> Jeff Moyer wrote:
rebehn> Thank you for the patch, Jeff.
rebehn> However, i failed to understand the debian package system and
rebehn> simply have no time to read a couple of manpages and howtos just to
rebehn> implement this small patch. So i simply set the immutable flag on
rebehn> our server and it works!

rebehn> Will this patch be in the officcial version some day, so we
rebehn> eventually see it in debian or ubuntu?

Yes, it already is in 4.1.4.  Ask the debian maintainer to upgrade autofs
to that.  It's been out for some time, now.

-Jeff
