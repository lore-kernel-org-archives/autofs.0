From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Possible BUG! AutoFS and LDAP
Date: Fri, 20 Jul 2007 15:34:10 -0500
Message-ID: <46A11C42.60001@cs.ou.edu>
References: <46A10097.1020403@cs.ou.edu>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46A10097.1020403@cs.ou.edu>
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

Jim Summers wrote:
> Hello All,
> 
> I have been attempting to get autofs5 to work with my ldap config.  The 
> way I am set up is:
> 
> FC6 / FC7 clients and redhat servers.
> auto.home info for each user is stored in ldap
> auto.master is stored locally on each client
> 
> The mounts do not happen.  Here is what I see when starting autofs:
> ======
> Jul 20 13:22:53 lch automount[3427]: Starting automounter version 
> 5.0.1-11, master map auto.master
> Jul 20 13:22:53 lch automount[3427]: using kernel protocol version 5.00
> Jul 20 13:22:53 lch automount[3427]: master_error: syntax error while 
> parsing map.
> Jul 20 13:22:53 lch automount[3427]: mounted indirect mount on /misc 
> with timeout 300, freq 75 seconds
> Jul 20 13:22:53 lch automount[3427]: mounted indirect mount on /net with 
> timeout 300, freq 75 seconds
> ======
> Here is the auto.master:
> ======
> /home    ldap://129.15.1.203/ou=auto.home,dc=it,dc=ou,dc=edu

I may have stumbled onto the problem.  In the dn above, notice that it has 
dc=ou.  I was trying various things and thought, let's remove that and see 
what happens.  Sure enough the log messages start showing the attempt to get 
the /home stuff but it fails because the ldap tree doesn't match.  I can then 
put the dc=ou back in and it just fails with that syntax error.  This was all 
fine in the autofs4 version.  The ldap is setup that way to match domain for 
instance, it.ou.edu.

I can test if I can find the place in the code to change it back to the way 
that version4 was doing things and then re-compile.

Many Thanks



> ======
> nsswitch:
> ======
> automount:  files
> ======
> 
> While monitoring traffic on the ldap server.  I never see any traffic 
> from the client when the daemon is started.  So I am thinking that it is 
> not able to read the "/home" entry.
> 
> I have tried the old style colon syntax for an ldap entry.  No joy.  I 
> purposely made syntax errors and then it will say syntax error near 
> "xxxxx" as it should.
> 
> Ideas / Suggestions?
> 
> TIA
> 
> 

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
