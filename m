From: Krishnakumar B <kitty@dre.vanderbilt.edu>
Subject: Re: Autofs + LDAP + STARTTLS
Date: Mon, 31 Jan 2005 14:52:04 -0600
Message-ID: <874qgxe2yz.fsf@tango.dre.vanderbilt.edu>
References: <87hdkxe6jp.fsf@tango.dre.vanderbilt.edu>
	<41FE96B2.4070602@int-evry.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41FE96B2.4070602@int-evry.fr> (jehan procaccia's message of
	"Mon, 31 Jan 2005 21:36:02 +0100")
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "jehan.procaccia" <jehan.procaccia@int-evry.fr>
Cc: autofs@linux.kernel.org

On Monday, 31 January 2005, jehan.procaccia wrote:
> Krishnakumar B wrote:
>

[...]

> I didn't tried it (autofs with TLS) but I know that autofs reads ldap 
> configuration in /etc/openldap/ldap.conf on redhat config! not 
> /etc/ldap.conf , did you put a TLS_CACERT directive in 
> /etc/openldap/ldap.conf ?

Here's what I have in /etc/openldap/ldap.conf:

BASE dc=dre,dc=vanderbilt,dc=edu
HOST ldap.dre.vanderbilt.edu
TLS_CERT        /usr/share/ssl/certs/valhalla.crt
TLS_KEY         /usr/share/ssl/certs/valhalla.pem
TLS_CACERT      /usr/share/ssl/certs/DRE-CA-CERT
TLS_REQCERT     demand

And it works:

[root@valhalla root]# ldapsearch -LLL -ZZ -x -s base -b "" "(objectClass=*)" +
dn:
structuralObjectClass: OpenLDAProotDSE
namingContexts: dc=dre,dc=vanderbilt,dc=edu
supportedControl: 2.16.840.1.113730.3.4.18
supportedControl: 2.16.840.1.113730.3.4.2
supportedControl: 1.3.6.1.4.1.4203.1.10.1
supportedControl: 1.2.840.113556.1.4.1413
supportedControl: 1.2.840.113556.1.4.1339
supportedControl: 1.2.840.113556.1.4.319
supportedControl: 1.2.826.0.1.334810.2.3
supportedExtension: 1.3.6.1.4.1.1466.20037
supportedExtension: 1.3.6.1.4.1.4203.1.11.1
supportedExtension: 1.3.6.1.4.1.4203.1.11.3
supportedFeatures: 1.3.6.1.4.1.4203.1.5.1
supportedFeatures: 1.3.6.1.4.1.4203.1.5.2
supportedFeatures: 1.3.6.1.4.1.4203.1.5.3
supportedFeatures: 1.3.6.1.4.1.4203.1.5.4
supportedFeatures: 1.3.6.1.4.1.4203.1.5.5
supportedLDAPVersion: 3
supportedSASLMechanisms: PLAIN
supportedSASLMechanisms: LOGIN
supportedSASLMechanisms: GSSAPI
supportedSASLMechanisms: DIGEST-MD5
supportedSASLMechanisms: CRAM-MD5
subschemaSubentry: cn=Subschema

[root@valhalla root]#

-kitty.

-- 
Krishnakumar B <kitty at dre dot vanderbilt dot edu>
Institute for Software Integrated Systems, Dept. of EECS, Vanderbilt University
