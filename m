From: Robert Giles <rgiles@arlut.utexas.edu>
Subject: LDAP-based auto.master and --ghost option
Date: Fri, 29 Sep 2006 14:20:48 -0500
Message-ID: <Pine.CYG.4.64.0609291328430.468@ninja>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1182772375-1159556099=:468"
Return-path: <autofs-bounces@linux.kernel.org>
Content-ID: <Pine.CYG.4.64.0609291400180.468@ninja>
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

---559023410-1182772375-1159556099=:468
Content-Type: TEXT/PLAIN; CHARSET=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.CYG.4.64.0609291355461.468@ninja>

Hi folks - I have our auto.master configuration stored in LDAP as an=20
"nisMap", with "nisObjects" beneath it describing our various mount=20
points.  I'm trying to get the --ghost option to work from this LDAP-based=
=20
auto.master, but am not having any luck (the mounts DO work without the=20
--ghost option).

This is on a SuSE 10.1-based system, running autofs 4.1.4 and the 2.6.18=20
vanilla kernel (with SuSE 10.1 /proc/config.gz)...


For example, one of my working nisObjects under the auto.master:

          cn=3D/proj
nisMapEntry=3Dldap:nisMapName=3Dauto.proj,ou=3Dautofs,dc=3Dfake


=2E..would report this line from "Configured Mount Points" after starting=
=20
autofs (and also as an active mount point):

/usr/sbin/automount /proj ldap "nisMapName=3Dauto.proj,ou=3Dautofs,dc=3Dfak=
e"

=2E..

When I add the --ghost option to my nisMapEntry...

          cn=3D/proj
nisMapEntry=3Dldap:nisMapName=3Dauto.proj,ou=3Dautofs,dc=3Dfake --ghost


=2E..I get this back when starting autofs (and the mount point is=20
missing from the "active" mounts list):

/usr/sbin/automount /proj ldap:nisMapName=3Dauto.proj,ou=3Dautofs,dc=3Dfake=
 "--ghost"

The quotes appear to shift over to the "--ghost" option, and the=20
ldap:nisMapName is no longer parsed correctly (ie: split on the ":"=20
separator).

Seems like I'm using invalid syntax when specifying additional automount=20
options via the nisMapEntry field...  can anyone shed some light on what=20
I'm doing wrong here?

(I've also tried adding the "--ghost" before the "ldap:nisMapName..."=20
string, without success)

Thanks for any tips out there.

-----------------------------------------------------------
Robert Giles                     Group System Administrator
SPD/ARL:UT              (512) 835-3077 =B7 Fax (512) 490-4244
---559023410-1182772375-1159556099=:468
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

---559023410-1182772375-1159556099=:468--

