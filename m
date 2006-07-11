From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: nonroot umount
Date: Tue, 11 Jul 2006 09:47:06 -0400
Message-ID: <x49veq4l0dh.fsf@redhat.com>
References: <200607100726.k6A7Po1e029994@hera.kernel.org>
	<44B2E238.2010203@unitron.com.br> <44B39BE5.6040309@redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44B39BE5.6040309@redhat.com> (Peter Staubach's message of "Tue,
	11 Jul 2006 08:39:01 -0400")
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org, Marcos Diez <marcos@unitron.com.br>

==> Regarding Re: [autofs] nonroot umount; Peter Staubach <staubach@redhat.com> adds:

staubach> Marcos Diez wrote:
>> In a Unix desktop system automount is very practical for CDROMs, digital
>> cameras, USB flash drives and any other type of removable media.
>> But it is annoying to the unprivileged user to wait the timeout to
>> remove the media.
>> 
>> Since it is insecure to allow the user to do a "killall -s SIGUSR1
>> automount", I wrote a program that does exactly (and only) that. Of
>> course it must be suid root, but it makes life much easier. I double
>> verified that there are no buffer overflows and I believe it's safe. The
>> program is not interactive, so a malicious user can't do much with it
>> anyway.
>> 
>> It gets the PIDs from instances of automount by parsing /proc/mounts
>> It would be nice if it could be added to the autofs distribution.
>> 
>> 
>> http://boby.unitron.com.br/%7Emarcos/umounter.c
>> 
>> 
>> To compile:
>> 
>> gcc -O3 -ansi -Wall -pedantic umounter.c -o umounter
>> 
>> To install:
>> cp umounter /usr/local/bin && chmod 4711 /usr/local/bin/umounter
>> 
>> To use:
>> 
>> ./umounter
>> or
>> ./umounter --verbose
>> (show the signaled PIDs )
>> 

staubach> It seems to me that a better architected solution might be to tie in
staubach> the automounter with the eject(1) sort of command.

staubach> It is not good for a user to have to know that he needs to zing the
staubach> automounter in order to remove his media.

What "desktop" system are we talking about?  If you're using hal/udev, then
they have a much nicer mechanism for handling such things.  Autofs isn't
really a good fit for removable media, in my experience.

-Jeff
