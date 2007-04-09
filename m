From: Paul Smith <psmith@netezza.com>
Subject: Re: How exactly does timeout work?
Date: Mon, 09 Apr 2007 12:48:35 -0400
Message-ID: <1176137315.30046.185.camel@psmithub>
References: <1176133554.30046.175.camel@psmithub>
	<x49wt0ly17p.fsf@segfault.boston.devel.redhat.com>
	<x49slb9xzu6.fsf@segfault.boston.devel.redhat.com>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49slb9xzu6.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Mon, 2007-04-09 at 12:44 -0400, Jeff Moyer wrote:
> Jeff> If you set the timeout to 60 seconds, the automount daemon will
> Jeff> wake up approximately every 15 seconds (4 times per timeout, see
> Jeff> CHECK_RATIO in the daemon) and ask the kernel if it is okay to
> Jeff> expire the mount.
> 
> I guess I should further qualify this.  Asking the kernel means
> issuing an ioctl.  The kernel then checks the access time for the
> mount point and, if it is > timeout seconds ago, it will try to expire
> the mount (by calling out to the daemon).

Perfect; that's what I was looking for.  So, CHECK_RATIO is a constant
regardless of the size of the timeout?  So if I make my timeout 10 hours
it will check every 2.5 hours (unless I change the constant in the
daemon code)?

-- 
-----------------------------------------------------------------------------
 Paul D. Smith <psmith@netezza.com>                       http://netezza.com
 "Please remain calm--I may be mad, but I am a professional."--Mad Scientist
-----------------------------------------------------------------------------
      These are my opinions--Netezza takes no responsibility for them.
