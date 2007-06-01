From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: direct maps and root mount points.
Date: Fri, 01 Jun 2007 14:41:37 -0400
Message-ID: <x49wsyn34bi.fsf@segfault.boston.devel.redhat.com>
References: <BAY128-F16E4752E471E7462B7CCD2C92C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BAY128-F16E4752E471E7462B7CCD2C92C0@phx.gbl> (Jose Quentrequeo's
	message of "Fri, 01 Jun 2007 18:17:04 +0000")
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
To: Jose Quentrequeo <jquentre@hotmail.com>
Cc: autofs@linux.kernel.org

==> On Fri, 01 Jun 2007 18:17:04 +0000, "Jose Quentrequeo" <jquentre@hotmail.com> said:

Jose> Hi, I need to setup direct maps in a linux ( 2.4.21-27) using a

This is an old kernel.

Jose> nis server on Solaris 8.  I know that direct mounts are
Jose> supported if you have a non-root mount point (a mount point
Jose> other than '/') but I have several ''root" mount points (ie
Jose> /data).  I want to know if this problem was solved. How?  Are
Jose> there another way to mount nis direct maps ?

You cannot setup /data as a direct mount point using autofs version 4.
Given your old kernel, you cannot use autofs version 5, so you are
stuck.  If your direct maps point at, say, /data/foo, then that would
work.

-Jeff
