From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [RFC] Towards a Modern Autofs
Date: Fri, 09 Jan 2004 15:28:32 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FFF0EF0.90807@sun.com>
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
 <3FFD9498.6030905@zytor.com> <3FFDEAE6.4030503@metaparadigm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86286609831736216=="
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <3FFDEAE6.4030503@metaparadigm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Clark <michael@metaparadigm.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============86286609831736216==
Content-type: multipart/signed;
 boundary=------------enigCB976E857DF6C1047F7DF8A1;
 protocol="application/pgp-signature"; micalg=pgp-sha1

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCB976E857DF6C1047F7DF8A1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael Clark wrote:

> On 01/09/04 01:34, H. Peter Anvin wrote:
>
>> In many ways this returns to the simplicity of the autofs v3 design 
>> where the atomicity constraints where guaranteed by the VFS itself, 
>> *as long as* mount traps can be atomically destroyed with umounting 
>> the underlying filesystem.
>
>
> Do we need to revive Tigran's forced unmount patch 'badfs' ala FreeBSD's
> deadfs? Although it doesn't guarantee atomic unmount, it could help
> a lot with the tendancy to get stuck autofs mounts.
>
>   http://tinyurl.com/2hto8
>
> I've been long waiting for this functionality in mainline.


This is an interesting approach to killing off a mountpoint.  However, 
the problem in question is not the destruction of the mountpoints, but 
rather being able to 
check_activity_of_a_hierarchy_of_mountpoints/unmount_them_together 
atomically.  This cannot be done cleanly in userspace even when given an 
interface to do the check, someone can race in before userspace 
initiates the unmounts.  The alternative is to have userspace detach the 
hierarchy of mountpoints using the '-l' option to umount(8), but then we 
may still unneccesarily unmount the filesystem will someone is in it. 

I think that both HPA and I agree that this capability is needed in 
order to support lazy mounting of multimounts properly.    The issue 
that remains is *how* to do it. 

>
> I wonder if binding badfs over the mountpoint at the beginning of the
> potentially lengthy unmount process would improve the atomicity
> to userspace. ie although the unmount would proceed in the background,
> badfs would have been mounted at that point at the start of the process
> - mounts are atomic no?
>
> ~mc
>
The time required to unmount something is constant if we detach the 
mountpoint using a lazy umount.

-- 
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


--------------enigCB976E857DF6C1047F7DF8A1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//w7zdQs4kOxk3/MRAsGTAJwMR0IEgCMs5VxRFZ71cRI8TxW0AgCdEBc2
CIDvcCuT5lo3qBkRK1zeR/I=
=TCaT
-----END PGP SIGNATURE-----

--------------enigCB976E857DF6C1047F7DF8A1--


--===============86286609831736216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============86286609831736216==--

