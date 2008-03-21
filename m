From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: sudo and autofs
Date: Fri, 21 Mar 2008 08:47:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0803210832590.3306@simba.math.ucla.edu>
References: <1203828797.5413.355.camel@localhost> <47E391D4.9050107@inria.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1635810564-1894731571-1206114474=:3306"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <47E391D4.9050107@inria.fr>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1635810564-1894731571-1206114474=:3306
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by hera.kernel.org id m2O4vWkb031803

On Fri, 21 Mar 2008, Guillaume Rousse wrote:
> chris barry a =E9crit :
> > The question is, is there any way to make this work while preventing =
a
> > user from accessing another user's home? Some slick program type
> > automount map or something? anything...?
> ugly workaround: have users copy the file in the local /tmp directory
> first, before accessing it with sudo second.
>=20
> Otherwise, you may have a look at kerberized nfs for a much better
> security, but that's not something easy to install.

I have a brief writeup on NFSv4:=20
http://www.math.ucla.edu/~jimc/documents/nfsv4-0601.html

Unfortunately Kerberos is used to authenticate the client *host*, so=20
hostbased impersonation schemes (rogue laptops) no longer work, but it=20
still relies on the client to honestly report the alphabetic loginID and=20
group ID of the client user, and so is vulnerable to a generic root explo=
it=20
on the client. =20

I show an autofs map row that mounts NFSv4, at the end.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1=
555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP=
 key)
--1635810564-1894731571-1206114474=:3306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--1635810564-1894731571-1206114474=:3306--

