From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: automounter w/ LDAP redundant servers
Date: Tue, 01 Aug 2006 19:06:02 -0700
Message-ID: <44D0088A.2090009@soe.ucsc.edu>
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

Hi ya'll,

I posted about this earlier but received no response...  I was wondering 
if any of you know if I can ask the developers if this is a feature that 
has not been implemented or if I simply am doing something wrong?  Maybe 
point me in the right direction?

ciao, erich

---------------------

Original post:

Question about the linux automounter that comes with fedora core 5...  I
have 3 ldap servers listed in my /etc/openldap/ldap.conf file.  They are
there for redundancy in case the primary server goes down:

/etc/openldap/ldap.conf:

host primary.domain.com slave1.domain.com slave2.domain.com
base dc=domain,dc=com

And it seems that while the primary server is up, the mounts work fine,
but when I take the primary offline, the automounter has trouble finding
the second one.  All other LDAP related actions/queries work with the 
failover server, just the automounter has troubles.

Is AutoFS for linux tweaked such that it will automatically try second
and third failover servers if they are listed in 
/etc/openldap/ldap.conf?  Or am I just doing something wrong maybe?

Thanks for any hints!

ciao, erich
