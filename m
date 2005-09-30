From: Jim Kusznir <kusznir@eecs.wsu.edu>
Subject: Autofs LDAP info
Date: Thu, 29 Sep 2005 17:28:28 -0700
Message-ID: <433C86AC.1010100@eecs.wsu.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hello all:

I've been tasked with making AutoFS get its maps from a Windows 2003 
Active Directory server via LDAP.  I know AutoFS works with LDAP in some 
fashon or another, however the documentation seems very sparce, and 
information on the net seems very fragmented and contradictory in areas.

My primary questions at this point:

What schema(s) does the latest AutoFS support?  Does it support 
standards such as NisMap?  (I've found both "yes" and "no" answers to 
this on the net, and no details in either)

How are maps entered in such schema?

Are there any HOWTOs that cover LDAP specifically?  (I'm familiar with 
the amd-autofs howto at linuxconsulting, however I haven't found any 
useful (as of yet) LDAP info in there).

I currently have AutoFS working via NIS maps wonderfuly, but my work 
over the next few months is to migrate everything from NIS into the AD 
server so as to retire it.

Thanks!
--Jim
