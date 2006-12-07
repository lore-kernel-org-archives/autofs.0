From: Fabio Olive Leite <fleite@redhat.com>
Subject: [patch] Underscore in hostnames
Date: Thu, 7 Dec 2006 21:22:12 -0200
Message-ID: <20061207232212.GA1994@sleipnir.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Hi all,

Even though underscores are not really valid in hostnames, many people
use them and they seem to be tolerated in many places. So I propose
the one-liner below to see what you think.

This one-liner adds underscore as a valid hostname character for NFS
mounts.

Signed-off-by: Fabio Olive Leite <fleite@redhat.com>
---

 parse_sun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index 6f10a4f..c849ff3 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -691,7 +691,7 @@ static int validate_location(char *loc)
        if (check_colon(ptr)) {
                while (*ptr && *ptr !=3D ':') {
                        if (!(isalnum(*ptr) ||
-                           *ptr =3D=3D '-' || *ptr =3D=3D '.' ||
+                           *ptr =3D=3D '-' || *ptr =3D=3D '.' || *ptr =3D=
=3D '_' ||
                            *ptr =3D=3D ',' || *ptr =3D=3D '(' || *ptr =3D=
=3D ')'))
                                return 0;
                        ptr++;

Kind regards,
F=E1bio
-- =

ex sed lex awk yacc, e pluribus unix, amem
