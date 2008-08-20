From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Auto Unmount???
Date: Wed, 20 Aug 2008 10:06:28 -0400
Message-ID: <x49ljyrye57.fsf@segfault.boston.devel.redhat.com>
References: <337607.86418.qm@web54303.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <337607.86418.qm@web54303.mail.re2.yahoo.com> (Thanh Tran's
	message of "Mon, 18 Aug 2008 11:53:08 -0700 (PDT)")
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
To: ttran7700@yahoo.com
Cc: autofs@linux.kernel.org

Thanh Tran <ttran7700@yahoo.com> writes:

> Is auto unmounting supported in autofs version 5?  If so, how do you set the timeout?

You can either set it per mount point or globally.  Per mount point
requires a --timeout=X on the line for the mount point in the master
map.  Globally, it can be set in /etc/sysconfig/autofs (on systems that
use the sysconfig directory).

Cheers,

Jeff
