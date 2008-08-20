From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Is Autofs 5 Slower Than 4
Date: Wed, 20 Aug 2008 10:07:36 -0400
Message-ID: <x49hc9fye3b.fsf@segfault.boston.devel.redhat.com>
References: <750043.92565.qm@web54305.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <750043.92565.qm@web54305.mail.re2.yahoo.com> (Thanh Tran's
	message of "Tue, 19 Aug 2008 11:16:42 -0700 (PDT)")
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

> The Autofs automounting was never blazing fast.  However, autofs 5
> seems much slower than the previous version.  It takes a long time for
> autofs to mount my detachable drives.  It eventually happens; it just
> takes a long time.  Is there a way to improve this speed?  Thanks.

Could you quantify this?  What exactly are you doing?  Are you sure
autofs is the cause of the sluggishness?  Did you upgrade your entire
operating system or just autofs from version 4 to 5?  Can you provide a
debug log?

Cheers,

Jeff
