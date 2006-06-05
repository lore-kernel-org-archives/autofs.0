From: "Murata, Dennis W \(SAIC\)" <dennis.murata@bp.com>
Subject: Hierarchical mount points in automount maps
Date: Mon, 5 Jun 2006 14:27:46 -0500
Message-ID: <9D9C36F25770704685BF3E652F9D1CFD0BAF06@bp1vhoex011.bp1.ad.bp.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I am seeing some instability using hierarchical mount points in automount maps.  The version of autofs is autofs-4.1.3-168 on RHEL 3 update 7.  The workstations are dual opteron running x86_64 version of RHEL.  The maps are local to the workstation, and follow the format:

	foobar1/a     server1:/local/foobar1/a
	foobar1/b     server1:/local/foobar1/b
	foobar2/c     server1:/local/foobar2/c
	foobar3/d     server1:/local/foobar3/d
	foobar4/f     server1:/local/foobar4/f
	foobar4/g     server1:/local/foobar4/

The map name is auto.foobars, the entry in the auto.master is:
	/foobars	   /etc/auto.foobars --ghost

After a reboot, the directory structure is fine.  After a cd to /foobars, an ls will list all directories foobar1 through foobar4.  The subdirectories will be correct below foobar*.  After a time period, I believe the timeout set in /etc/sysconfig/autofs, the mount points become confused.  Instead of the subdirectories a and b listed below /foobars/foobar1, the directories will be listed below /foobars/foobar1/foobar1.  This can happen to any/all of the foobar* directories.
  
I have tried various formats  of the automount map.  I have tried to escape the slash in the directory structure on the left hand side, i.e. foobar1\/a, I have tried something like this for auto.foobar:

	foobar1 \
	/a     server1:/local/foobar1/a \
	/b     server1:/local/foobar1/b
	foobar2 \
	/c     server1:/local/foobar2/c
	foobar3 \
	/d     server1:/local/foobar3/d
	foobar4 \
	/f     server1:/local/foobar4/f \
	/g     server1:/local/foobar4/g

With all three tries, initially the mounts are correct, after a time the mounts become confused.
Without the --ghost, none of the subdirectories of foobar* are visible or even accessible.
Are hierachical mounts supported?  I was a little surprised this worked at all.  The automount maps I am used to dealing with came from Solaris and never used subdirectories on the left side.

Wayne Murata
