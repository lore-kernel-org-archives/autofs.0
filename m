From: "Wolfe, Allan" <Allan.Wolfe@anadarko.com>
Subject: Re: autofs5 duplicate entries
Date: Tue, 14 Aug 2007 17:44:06 -0500
Message-ID: <C9AD2899A176C0499022697035E7625A19CCFE@houmbx5.anadarko.com>
References: <46A747E0.7070202@math.uni-muenster.de>
	<C9AD2899A176C0499022697035E7625A19CC01@houmbx5.anadarko.com>
	<1185529315.3203.61.camel@raven.themaw.net>
	<46A9C4BB.6090208@math.uni-muenster.de>
	<1185549408.3203.64.camel@raven.themaw.net>
	<C9AD2899A176C0499022697035E7625A19CC2B@houmbx5.anadarko.com>
	<1187082727.4963.13.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1187082727.4963.13.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Good question.

I spent some time testing today.  They only test box I could quickly
test on was a Solaris 8 with patch 108993-36 applied that affects
autofs, NSS, PAM, ldapclient and associated user utilities (this patch
is quite old --> current is 108993-67).

The results were quite surprising as I distinctly remember having to
insert those delimited cn entries for the benefit of Solaris back 3
years ago when we integrated LDAP into our enterprise.  Bottom line, I
see that a delimited entry is seemingly no longer needed.  No matter
what the test case that was run, the cn as described in the dn prevailed
by default to appear as the stub.  Oddly, when accessing a mount
directly pathed as an alternate cn, it would mount and appear in that
form.  Here are notes from my testing below:


Test Process:  
  1.  Update test automount map entry in the LDAP directory for case.
  2.  Check for the order received using ldapsearch to insure
replication is complete. (I used Linux here since it is easier to use).
  3.  Reboot Solaris test client to insure fresh start of
autofs/automountd
  4.  List the stubs created by automounter in Solaris.


LDAP Directory Source: Sun/iPlanet/Netscape 5.2


solaris8test > uname -a
SunOS solaris8test 5.8 Generic_117350-05 sun4u sparc SUNW,Sun-Blade-1000

solaris8test > cat /etc/auto_master
/home         auto_home
/test         auto_test




Case 1:  Have non-delimited entry first in cn list followed by variant

Linuxtest > ldapsearch -x -LLL -b
nismapname=auto_test,ou=automaps,dc=example,dc=com objectclass=nisobject
dn: cn=Images,nismapname=auto_test,ou=automaps,dc=example,dc=com
objectClass: top
objectClass: nisobject
nisMapEntry: $OPTN nfssrv1:/vol/vol1/Images
nisMapName: auto_test
cn: Images
cn: %Ima%Ges
cn: %Images



solaris8test > ls /test
Images

solaris8test > ls /test/Images
  [file listing]

solaris8test > ls /test/images
  [file listing]

solaris8test > ls /test/ImaGes
  [file listing]

solaris8test > ls /test
ImaGes  Images  images



Case 2:  Have delimited variant entry first in cn list

Linuxtest > ldapsearch -x -LLL -b
nismapname=auto_test,ou=automaps,dc=example,dc=com objectclass=nisobject
dn: cn=Images,nismapname=auto_test,ou=automaps,dc=example,dc=com
objectClass: top
objectClass: nisobject
nisMapEntry: $OPTN nfssrv1:/vol/vol1/Images
nisMapName: auto_test
cn: %Ima%Ges
cn: %Images
cn: Images


solaris8test > ls /test
Images



Case 3:  Shuffle cn list with ImaGes on bottom (eliminate last read is
what is used)

Linuxtest > ldapsearch -x -LLL -b
nismapname=auto_test,ou=automaps,dc=example,dc=com objectclass=nisobject
dn: cn=Images,nismapname=auto_test,ou=automaps,dc=example,dc=com
objectClass: top
objectClass: nisobject
nisMapEntry: $OPTN nfssrv1:/vol/vol1/Images
nisMapName: auto_test
cn: Images
cn: %Images
cn: %Ima%Ges


solaris8test > ls /test
Images


Case 4:  Create delimited with only variant.

dn: cn=Images,nismapname=auto_test,ou=automaps,dc=example,dc=com
objectClass: top
objectClass: nisobject
nisMapEntry: $OPTN nfssrv1:/vol/vol1/Images
nisMapName: auto_test
cn: Images
cn: %Ima%Ges


solaris8test > ls /test
Images



Case 5:  Create dn with small case and add cn case sensitive.

dn: cn=images,nismapname=auto_test,ou=automaps,dc=example,dc=com
changetype: add
objectClass: top
objectClass: nisobject
nisMapEntry: $OPTN nfssrv1:/vol/vol1/Images
nisMapName: auto_test
cn: Images
cn: %Ima%Ges
cn: images


Received error (logically so) on re-entry:
deleting entry
"cn=Images,nismapname=auto_test,ou=automaps,dc=example,dc=com"

adding new entry
"cn=images,nismapname=auto_test,ou=automaps,dc=example,dc=com"
ldap_add: Type or value exists

ldif_record() = 20 



Case 6:  "Standard entry" -- no delimited cn

dn: cn=Images,nismapname=auto_test,ou=automaps,dc=example,dc=com
objectClass: top
objectClass: nisobject
nisMapEntry: $OPTN nfssrv1:/vol/vol1/Images
nisMapName: auto_test
cn: Images

solaris8test > ls /test
Images




-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Tuesday, August 14, 2007 4:12 AM
To: Wolfe, Allan
Cc: autofs@linux.kernel.org; support@math.uni-muenster.de
Subject: Re: [autofs] autofs5 duplicate entries

On Fri, 2007-07-27 at 18:21 -0500, Wolfe, Allan wrote:

Back to this again.

> On Solaris, only the case defined definition appears as the mount.  I 
> guess they have programmed around receiving multiple values for an 
> attribute and adopts the one if the % sign is used in one of the
values.
> Over RHEL3/autofs 4.1.x, there is a mount per "cn" received.  One with

> case sensitivity, one with the delimiters included.  Not elegant, but 
> the case sensitive path is preserved between platforms for the benefit

> of the common applications running cross-platform.  Both mounted paths

> are accessible as mounted.
> 

So is it accurate to say that, in this case, the:

cn: Java

provides the case insensitive match for key java and:

cn: %Java

defines case sensitivity constraints for autofs to use when matching the
entry?

Is it possible then to match Java and JaVa by adding an additional cn
of:

cn: %Ja%Va

to the above entry?

Is it possible then, in this scenario, to have distinct LDAP entries for
keys Java and JaVa?

Ian


-----------------------------------------

Anadarko Confidentiality Notice:  
This electronic transmission and any attached documents or other
writings are intended only for the person or entity to which it is
addressed and may contain information that is privileged,
confidential or otherwise protected from disclosure.  If you have
received this communication in error, please immediately notify
sender by return e-mail and destroy the communication. Any
disclosure, copying, distribution or the taking of any action
concerning the contents of this communication or any attachments by
anyone other than the named recipient is strictly prohibited.
