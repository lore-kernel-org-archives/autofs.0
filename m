From: "Newman, Edward \(GTI\)" <edward_newman@ml.com>
Subject: AutoFS / SASL support
Date: Fri, 2 Nov 2007 14:25:01 -0400
Message-ID: <E5F741E838FC2043A0B843E48181813806AB742B@MLNYC730MB.amrs.win.ml.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Class: urn:content-classes:message
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

Just wanted to confirm whether SASL support is currently broken in 5.0.2
with all outstanding patches applied. 

Debug of code suggests following issues:

- Makefile has invalid test for HAVE_SASL in configure.in and thus
doesn't include correct libraries (-z instead of -n in test step)
- patched code in connect_to_server in lookup_ldap.c does not call
auth_init prior to testing for auth_required and thus fails SASL in all
cases
- order of code sequence currently fails to enable SASL correctly.

I am also trying to use an existing keytab for Kerberos GSSAPI
authentication to directory and currently sasl_kinit code appears to
fail. Haven't worked out exact cause yet but appears to not passing a
keytab name and environment is not picking up location from krb5.conf.

Please confirm above and whether this is being actively worked on at
this time.

Thanks

Edward
--------------------------------------------------------

This message w/attachments (message) may be privileged, confidential or proprietary, and if you are not an intended recipient, please notify the sender, do not use or share it and delete it. Unless specifically indicated, this message is not an offer to sell or a solicitation of any investment products or other financial product or service, an official confirmation of any transaction, or an official statement of Merrill Lynch. Subject to applicable law, Merrill Lynch may monitor, review and retain e-communications (EC) traveling through its networks/systems. The laws of the country of each sender/recipient may impact the handling of EC, and EC may be archived, supervised and produced in countries other than the country in which you are located. This message cannot be guaranteed to be secur
 e or error-free. This message is subject to terms available at the following link: http://www.ml.com/e-communications_terms/. By messaging with Merrill Lynch you consent to the foregoing.
--------------------------------------------------------
