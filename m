From: Nail El-Sourani <sourani@math.uni-muenster.de>
Subject: program map | cifs | autofs4
Date: Wed, 06 Aug 2008 16:58:18 +0200
Message-ID: <4899BC0A.8020303@math.uni-muenster.de>
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

Hi Guys,

maybe some of u gurus can help. This is a mixed environment, suse10.2 
(so im stuck with autofs4), userinfo is stored in an ldap db.

current auto.master
# $Id: auto.master,v 1.1 2001/04/17 11:43:02 arvin Exp arvin $
# Sample auto.master file
# Format of this file:
# mountpoint map options
# Also see variable AUTOFS_OPTIONS in /etc/sysconfig/autofs
# For details of the format look at autofs(8).
/rz     ldap    nisMapName=auto_rz,ou=ivv5,dc=uni-muenster,dc=de
/share  ldap    nisMapName=auto_packages,ou=ivv5,dc=uni-muenster,dc=de 
-nosuid,hard,intr,rsize=8192,wsize=8192,tcp
/u      ldap    nisMapName=auto_home,ou=ivv5,dc=uni-muenster,dc=de 
-rw,hard,intr,nosuid,retry=2,rsize=8192,wsize=8192,tcp

everything is working fine like this, but homes in /u/$username are 
mounted via nfs. i want this to be mounted via cifs.

so i changed the last line of auto.master to:
/u /etc/auto.cifs

compiled a pam_storepw module to save a credentials-file to 
/var/run/pw/$user

then wrote a auto.cifs file like this:
____________________________________________________________________________
#!/bin/bash
key=$1
username=$key
userpass=from credentialsfile
dom=MATH
mountoptions=-fstype=cifs,file_mode=0644,dir_mode=0755,username=$username,password=$password,dom=$dom 

echo "$username $mountoptions /$username ://sambaserver/$username
_____________________________________________________________________________

the sambaserver exports homes via /$username

all i want is this to mount the home of user "test" to /u/test from 
://sambaserver/test as soon as test logs in.

this doesnt seem to work. i tried all possible combinations of the 
echo-line in above auto.cifs, all i get is some weird mounts like home 
getting mountet to /u/test/test oder /u/test/bin/test/test - totally 
weird. what's the correct syntax? i thought the above as stated by manpage.

i tried all this with a direct map as in:
test 
-fstype=cifs,file_mode=0644,dir_mode=0755,username=test,password=$password,dom=MATH 
://sambaserver/tesst

and it worked. where's the difference? putting the same syntax into a 
program map gives me a program lookup error on syslog.

this seems outta reach for me, any hints?

sincerely,
*nail
