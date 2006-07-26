From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: AutoFS problem with OpenLDAP server
Date: Wed, 26 Jul 2006 13:23:14 -0700
Message-ID: <44C7CF32.7030501@soe.ucsc.edu>
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

Greetings all-

I have a strange problem with AutoFS under Fedora Core 5.  Can't seem to 
automount via ldap the way I should be able to.  If I have:

automount: files ldap

in /etc/nsswitch.conf, and have:

/projects 
ldap://ldapserver.domain.com/nisMapName=auto.projects,dc=domain,dc=com

in /etc/auto.master, everything works.  However, I don't want my clients 
to be configured this way because I have two redundant OpenLDAP servers 
and would like AutoFS to automatically try a second LDAP server if the 
first one goes down.  So I put this in /etc/nsswitch.conf:

automount: ldap

and tried to restart AutoFS, and got the error:

[root@sunbright default]# /etc/init.d/autofs start
Starting automount: No Mountpoints Defined                 [  OK  ]
[root@sunbright default]#

But there ARE automount maps in OpenLDAP, as the first method works.  If 
I try the "automount" command manually, I get this in the logs:

Jul 26 13:06:34 sunbright automount[22965]: starting automounter version 
4.1.4-19, path = /projects, maptype = ldap, mapname = 
nisMapName=auto.projects,dc=domain,dc=com
Jul 26 13:06:34 starbright automount[22965]: lookup(ldap): couldn't bind 
to default server

The server does accept anonymous lookups.  I even watched the traffic 
(via tcpdump) from the client to the server and there was no traffic at 
all!  Seems the client isn't even trying to contact any of my LDAP 
servers.

Does anyone have any ideas as to what's happening?  Like I said I would 
like the automounter to try each of my 3 servers in order listed in 
/etc/ldap.conf, so manually specifying one server in /etc/auto.master 
isn't very appealing...

Thanks in advance for any insight!

ciao, erich
