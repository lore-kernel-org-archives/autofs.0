From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: backfstype patch.
Date: Wed, 30 Jun 2004 10:22:59 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16610.52419.405435.503795@segfault.boston.redhat.com>
References: <40E1CCC3.1010809@deragon.biz>
	<40E2C0BA.3070605@sun.com>
	<16610.50525.858094.848839@segfault.boston.redhat.com>
	<40E2CC43.1060001@sun.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40E2CC43.1060001@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] backfstype patch.; Mike Waychison <Michael.Waychison@Sun.COM> adds:

Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE-----
Hash> SHA1

Michael.Waychison> Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] backfstype patch.; Mike Waychison
>> Michael.Waychison@Sun.COM> adds:
>> 
Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE-----
Hash> SHA1
>>
Michael.Waychison> Hans Deragon wrote:
>>
>>>> Greetings.
>>>> 
>>>> 
>>>> Attached, my patch for supporting backfstype.  If the OS is Linux and
>>>> cachefs is detected, this fs is ignored and no attempt is made to
>>>> mount a cachefs kernel module (none exist).  This way we avoid useless
>>>> error messages in syslog.
>>>> 
>>>> If mounting the fstype fails or is cachefs, backfstype is then tried.
>>>> 
>>>> It works fine under RHL 9.  Only one file was changed: parse_sun.c.
>>>> The changes were made from the 4.1.3 branch.  Changes are very
>>>> localized and I believe they are safe (though code inspection is
>>>> always desired).
>>>> 
>>>> Please confirm if my patch has been accepted.
>>>> 
>>
Michael.Waychison> Why do this in the parser when it can easily be done in
Michael.Waychison> a mount module?
>> Care to expound a bit?  I'm not sure what people use backfstype for,
Michael.Waychison> but if
>> it is generic, then you wouldn't want to handle every case in every
>> mount module.  But I think I'm missing your point.
>> 
>> It makes some sense to me to handle this above the mount module, simply
>> because you could call into two different modules.
>> 
>> So, care to set me straight?  ;)
>> 
>> -Jeff

Michael.Waychison> I'm CC'ing David as he may have a better view of what
Michael.Waychison> the cachefs status is.

Michael.Waychison> Backfstype is a fstype=cachefs specific mount option.
Michael.Waychison> Specifically:

Michael.Waychison>  - add cachefs to the not_generic array in
Michael.Waychison> daemon/mount.c - create a new mount module,
Michael.Waychison> modules/mount_cachefs.c.  This module would check for
Michael.Waychison> cachefs support available and use it if available.
Michael.Waychison> Otherwise it would rewrite the fstype with the
Michael.Waychison> backfstype mount option and call do_mount again.

Okay, that makes much more sense now.  Agreed.

Oh, and you forgot to CC David.  ;)

-Jeff
