From: linux user <linuxteam@gmail.com>
Subject: LDAP binding
Date: Wed, 13 Oct 2004 14:12:14 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <be4ff6020410130412116e1f1f@mail.gmail.com>
Reply-To: linux user <linuxteam@gmail.com>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Dear all,

We have Redhat Linux  clients that are migrating from NIS to LDAP
using the RFC2307, the ldap server is a SUN ONE DS 5.1 which runing on
a Solaris 8.0, The linux clients (different red hat releases 7.3,8.0,
RHEL 2.1, and 3.0)

We could not do autofs lookups as they seem to be binding anonoumsly
as seen from the log files, also from the code we can see that is the
case as follows :

file modules/lookup_ldap.c:
           ldap_simple_bind_s(ldap, NULL, NULL);   /*  LDAPv3 */

But in fact, according to the OpenLDAP header file (ldap.h):
            ldap_simple_bind_s(LDAP *ld, char *who, char *passwd);

So, my question is would that be changed to bind using simple bind by
passing the credniatls as seen in the configration files later on? the
who, and the password in the above lookup_ldap.c function, as we do
not have control over the ldap server as its run by different
department, and they require us to do a simple bind passing
credentials.

also what is the status of autofs when it comes to using LDAPS instead
over SSL/TLS instead of just standard ldap.

TIA

regards

W. Shaari
