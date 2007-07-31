From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: AutoFS5 Ldap base strangeness
Date: Tue, 31 Jul 2007 15:38:45 -0500
Message-ID: <46AF9DD5.4030503@cs.ou.edu>
References: <1185549849.22250.35.camel@sangay.TechFak.Uni-Bielefeld.DE>	<1185550740.3203.80.camel@raven.themaw.net>	<1185551130.22250.41.camel@sangay.TechFak.Uni-Bielefeld.DE>	<1185606915.8326.22.camel@raven.themaw.net>	<1185607363.8326.25.camel@raven.themaw.net>	<1185802596.22250.52.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1185807243.3210.26.camel@raven.themaw.net>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185807243.3210.26.camel@raven.themaw.net>
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

hello all,

I am just about to get my automounting working with autofs5 and my ldap.  I am 
able to start the automount daemon and it loads and reads /home map, which 
points at ou=auto.home for the user's home directory location and options.

but when i attempt to su - <user> it can not mount the user's home.  here is 
what i see in the ldap server's access log:
===
[31/Jul/2007:15:28:19 -0500] conn=8420 op=1 SRCH 
base="cn=sfu,ou=auto.home,dc=it,dc=ou,dc=edu" scope=2 
filter="(&(objectClass=automount)(|(automountKey=tmac)(automountKey=/)))" 
attrs="automountKey automountInformation"
[31/Jul/2007:15:28:19 -0500] conn=8420 op=1 RESULT err=0 tag=101 nentries=0 
etime=0
[31/Jul/2007:15:28:19 -0500] conn=8420 op=2 UNBIND
===

the weird part of the above is, in the first line it says "cn=sfu" but then 
also says automountKey=tmac

the su command is:  su - tmac

so the correct username is tmac not sfu.

any ideas where the sfu thing is coming from??

is the info cached somewhere?  I ask because when I start the daemon, i can 
see in the logs where it does:
===
[31/Jul/2007:15:35:40 -0500] conn=8536 op=1 SRCH 
base="ou=auto.home,dc=it,dc=ou,dc=edu" scope=2 
filter="(objectClass=automount)" attrs="1.1"
[31/Jul/2007:15:35:40 -0500] conn=8536 op=1 RESULT err=0 tag=101 nentries=617 
etime=0
===
which is returning 617 entries.

not sure what i have wroong here??

TIA
-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
