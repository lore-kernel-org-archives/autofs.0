From: Sven Ulland <sveniu@ifi.uio.no>
Subject: Change dn of auto.master for autofs+ldap
Date: Fri, 25 Aug 2006 23:12:02 +0200
Message-ID: <44EF67A2.2090905@ifi.uio.no>
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

I'm setting up autofs in ldap, i.e. I'm not using the /etc/auto.*
files at all. Now, I'm wondering how to change the distinguished name
of auto.master in the database. It seems all examples use the
following structure for the entry:

dn: ou=auto.master,dc=mydom,dc=com
ou: auto.master
objectClass: top
objectClass: automountMap

I grepped the archives to see if it is possible to specify some
options for this in nsswitch.conf, but couldn't find anything. So how
would I go about changing the dn of the auto.master (and the rest of
the auto.* entries) so that they recide under ou=system? Maybe that
is something I don't want to do?

regards,
sven
