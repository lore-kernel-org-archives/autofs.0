From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: submount vs automount
Date: Mon, 28 Jun 2004 11:44:02 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40E03CC2.7020601@sun.com>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
 <Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
 <Pine.LNX.4.58.0406250909330.7918@simba.math.ucla.edu>
 <40DC6F84.5020701@sun.com>
 <Pine.LNX.4.60.0406280220160.13910@fogarty.jakma.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <Pine.LNX.4.60.0406280220160.13910@fogarty.jakma.org>
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
> On Fri, 25 Jun 2004, Mike Waychison wrote:
>
>> This is just semantically racy.  If someone ssh'es into you laptop and
>> accesses the mount before you do, you can't access it.  A better
>> approach IMHO is to mount with the UID of the user on :0, unmounting
>> it on logout if possible. Thoughts?
>
>
> Why should the user on :0 be special?

Cause this is the kind of policy I'd like to see :)

>
> This is a question of policy. And there are really two questions here.
> The important one:
>
> - Does the user have the credentials to be allowed to mount this device?
>
> we already have things like pam_console and logindevperm to assist with
> answering this question, if an admin so desires.
>

Yup. However, this doesn't connect nicely with mount(8).  mount(8) only
mounts as a user according to /etc/fstab rules, not by block device
owner :\   Maybe this should be fixed up somehow.


> The lesser question of, applying mainly to removable media with certain
> non-POSIX fs's:
>
> - what credentials should the mount apply to files?
>
> The answer to last one, given you have an answer to first question, is
> almost certainly "the credentials which triggered the mount".
>
> no?
>

Sure, but 'who is allowed to trigger the mount'?

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

iD8DBQFA4DzBdQs4kOxk3/MRAvROAJ49u+Fa7l2cPubk0SbL/r83Nohi1gCgieZs
SIBJRsZbX5Q+rGWZQFYD8A8=
=ufzo
-----END PGP SIGNATURE-----
