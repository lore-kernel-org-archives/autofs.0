From: Heinrich Rebehn <rebehn@ant.uni-bremen.de>
Subject: Re: autofs-4.0.0 last chance
Date: Wed, 27 Aug 2003 12:25:41 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F4C8725.8030209@ant.uni-bremen.de>
References: <Pine.LNX.4.44.0308262051110.1831-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308262051110.1831-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

Ian Kent wrote:
> I intend to release autofs-4.0.0.
> 
> If anyone has any bug reports or patches for autofs-4.0.0 please forward 
> them to me by this Friday 08/29. Anything after this will have to go into 
> sebsequent point releases.
> 
> Cheers all
> Ian
> 
Since mailman rejected my post, i post it again:

Hi,

i am using autofs 4.0 with maps served via LDAP.
I get strange errors when i try to access a subdirectory that is not in the map:

############################################
root@verden [~] # ls /ant/xxx
ls: /ant/xxx: No such file or directory
############################################

syslog output:

#################################################################################
Aug 26 15:53:45 verden automount[11430]: >> mount: special device /dev/xxx does
not exist
Aug 26 15:53:45 verden automount[11430]: mount(generic): failed to mount
/dev/xxx (type auto) on /ant/xxx/
#################################################################################

Autofs tries to mount /dev/xxx, if xxx does not exist in the map.

LDAP map:

###########################################################################
root@verden [~] # ldapsearch -x -b ou=auto.ant,o=ant,c=de
version: 2

#
# filter: (objectclass=*)
# requesting: ALL
#

# auto.ant, ANT, DE
dn: ou=auto.ant,o=ANT,c=DE
objectClass: top
objectClass: automountMap
ou: auto.ant

# www, auto.ant, ant, de
dn: cn=www,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: www
automountInformation: antsrv1:/export/data/www

# dsvbuch, auto.ant, ant, de
dn: cn=dsvbuch,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: dsvbuch
automountInformation: antsrv1:/export/homes/wiss/dsvbuch

# misc, auto.ant, ant, de
dn: cn=misc,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: misc
automountInformation: antsrv1:/export/homes/wiss/misc

# ntbuch, auto.ant, ant, de
dn: cn=ntbuch,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: ntbuch
automountInformation: antsrv1:/export/homes/wiss/ntbuch

# matbuch, auto.ant, ant, de
dn: cn=matbuch,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: matbuch
automountInformation: antsrv1:/export/homes/wiss/matbuch

# lib, auto.ant, ant, de
dn: cn=lib,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: lib
automountInformation: antsrv1:/export/data/lib

# cvs, auto.ant, ant, de
dn: cn=cvs,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: cvs
automountInformation: antsrv1:/export/data/cvs

# praktik, auto.ant, ant, de
dn: cn=praktik,ou=auto.ant,o=ant,c=de
objectClass: automount
cn: praktik
automountInformation: antsrv1:/export/data/praktikum

# search result
search: 2
result: 0 Success

# numResponses: 10
# numEntries: 9
#############################################################

automount cmd line:

/usr/sbin/automount /ant ldap o=ANT,c=DE

kernel 2.4.20 smp

openldap 2.0


Sorry for not reporting earlier, too busy ;-)
-- 

Heinrich Rebehn

University of Bremen
Physics / Electrical and Electronics Engineering
- Department of Telecommunications -

Phone : +49/421/218-4664
Fax   :            -3341
