From: Krishnakumar B <kitty@dre.vanderbilt.edu>
Subject: Help with automounting from a LDAP server
Date: Mon, 10 Jan 2005 01:29:23 -0600
Message-ID: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hi,

Are there any standard practices to follow for automounting from a LDAP
server without using local files, for both the NFS server and the clients?
The NFS clients part seems straightforward.  However it is not clear how
autofs mounts directories residing on the local filesystem on the NFS
server.

For example if I have the following setup:

1. I export /export/home from the NFS server, nfs.example.com
2. The NFS server is also configured to use the LDAP server to get
   automount information, i.e, automount: ldap in /etc/nsswitch.conf
3. auto_home is setup on the LDAP server to spit out something equivalent to:

*  -rw,hard,intr,rsize=8192,wsize=8192,nosuid nfs.example.com:/export/home

Will autofs on nfs.example.com recognize the local mount /export/home and
use a loopback mount for /home?  If so, do people recommend using the same
approach (using a direct mount) for /var/spool/mail on nfs.example.com?  If
not, why not?

Is there any way to disable specify exclude clauses in the mount options to
autofs?  For example, can I specify some option to autofs so that on a
particular machine autofs will not use the automount entry from the
directory server.

Thanks,
kitty.

-- 
Krishnakumar B <kitty at dre dot vanderbilt dot edu>
Institute for Software Integrated Systems, Dept. of EECS, Vanderbilt University
