From: "Jim Dennis" <jdennis@cadence.com>
Subject: Re: nonroot umount
Date: Tue, 11 Jul 2006 15:56:50 -0700
Message-ID: <920746F6DF728345915EF4D6DA610D0F0111249A@MAILSJ2.global.cadence.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
To: autofs@linux.kernel.org

 

On Date: Tue, 11 Jul 2006 08:39:01 -0400
Peter Staubach <staubach@redhat.com> wrote (in response to Marcos Diez
<marcos@unitron.com.br>):

> Marcos Diez wrote:

>> In a Unix desktop system automount is very practical for CDROMs, 
>> digital cameras, USB flash drives and any other type of removable
media.
>> But it is annoying to the unprivileged user to wait the timeout to 
>> remove the media.

> It seems to me that a better architected solution might be to tie in
the automounter with the eject(1) sort of command.

> It is not good for a user to have to know that he needs to zing the
automounter in order to remove his media.

>    Thanx...
>       ps

 So, perhaps we could send a patch to the maintainer of the eject
utility.  It could detect if the target is
 under an autofs and use this code in place of the ioctl() that it would
normally send to a CD-ROM or similar
 device.

 On my OpenSuSE system eject is already marked SUID/root, though it
doesn't seem the be the case for my RHEL4
 system nor on my Debian system.

 As usual I'd limit the risk of another SUID/root binary by marking the
executable mode 4550 and associating
 it with some relevant group (such as "console").  Thus only processes
running in the specified group can attempt
 to exploit any vulnerabilities in it.

 Question: how would one programmatically detect that a particular mount
point is being managed by an autofs process?

JDennis
