From: Steve Rigler <srigler@marathonoil.com>
Subject: Do Include Maps Work With LDAP
Date: Fri, 13 Jul 2007 10:08:07 -0500
Message-ID: <1184339287.27865.20.camel@houuc8>
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

We are running autofs-4.1.3-199.3 on RHEL 4.5.  The changelog states
that include maps can be used to "include a nis map of the same name".

I am attempting this with LDAP and was wondering if it was supported or
even possible.  What I've noticed is that the include directive will
only handle the map name (using the DN gives a message that "nsswitch:
couldn't find map").  When using the map name *all* it looks like
automount includes all of the keys from all of our maps rather than just
the ones in the map we're trying to include.

Does this only work with NIS or should it be possible with LDAP?

Thanks,
Steve
