From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: How exactly does timeout work?
Date: Mon, 09 Apr 2007 12:14:18 -0400
Message-ID: <x49wt0ly17p.fsf@segfault.boston.devel.redhat.com>
References: <1176133554.30046.175.camel@psmithub>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1176133554.30046.175.camel@psmithub> (Paul Smith's message of
	"Mon, 09 Apr 2007 11:45:54 -0400")
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

==> On Mon, 09 Apr 2007 11:45:54 -0400, Paul Smith <psmith@netezza.com> said:

Paul> I've looked around but I couldn't find an answer to this
Paul> question.  There are a lot of offhand comments saying the
Paul> filesystem will be unmounted after timeout seconds, but that's
Paul> not very precise.

Paul> If, for example, I set --timeout=60, does that mean the FS will
Paul> unmount 60 seconds after it was last accessed?

Paul> Or, does it mean that every 60 seconds automount will wake up
Paul> and see if anyone is using the filesystem, and if not unmount
Paul> it?

If you set the timeout to 60 seconds, the automount daemon will wake
up approximately every 15 seconds (4 times per timeout, see
CHECK_RATIO in the daemon) and ask the kernel if it is okay to expire
the mount.

-Jeff
