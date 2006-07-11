From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: nonroot umount
Date: Tue, 11 Jul 2006 19:12:27 -0400
Message-ID: <x49wtajivms.fsf@redhat.com>
References: <920746F6DF728345915EF4D6DA610D0F0111249A@MAILSJ2.global.cadence.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <920746F6DF728345915EF4D6DA610D0F0111249A@MAILSJ2.global.cadence.com>
	(Jim Dennis's message of "Tue, 11 Jul 2006 15:56:50 -0700")
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
To: Jim Dennis <jdennis@cadence.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] nonroot umount; "Jim Dennis" <jdennis@cadence.com> adds:

jdennis> On Date: Tue, 11 Jul 2006 08:39:01 -0400
jdennis> Peter Staubach <staubach@redhat.com> wrote (in response to Marcos Diez
jdennis> <marcos@unitron.com.br>):

>> Marcos Diez wrote:

>>> In a Unix desktop system automount is very practical for CDROMs, 
>>> digital cameras, USB flash drives and any other type of removable
jdennis> media.
>>> But it is annoying to the unprivileged user to wait the timeout to 
>>> remove the media.

>> It seems to me that a better architected solution might be to tie in
jdennis> the automounter with the eject(1) sort of command.

>> It is not good for a user to have to know that he needs to zing the
jdennis> automounter in order to remove his media.

>> Thanx...
>> ps

jdennis>  So, perhaps we could send a patch to the maintainer of the eject
jdennis> utility.  It could detect if the target is
jdennis>  under an autofs and use this code in place of the ioctl() that it would
jdennis> normally send to a CD-ROM or similar
jdennis>  device.

jdennis>  On my OpenSuSE system eject is already marked SUID/root, though it
jdennis> doesn't seem the be the case for my RHEL4
jdennis>  system nor on my Debian system.

jdennis>  As usual I'd limit the risk of another SUID/root binary by marking the
jdennis> executable mode 4550 and associating
jdennis>  it with some relevant group (such as "console").  Thus only processes
jdennis> running in the specified group can attempt
jdennis>  to exploit any vulnerabilities in it.

jdennis>  Question: how would one programmatically detect that a particular
jdennis> mount point is being managed by an autofs process?

I simply don't like this idea.  ;)  As I mentioned before, there are better
mechanisms to deal with removable media.

If, however, you insist on using the automounter for this, then why not
specify a short timeout for removable media?  Put all forms of removable
media in the same map, and use --timeout=1 or 5, or 10, whatever suits
you.  Would that be an acceptable solution?

-Jeff
