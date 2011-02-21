From: =?ISO-8859-1?Q?Erwan_Loa=EBc?= <erwan.loaec@cgin.fr>
Subject: autofs always requires openldap dependency
Date: Mon, 21 Feb 2011 09:51:58 +0100
Message-ID: <4D6227AE.4040006@cgin.fr>
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

I've noticed each time I compile autofs I need openldap headers, even if 
I use the option "--without-openldap".

The file lib/defaults.c always include ldap.h (and use it...)

It "works" if I comment these lines in include/lookup_ldap.h:

4: //#include <ldap.h>
112: //LDAP *init_ldap_connection(unsigned logopt, const char *uri, 
struct lookup_context *ctxt);
113: //int unbind_ldap_connection(unsigned logopt, LDAP *ldap, struct 
lookup_context *ctxt);

But I think it's really a dirty solution...


-- 
Erwan Loaec
