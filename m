From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: submount vs automount
Date: Mon, 28 Jun 2004 12:25:55 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E04693.1010507@sun.com>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
 <Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
 <Pine.LNX.4.58.0406250909330.7918@simba.math.ucla.edu>
 <40DC6F84.5020701@sun.com>
 <Pine.LNX.4.60.0406280220160.13910@fogarty.jakma.org>
 <40E03CC2.7020601@sun.com>
 <Pine.LNX.4.60.0406281651490.13910@fogarty.jakma.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.60.0406281651490.13910@fogarty.jakma.org>
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
To: Paul Jakma <paul@clubi.ie>
Cc: autofs@linux.kernel.org, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Jakma wrote:
> On Mon, 28 Jun 2004, Mike Waychison wrote:
>
>>> Why should the user on :0 be special?
>>
>>
>> Cause this is the kind of policy I'd like to see :)
>
>
> It doesnt make sense though. Eg, I remember in College the SPARCStation
> labs (for some reason) each only had one workstation with a floppy
> device. 9/10 the user using the floppy was not on :0.0.
>
> I can imagine something similar today with Zip/Jazz/DVR-RW+packet
> UDF/$CHIC_REMOVABLE_MEDIA_DE_JOUR.
>

This policy has to be determined on a machine-by-machine basis.  I think
we can agree to that.

I just chose to examine the :0 policy because doing so allows us to
explore the implications of such an implementation.

For example, after considering the 'owner' bit, I realize now that
autofs would:

- - still have to parse for such an option as it runs as root and would
likely have to setuid to the user in question (so umount(8) still works).

- - which implies that automount would need to know who triggered the
mount, which isn't possible without a protocol jump.

Going back to earlier discussion, when Jim Carter discussed the
'first-acccess / mount-owner' scenario, I think there has to be a
compromise between security and functionality.  Prescribing policies
such as ':0' helps enforce some level of security access to the medium,
while the 'no-policy policy' is just as bad as setups described above
where your fd device file is o+rw.



- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4EaTdQs4kOxk3/MRAmLJAJ9mrD33QJBrH63X6TAeWfAki9PMjACdEnZD
0gLuGLf4npMYOUPC8j+OzIA=
=vveZ
-----END PGP SIGNATURE-----
