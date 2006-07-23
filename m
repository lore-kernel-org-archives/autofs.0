From: Brad Arrington <bradla@inbox.com>
Subject: parse_sun.c error
Date: Sat, 22 Jul 2006 21:45:04 -0800
Message-ID: <BEF3A37C1CC.00000301bradla@inbox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------Boundary-00=_ORONX62V1G2C8CAKAJMT"
Return-path: <autofs-bounces@linux.kernel.org>
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

This is a multi-part message in MIME format.
--------------Boundary-00=_ORONX62V1G2C8CAKAJMT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

To whom it may concern,

I have noticed that the following code in parse_sun.c has a duplicate =
memory allocation.

The error is present in both autofs-4.1.4 and autofs-5.0.1-rc1.

I have also attached a diff file.

4.1.4

parse_sun.c

    650         what =3D alloca(loclen + 1);
    651         memcpy(what, loc, loclen);
    652         what=5Bloclen=5D =3D '=5C0';
    653=20
    654         if (=21strcmp(fstype, =22autofs=22) && strchr(loc, ':') =
=3D=3D NULL) =7B
    655                 char mtype=5B7=5D;
    656                 int mtype_len;
    657=20
    658                 if (loc=5B0=5D =3D=3D '/') =7B
    659                         mtype_len =3D 5;
    660                         if (loc=5B1=5D =3D=3D '/')
    661                                 strcpy(mtype, =22ldap:=22);
    662                         else
    663                                 strcpy(mtype, =22file:=22);
    664                 =7D else =7B
    665                         mtype_len =3D 3;
    666                         strcpy(mtype, =22yp:=22);
    667                 =7D
    668=20
    669                 what =3D alloca(loclen + mtype_len + 1);
    670                 memcpy(what, mtype, mtype_len);
    671                 memcpy(what + mtype_len, loc, loclen);
    672                 what=5Bloclen + mtype_len=5D =3D '=5C0';
    673         =7D else =7B
    674                 what =3D alloca(loclen + 1);
    675                 memcpy(what, loc, loclen);
    676                 what=5Bloclen=5D =3D '=5C0';
    677         =7D


5.0.1-rc1

    647         what =3D alloca(loclen + 1);
    648         memcpy(what, loc, loclen);
    649         what=5Bloclen=5D =3D '=5C0';
    650 /*
    651         if (=21strcmp(fstype, =22autofs=22) && strchr(loc, ':') =
=3D=3D NULL) =7B
    652                 char mtype=5B7=5D;
    653                 int mtype_len;
    654=20
    655                 if (loc=5B0=5D =3D=3D '/') =7B
    656                         mtype_len =3D 5;
    657                         if (loc=5B1=5D =3D=3D '/')
    658                                 strcpy(mtype, =22ldap:=22);
    659                         else
    660                                 strcpy(mtype, =22file:=22);
    661                 =7D else =7B
    662                         mtype_len =3D 3;
    663                         strcpy(mtype, =22yp:=22);
    664                 =7D
    665=20
    666                 what =3D alloca(loclen + mtype_len + 1);
    667                 memcpy(what, mtype, mtype_len);
    668                 memcpy(what + mtype_len, loc, loclen);
    669                 what=5Bloclen + mtype_len=5D =3D '=5C0';
    670         =7D else =7B
    671 */
    672                 what =3D alloca(loclen + 1);
    673                 memcpy(what, loc, loclen);
    674                 what=5Bloclen=5D =3D '=5C0';
    675 /*      =7D */




--------------Boundary-00=_ORONX62V1G2C8CAKAJMT
Content-Type: text/x-patch
Content-Disposition: attachment; filename=autofs-4.1.4-mem_error.patch
Content-Transfer-Encoding: quoted-printable

diff -ur autofs-4.1.4a/modules/parse_sun.c autofs-4.1.4b/modules/parse_sun.c
--- autofs-4.1.4a/modules/parse_sun.c=092005-04-05 05:42:42.000000000 -0700
+++ autofs-4.1.4b/modules/parse_sun.c=092006-07-22 11:55:39.000000000 -0700
=40=40 -647,10 +647,6 =40=40
 =09mountpoint =3D alloca(namelen + 1);
 =09sprintf(mountpoint, =22%.*s=22, namelen, name);
=20
-=09what =3D alloca(loclen + 1);
-=09memcpy(what, loc, loclen);
-=09what=5Bloclen=5D =3D '=5C0';
-
 =09if (=21strcmp(fstype, =22autofs=22) && strchr(loc, ':') =3D=3D NULL) =7B
 =09=09char mtype=5B7=5D;
 =09=09int mtype_len;

--------------Boundary-00=_ORONX62V1G2C8CAKAJMT
Content-Type: text/x-patch
Content-Disposition: attachment; filename=autofs-5.0.1-mem_error.patch
Content-Transfer-Encoding: quoted-printable

diff -ur autofs-5.0.1a/modules/parse_sun.c autofs-5.0.1b/modules/parse_sun.c
--- autofs-5.0.1a/modules/parse_sun.c=092006-07-13 01:11:39.000000000 -0700
+++ autofs-5.0.1b/modules/parse_sun.c=092006-07-22 13:37:40.000000000 -0700
=40=40 -669,9 +669,6 =40=40
 =09=09what=5Bloclen + mtype_len=5D =3D '=5C0';
 =09=7D else =7B
 */
-=09=09what =3D alloca(loclen + 1);
-=09=09memcpy(what, loc, loclen);
-=09=09what=5Bloclen=5D =3D '=5C0';
 /*=09=7D */
=20
 =09debug(ap->logopt,

--------------Boundary-00=_ORONX62V1G2C8CAKAJMT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------Boundary-00=_ORONX62V1G2C8CAKAJMT--

