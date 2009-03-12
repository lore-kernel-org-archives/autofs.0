From: Ondrej Valousek <webserv@s3group.com>
Subject: autofs maps stored in AD
Date: Thu, 12 Mar 2009 10:00:11 +0100
Message-ID: <49B8CF1B.9040906@s3group.cz>
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
To: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

Hi list (Ian, all),

I am using automounter with the maps stored in Active Directory (no joy 
with the SASL/DIGES-MD5, filed bug with M$, but GSSAPI seems to work OK).
Everything works like a charm using RFC2307 schema (already present in 
Win2008).

The only problem/question I have is regarding the possibility of using 
DNS SRV records to locate the Domain Controller / ldap server.
Currently, I have to hard encode the name of the DC in 
/etc/openldap/ldap.conf (or /etc/sysconfig/autofs) and it would be just 
nice if autofs could use the SRV records the same way nss_ldap library 
does if no LDAP server is specified.

Many thanks,
Ondrej


The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited. Registered in Ireland no. 378073.
Registered Office: Whelan House, South County Business Park, Leopardstown, Dublin 18
