From: Jimmy Dorff <jdorff@phy.duke.edu>
Subject: nesting automount maps in ldap
Date: Fri, 17 Jun 2011 10:40:05 -0400
Message-ID: <4DFB6745.3040805@phy.duke.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hello,

I'm attempting to migrate an existing (and working) nis automount system 
to ldap. We have several layers of nested maps and I'm attempting to 
recreate that in LDAP.

# Automount master for "/foo"
dn: cn=/foo, ou=auto.master,dc=phy,dc=duke,dc=edu
objectClass: automount
cn: /foo
automountInformation: ldap ldapserver:ou=auto.phy,dc=phy,dc=duke,dc=edu

dn: ou=auto.phy, dc=phy,dc=duke,dc=edu
objectClass: top
objectClass: automountMap
ou: auto.phy

# mounting "/foo/web" works great!
dn: cn=web, ou=auto.phy, dc=phy,dc=duke,dc=edu
objectClass: automount
cn: web
automountInformation: -fstype=nfs nfsserver01:/srv/httpd

# here is my attempt at nesting another level
dn: cn=project, ou=auto.phy,dc=phy,dc=duke,dc=edu
objectClass: automount
cn: project
automountInformation: ldap ldapserver:ou=auto.project,dc=phy,dc=duke,dc=edu

# This fails. I get "automount: failed to mount /foo/project
dn: ou=auto.project, dc=phy,dc=duke,dc=edu
objectClass: top
objectClass: automountMap
ou: auto.project

# this never shows up (ghosting enabled)
dn: cn=linux, ou=auto.project, dc=phy,dc=duke,dc=edu
objectClass: automount
cn: linux
automountInformation: -fstype=nfs nfsserver02:/srv/linux

I can't see to find an example of nest ldap maps. I'm using 
autofs-5.0.5-31.el6 if that makes any difference.

Thanks!
Jimmy Dorff
