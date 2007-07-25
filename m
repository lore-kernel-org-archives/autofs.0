From: Nail El-Sourani <sourani@math.uni-muenster.de>
Subject: autofs5 duplicate entries
Date: Wed, 25 Jul 2007 14:53:52 +0200
Message-ID: <46A747E0.7070202@math.uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

hi everyone,

i seem to have a problem with autofs+ldap on duplicate entries. i
migrated from autofs4 settings over to autofs5 quite successfully and in
general everything seems to work fine. ill give u a working and
nonworking example.


auto.master contains:
/share  ldap:nisMapName=auto_packages,ou=ivv5,dc=de -nosuid

ldap queries on the path to automount give me:

ldapsearch -x -LLL cn=java

working:
objectClass: nisObject
objectClass: top
cn: Java
nisMapEntry: ...
nisMapName: auto_package...

like the above, the autofs5 mounts with no problem.

but this one, not working:
objectClass: nisObject
objectClass: top
cn: Java
cn: %Java
nisMapEntry: ...
nisMapName: auto_package...

gives in /var/log/messages a

Jul 25 14:22:45 SEMTEX automount[4872]: attempting to mount entry
/share/java
Jul 25 14:22:45 SEMTEX automount[4872]: lookup_one: lookup(ldap): key
Java has duplicate entries
Jul 25 14:22:45 SEMTEX automount[4872]: failed to mount /share/java

As I believe, there seems to be a Problem with cn:Java and cn:%Java
somehow. As I understand the % seems to be there to enable both
upper-and lowercase typing (java, Java) when entering the Path on the
commandline (cd /share/Java, /share/java). Anyhow. in autofs4 this didnt
seem to be a problem.

Any help would be appreciated.

*nail
