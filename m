From: Giovanni Romanenghi <giovanni.romanenghi@sorint.it>
Subject: Re: AutoFS problem
Date: Fri, 28 May 2004 09:42:08 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <6bdaf6fecc.6fecc6bdaf@sorint.it>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
Content-language: it
Content-Disposition: inline
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

My entries LDAP 
This is USER LDAP
dn: uid=giovanni, ou=People, o=test.it, dc=test,dc=it
vacationStartDate: 20030827220000Z
mailAutoReplyTextInternal;lang-en: descrizione interna
pwdMustChange: 2147483647
mail: giovanni.romanenghi@test.it
uid: giovanni
pwdCanChange: 2147483647
mailAutoReplyText;lang-it: descrizione del testo
mailAutoReplyTimeout: 0
objectClass: top
objectClass: person
objectClass: organizationalPerson
objectClass: inetorgperson
objectClass: inetUser
objectClass: inetSubscriber
objectClass: ipUser
objectClass: nsManagedPerson
objectClass: inetmailuser
objectClass: inetlocalmailrecipient
objectClass: userpresenceprofile
objectClass: shadowAccount
objectClass: account
objectClass: posixAccount
objectClass: sambaaccount
uidNumber: 10162
sn: romanenghi
mailUserStatus: active
gidNumber: 223
mailDeliveryOption: mailbox
primaryGroupID: 1021
userPassword:: e2NyeXB0fWlGNUdCSk1ZbmlSaEk=
nswmExtendedUserPrefs: meDraftFolder=Drafts
nswmExtendedUserPrefs: meSentFolder=Sent
nswmExtendedUserPrefs: meTrashFolder=Trash
nswmExtendedUserPrefs: meInitialized=true
nswmExtendedUserPrefs: meColorSet=3
mailAutoReplyMode: reply
lmPassword: 62CF8F22A6498F12AAD3B435B51404EE
mailHost: mail.test.it
rid: 21324
vacationEndDate: 20030828220000Z
cn: giovanni romanenghi
acctFlags: [U          ]
logofftime: 2147483647
pabURI: ldap://ldap.test.it:389/ou=giovanni,ou=people,o=test.it,dc=test
 ,dc=it,o=pab
mailAutoReplyText;lang-en: descrizione esterna
homeDirectory: /home/giovanni
givenName: giovanni
displayName: giovanni romanenghi
pwdLastSet: 1084871308
inetUserStatus: active
dataSource: SunOne Messaging Server 5.2
ntPassword: C64865C3C02BB87123092D866496D8A4
kickoffTime: 2147483647
loginShell: /bin/bash
logonTime: 2147483647


This is entries for autofs 

dn: ou=auto.master, o=test.it, dc=test,dc=it
ou: auto.master
objectClass: top
objectClass: automountMap
 
dn: cn=/u, ou=auto.master, o=test.it, dc=test,dc=it
objectClass: automount
objectClass: top
automountInformation: ldap ldap.test.it:ou=auto.u,o=test.it,dc=test,dc=it
cn: /u
 
dn: cn=/home, ou=auto.master, o=test.it, dc=test,dc=it
objectClass: automount
objectClass: top
automountInformation: ldap ldap.test.it:ou=auto.home,o=test.it,dc=test,dc=it
cn: /home
 
dn: cn=/prova, ou=auto.master, o=test.it, dc=test,dc=it
objectClass: automount
objectClass: top
automountInformation: ldap ldap.test.it:ou=auto.prova,o=test.it,dc=test,dc=it
cn: /prova
                                                                                
dn: ou=auto.home, o=test.it, dc=test,dc=it
ou: auto.home
objectClass: top
objectClass: automountMap
 
dn: cn=giovanni, ou=auto.home, o=test.it, dc=test,dc=it
objectClass: automount
objectClass: top
automountInformation: -fstype=nfs,hard,intr 192.168.1.162:/tmp/tmp/giovanni
cn: giovanni
 
dn: ou=auto.prova, o=test.it, dc=test,dc=it
ou: auto.prova
objectClass: top
objectClass: automountMap
 
dn: cn=giovanni, ou=auto.prova, o=test.it, dc=test,dc=it
objectClass: automount
objectClass: top
automountInformation: -fstype=autofs,hard,intr 192.168.1.162:/var/prova
cn: giovanni
                                                                                
dn: ou=auto.u, o=test.it, dc=test,dc=it
ou: auto.u
objectClass: top
objectClass: automountMap
 
dn: cn=giovanni, ou=auto.u, o=test.it, dc=test,dc=it
objectClass: automount
objectClass: top
automountInformation: -fstype=nfs,hard,intr 192.168.1.162:/tmp/u
cn: giovanni
