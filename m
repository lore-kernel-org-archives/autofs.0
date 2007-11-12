From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: sasl support breaks ldap module
Date: Mon, 12 Nov 2007 23:09:00 +0100
Message-ID: <4738CEFC.5000700@inria.fr>
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

Hello.

I just found out than enabling sasl support caused lookup_ldap to be
non-functionnal, because of unresolved symbols:
Nov  7 11:31:10 etoile automount[2743]: open_lookup: cannot open lookup
module
ldap (/usr/lib/autofs/lookup_ldap.so: undefined symbol:
krb5_get_init_creds_keytab)

Shouldn't this module get linked to kerberos lib, in addition to sasl lib ?
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
