From: "Anthony M. Martinez" <twopir@nmt.edu>
Subject: [PATCH] starttls in autofs-ldap-auto-master.c
Date: Thu, 23 Mar 2006 10:54:00 -0700
Message-ID: <20060323175359.GD12245@nmt.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

I'm using Timo Felbinger's excellent ldap-URI support patch to autofs.
However, it doesn't patch autofs-ldap-auto-master to support either
starttls or URIs.  This program is used in Debian's (and probably
others) autofs init script if nsswitch contains automount: ldap.

Since our LDAP server is configured to require confidentiality, I made
the program default to using it.

Attached is a patch to require the server to support tls, unless -s is
enabled, in which case it doesn't even try. The patch is against the
Debian stable autofs-4.1.3+4.1.4beta2 source archive. I just dropped it
in debian/patches/00_local_starttls and recompiled.

Hope this is useful to someone!

Pi

-- 
How'd you get this number?
-- A Qwest Central Office Technician
