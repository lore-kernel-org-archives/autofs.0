From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: nonroot user umount
Date: Thu, 13 Jul 2006 09:24:15 -0400
Message-ID: <x491wspbpts.fsf@segfault.boston.redhat.com>
References: <44B11E87.5000802@unitron.com.br>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44B11E87.5000802@unitron.com.br> (Marcos Diez's message of
	"Sun, 09 Jul 2006 15:19:35 +0000")
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
To: Marcos Diez <marcos@unitron.com.br>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] nonroot user umount; Marcos Diez <marcos@unitron.com.br> adds:

marcos> Hello everybody!  In a Unix desktop system automount is very
marcos> practical for CDROMs, digital cameras, USB flash drives and any
marcos> other type of removable media.  But it is annoying to the
marcos> unprivileged user to wait the timeout to remove the media.

marcos> Since it is insecure to allow the user to do a "killall -s SIGUSR1
marcos> automount", I wrote a program that does exactly (and only) that. Of
marcos> course it must be suid root, but it makes life much easier. I
marcos> double verified that there are no buffer overflows and I believe
marcos> it's safe. The program is not interactive, so a malicious user
marcos> can't do much with it anyway.

marcos> It gets the PIDs from instances of automount by parsing
marcos> /proc/mounts It would be nice if it could be added to the autofs
marcos> distribution.

Why not simply use udev/hal?  Are you not running a somewhat recent
desktop?  There are other alternatives, too.  Why not simply add an entry
to the fstab, specifying "user"?  Without good answer to these questions,
I'm definitely against adding such a kludge.

-Jeff
