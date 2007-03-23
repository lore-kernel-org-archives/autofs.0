From: Victor Danilchenko <danilche@cs.umass.edu>
Subject: Automount 5 LDAP filtering question
Date: Fri, 23 Mar 2007 11:05:59 -0400
Message-ID: <4603ECD7.8080906@cs.umass.edu>
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

	Hi all,

	We have a widely deployed autofs net with LDAP as the map source. So 
far, it has worked marvelously well. We have recently installed an FC6 
host, and ran into some problems. All but one of them are solved, but 
that one remains a thorn in my side.

	The problem is this. We have individual systems indirectly automounting 
each other. As such, it is useful for them to be able to keep both the 
automounted and the local mountpoints in the same tree, for performance 
reasons (rather than mount self over NFS from the /exports/myhost 
directory into the /nfs/myhost directory, for example). With automount 
4, it was easy. Since it was getting the LDAP master map via a dedicated 
utility which printed the formatted map to STDOUT, we just modified the 
way this utility is called:

/usr/lib/autofs/autofs-ldap-auto-master | grep -v auto.`hostname`

	This way, each automounting host in a given group would get the entire 
auto.master map from LDAP, but without that host's own automount entry 
-- it would have the local volumes already mounted in the same location. 
Every host's volumes are just transparently accessible in /nfs/<hostname>/*

	In comes automount 5. There is no longer the wrapper script, automount 
knows how to use the LDAP master map directly. We got it all to work 
with out current LDAP data tree, with one 'but': I can find no facility 
to exclude self's automount entry.

	Is there perhaps some undocumented way to specify an additional LDAP 
filter clause that could be conjoined with the standard 
'(objectClass=<DEFAULT_ENTRY_OBJECT_CLASS>)' filter? I can't imagine 
nobody else has run into the problem of excluding self's mounts from the 
LDAP master map in a cross-mount situation...

	Something conceptually equivalent to this, to go into 
/etc/sysconfig/autofs:

EXTRA_FILTER_CLAUSE="!(cn=/nfs/myhost)"

	So that if the EXTRA_FILTER_CLAUSE is defined, the "(<DEFAULT_FILTER>)" 
is replaced with:

"(&(<DEFAULT_FILTER>)(EXTRA_FILTER_CLAUSE))"

	Is there anything in Automount 5 that would provide this sort of 
functionality?

-- 
|  Victor  Danilchenko  | Students nowadays, complaining they only get |
| danilche@cs.umass.edu | 10MBs of disk space! In my day we were lucky |
|   CSCF   |   5-4231   | if we had one file, and that was /dev/null.  |
