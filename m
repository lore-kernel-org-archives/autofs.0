From: Ken Poulton <poulton@calvin.labs.agilent.com>
Subject: consistent pathnames vs autofs
Date: Sat, 19 Feb 2005 12:52:44 -0800
Message-ID: <200502192052.j1JKqiKs002944@calvin.labs.agilent.com>
Mime-Version: 1.0
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

I'm trying to implement consistent global pathnames in Linux - that is,
full pathnames to files are the same on all systems, including NFS
clients and servers.  The problem is that autofs takes total ownership
of the automounting directory, so it seems impossible to make the true
file pathnames consistent between NFS servers and NFS clients. 

ON HP-UX and Sun, we mount local filesystems in /mnt/<hostname>.<volume>
and use the same names with direct automounts with NFS.  (A symlink
per volume on the local root disk avoids any need for nested NFS mounts,
e.g.  /usr/local -> /mnt/snow.local.  Nested NFS mounts need to be
avoided in a fully-cross-mounted network because they are can't be
unmounted when the NFS server is down, which can happen a lot with users'
workstations.) 

But I can't see how to implement consistent global pathnames in Linux
because we can't put both fstab and autofs mounts into one directory.
Does anyone have a solution?

Thanks,

Ken Poulton


RHEL3  2.4.21-27.ELsmp
autofs-4.1.3-47
