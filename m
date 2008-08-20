From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Auto Unmount???
Date: Wed, 20 Aug 2008 11:32:12 -0400
Message-ID: <x49skszwvlv.fsf@segfault.boston.devel.redhat.com>
References: <933512.68167.qm@web54307.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <933512.68167.qm@web54307.mail.re2.yahoo.com> (Thanh Tran's
	message of "Wed, 20 Aug 2008 08:20:47 -0700 (PDT)")
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

> I did notice some timeout values in my sysconf/autofs.  I thought
> those flags set the amount of time autofs would try to mount something
> before giving up.  Which flag sets the timeout?  Perhaps, you mean the
> option flag?  Thanks.

The timeout specifies the length of inactivity before a mount is
expired.  Please see the man page for auto.master.

Cheers,

Jeff
