From: "Newman, Edward \(GTI\)" <edward_newman@ml.com>
Subject: LDAP Size limit exceeded
Date: Tue, 6 Nov 2007 18:02:15 -0500
Message-ID: <E5F741E838FC2043A0B843E48181813806AB75A8@MLNYC730MB.amrs.win.ml.com>
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
To: Jeff Moyer <jmoyer@redhat.com>, Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

In testing with one of our production maps imported into LDAP, came
across this in debug log

Nov  6 17:47:18 dnycxapec01 automount[6277]: read_one_map: lookup(ldap):
query failed for (objectclass=nisObject): Size limit exceeded

Looks like autofs cannot cope with more than 1000 entries and may need
to look into use of LDAP page control for large maps. This was auto.home
with several 000s of users.
--------------------------------------------------------

This message w/attachments (message) may be privileged, confidential or proprietary, and if you are not an intended recipient, please notify the sender, do not use or share it and delete it. Unless specifically indicated, this message is not an offer to sell or a solicitation of any investment products or other financial product or service, an official confirmation of any transaction, or an official statement of Merrill Lynch. Subject to applicable law, Merrill Lynch may monitor, review and retain e-communications (EC) traveling through its networks/systems. The laws of the country of each sender/recipient may impact the handling of EC, and EC may be archived, supervised and produced in countries other than the country in which you are located. This message cannot be guaranteed to be secur
 e or error-free. This message is subject to terms available at the following link: http://www.ml.com/e-communications_terms/. By messaging with Merrill Lynch you consent to the foregoing.
--------------------------------------------------------
