From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Exporting UID to userspace?
Date: Thu, 10 Jun 2004 12:59:45 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40C89381.2060002@sun.com>
References: <E1B7C89B8DCB084C809A22D7FEB90B3841AD@frodo.avalon.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <E1B7C89B8DCB084C809A22D7FEB90B3841AD@frodo.avalon.ru>
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
To: "Dimitry V. Ketov" <Dimitry.Ketov@avalon.ru>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dimitry V. Ketov wrote:
>>-----Original Message-----
>>From: Mike Waychison [mailto:Michael.Waychison@Sun.COM]
>
>
>>>>>>If the idea is to have a 'Network Neighborhood' inside
>>>>
>>>>each user's
>>>>
>>>>>>>homedir, you could write an executable map for /home
>>>>>>
>>>>>>It will hide /home directory content.
>>>>>
>>>>>No. It wouldn't presuming that your /home subdirs are automounted.
>>>
>>>
>>>What if my home dirs is not automounted from network server? I just
>>>simply want it for local users.
>>>
>>
>>Well, in that case you'd have to use direct mounts (which
>>don't work as expected in automount4).  Alternatively, you can always
>>
>>mkdir /export
>>mv /home /export
>>
>>And start automounting your home directories from localhost.   Don't
>>worry, automount will detect it being local and will not use
>>NFS, rather it will --bind mount the filesystems, so there is
>>no performance hit.
>
> ;) Yes, I thought about it, but it's rather ugly solution (as for me),
> then it's seems better to spawn new automount process for
> ~user/NetworkNeigboorhood at logon time and terminate it at logoff.
> This allows us to avoid UID/GID exporting problem at all, since it will
> be obvious which user's credetials to use for mount.
>
> Any objections?

Sure, you can have the mount installed at login time using pam or
similar. However, note that you'll have to verify that it works for all
login methods (desktop / telnet / ssh / ...).  Also, I don't know off
hand if you can properly detect whether someone has logged out other
than by polling utmp with a daemon.

I still think having all the homedir's automounted is a simpler
approach, even if they reside locally, if only because:

- - it will make adding users with homedir's in other places easier in the
long run.
- - all the expiry stuff is handled for you already.

It's up to you how you set it up in the end.

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAyJOBdQs4kOxk3/MRAsdyAJ9Dte6QQbTZGczArGHCmZ6lGTfgpQCfSAaL
6gzr/hqZtIzI5e8u/0KYYRk=
=dEOW
-----END PGP SIGNATURE-----
