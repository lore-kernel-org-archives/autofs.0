From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: backfstype patch.
Date: Wed, 30 Jun 2004 10:28:48 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E2CE20.1050103@sun.com>
References: <40E1CCC3.1010809@deragon.biz> <40E2C0BA.3070605@sun.com>
 <16610.50525.858094.848839@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <16610.50525.858094.848839@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, dhowells@redhat.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Resending as I forgot to CC David :)

Jeff Moyer wrote:
> ==> Regarding Re: [autofs] backfstype patch.; Mike Waychison
<Michael.Waychison@Sun.COM> adds:
>
> Michael.Waychison> -----BEGIN PGP SIGNED MESSAGE-----
> Hash> SHA1
>
> Michael.Waychison> Hans Deragon wrote:
>
>>>Greetings.
>>>
>>>
>>>Attached, my patch for supporting backfstype.  If the OS is Linux and
>>>cachefs is detected, this fs is ignored and no attempt is made to mount
>>>a cachefs kernel module (none exist).  This way we avoid useless error
>>>messages in syslog.
>>>
>>>If mounting the fstype fails or is cachefs, backfstype is then tried.
>>>
>>>It works fine under RHL 9.  Only one file was changed: parse_sun.c.  The
>>>changes were made from the 4.1.3 branch.  Changes are very localized and
>>>I believe they are safe (though code inspection is always desired).
>>>
>>>Please confirm if my patch has been accepted.
>>>
>
>
> Michael.Waychison> Why do this in the parser when it can easily be done in
> Michael.Waychison> a mount module?
>
> Care to expound a bit?  I'm not sure what people use backfstype for,
but if
> it is generic, then you wouldn't want to handle every case in every mount
> module.  But I think I'm missing your point.
>
> It makes some sense to me to handle this above the mount module, simply
> because you could call into two different modules.
>
> So, care to set me straight?  ;)
>
> -Jeff

I'm CC'ing David as he may have a better view of what the cachefs status is.

Backfstype is a fstype=cachefs specific mount option.  Specifically:

 - add cachefs to the not_generic array in daemon/mount.c
 - create a new mount module, modules/mount_cachefs.c.  This module
would check for cachefs support available and use it if available.
Otherwise it would rewrite the fstype with the backfstype mount option
and call do_mount again.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4s4fdQs4kOxk3/MRAvw7AJ9THSEKPZ2FFP73r60fb3QASiJ9RgCggOE0
Csu1J3seKze4LGzuKfvbgh8=
=o36j
-----END PGP SIGNATURE-----
