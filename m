From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: automounter w/ LDAP redundant servers
Date: Thu, 27 Jul 2006 20:13:45 -0700
Message-ID: <44C980E9.7060802@soe.ucsc.edu>
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

Question about the linux automounter that comes with fedora core 5...  I 
have 3 ldap servers listed in my /etc/openldap/ldap.conf file.  They are 
there for redundancy in case the primary server goes down:

/etc/openldap/ldap.conf:

host primary.domain.com slave1.domain.com slave2.domain.com
base dc=domain,dc=com

And it seems that while the primary server is up, the mounts work fine, 
but when I take the primary offline, the automounter has trouble finding 
the second one.  All other LDAP related actions/queries work, just the 
automounter has troubles.

Is AutoFS for linux tweaked such that it will automatically try second 
and third servers if they are listed in ldap.conf?  Or am I just doing 
something wrong?

Thanks for any hints!

ciao, erich
