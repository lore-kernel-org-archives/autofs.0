From: Mike Marion <mmarion@qualcomm.com>
Subject: Another LDAP weirdness we're seeing.
Date: Tue, 6 Feb 2007 14:53:58 -0800
Message-ID: <20070206225358.GJ21027@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

Trying to track down if it's in the client at all, but related to my
last mail.. if we start the daemon with --ghost, sometimes the hosts are
failing to start all the children of /- (or even /- itself). 

The logs I've gotten when it failed were:
Feb  6 13:32:09 k8-032 automount[2243]: starting automounter version
4.1.4, path = /-, maptype = ldap, mapname =
automountmapname=auto.projects,ou=automountMaps,ou=sandiego,ou=qct,dc=qualcomm,dc=com
Feb  6 13:32:11 k8-032 automount[2243]: lookup(ldap): LDAP query failed:
No such object
Feb  6 13:32:11 k8-032 automount[2243]: failed to load map exiting

Trying to start it by running the autofs init script again by hand
shortly after this, it works fine.  Is there some point in the initial
read of the maps that has a timeout?  We're tying to narrow down if it's
the client timing out (ldap servers not responding fast enough) or if
the servers are actually returning a bad value (or the above 'no such
object') which, obviously, shouldn't be happening.

We're still doing further testing, just wondering if anyone's seen
anything similar that might help us fix it faster... didn't see anything
obvious in the mails I have in my box.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Drew: "Dear pizza, I do not care, or give a wit, that you are one day old.  
I think you are beautiful, even when you are cold."  -- Drew Cary Show.
