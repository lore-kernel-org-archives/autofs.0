From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: How exactly does timeout work?
Date: Mon, 09 Apr 2007 12:57:55 -0400
Message-ID: <x49odlxxz70.fsf@segfault.boston.devel.redhat.com>
References: <1176133554.30046.175.camel@psmithub>
	<x49wt0ly17p.fsf@segfault.boston.devel.redhat.com>
	<x49slb9xzu6.fsf@segfault.boston.devel.redhat.com>
	<1176137315.30046.185.camel@psmithub>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1176137315.30046.185.camel@psmithub> (Paul Smith's message of
	"Mon, 09 Apr 2007 12:48:35 -0400")
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
To: psmith@netezza.com
Cc: autofs@linux.kernel.org

==> On Mon, 09 Apr 2007 12:48:35 -0400, Paul Smith <psmith@netezza.com> said:

Paul> On Mon, 2007-04-09 at 12:44 -0400, Jeff Moyer wrote: > Jeff> If
Paul> you set the timeout to 60 seconds, the automount daemon will >
Paul> Jeff> wake up approximately every 15 seconds (4 times per
Paul> timeout, see > Jeff> CHECK_RATIO in the daemon) and ask the
Paul> kernel if it is okay to > Jeff> expire the mount.
Paul> > 
Paul> > I guess I should further qualify this.  Asking the kernel
Paul> means > issuing an ioctl.  The kernel then checks the access
Paul> time for the > mount point and, if it is > timeout seconds ago,
Paul> it will try to expire > the mount (by calling out to the
Paul> daemon).

Paul> Perfect; that's what I was looking for.  So, CHECK_RATIO is a
Paul> constant regardless of the size of the timeout?  So if I make my
Paul> timeout 10 hours it will check every 2.5 hours (unless I change
Paul> the constant in the daemon code)?

That is correct.

-Jeff
