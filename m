From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: submount vs automount
Date: Mon, 28 Jun 2004 11:46:57 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E03D71.4060302@sun.com>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
 <Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
 <Pine.LNX.4.58.0406250909330.7918@simba.math.ucla.edu>
 <40DC6F84.5020701@sun.com>
 <Pine.LNX.4.60.0406280220160.13910@fogarty.jakma.org>
 <40E03CC2.7020601@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <40E03CC2.7020601@sun.com>
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
Cc: autofs@linux.kernel.org, Paul Jakma <paul@clubi.ie>, raven@themaw.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mike Waychison wrote:
> Paul Jakma wrote:
>>>This is a question of policy. And there are really two questions here.
>>>The important one:
>>>
>>>- Does the user have the credentials to be allowed to mount this device?
>>>
>>>we already have things like pam_console and logindevperm to assist with
>>>answering this question, if an admin so desires.
>>>
>
>
> Yup. However, this doesn't connect nicely with mount(8).  mount(8) only
> mounts as a user according to /etc/fstab rules, not by block device
> owner :\   Maybe this should be fixed up somehow.
>

Oops.  My bad, should have RTFMed mount(8) -- 'owner'.

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

iD8DBQFA4D1xdQs4kOxk3/MRAtpVAJ95U9aHo2wm4vNLI25gf10WErrZYACfeIpB
DneDKsyOskWQiVsDlt3ZFzg=
=E3us
-----END PGP SIGNATURE-----
