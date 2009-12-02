From: "Eric B." <ebenze@hotmail.com>
Subject: How to make Autofs check if LDAP server is back online?
Date: Wed, 2 Dec 2009 11:22:35 -0500
Message-ID: <BLU122-W8B55EA9052D9B5CB3439EDC950@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org



Hi,
 
I'm using Autofs and LDAP for mounting my home directories via nfs.  In
general, everything seems to work fine.  However, I have one small problem.

If I reboot my server using autofs while my LDAP server is down, I get the
following error message in my logs:
automount[3358]: bind_ldap_anonymous: lookup(ldap): Unable to bind to the
LDAP server: (default), error Can't contact LDAP server
 
which is understandable, since my ldap server is temporarily down.
 
My problem, however, is that once my ldap server is back up, autofs never
seems to retry to connect to it, so all my /home mounts fail.  Basically, it means I have to make sure that my LDAP server is never down while another server is rebooting.
 
I figure there must be something in the configuration file that would allow
me to tweak this to indicate to autofs to recheck the ldap server
periodically to see if it has come back up, but can't seem to find anything.
 
 
My /etc/sysconfic/autofs file is pretty plain:

# TIMEOUT - set the default mount timeout (default 600).
#
TIMEOUT=300
# LOGGING - set default log level "none", "verbose" or "debug"
#
LOGGING="verbose"
# Other common LDAP nameing
#
MAP_OBJECT_CLASS="automountMap"
ENTRY_OBJECT_CLASS="automount"
MAP_ATTRIBUTE="ou"
ENTRY_ATTRIBUTE="cn"
VALUE_ATTRIBUTE="automountInformation"

Is there anything I can do to force autofs to check to see if my LDAP server is back online?
 
Thanks,
 
Eric
 
  		 	   		  
_________________________________________________________________
Eligible CDN College & University students can upgrade to Windows 7 before Jan 3 for only $39.99. Upgrade now!
http://go.microsoft.com/?linkid=9691819
