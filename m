From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Hierarchical mount points in automount maps
Date: Mon, 12 Jun 2006 15:50:17 -0400
Message-ID: <x49irn6tapy.fsf@segfault.boston.redhat.com>
References: <9D9C36F25770704685BF3E652F9D1CFD0BAF06@bp1vhoex011.bp1.ad.bp.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <9D9C36F25770704685BF3E652F9D1CFD0BAF06@bp1vhoex011.bp1.ad.bp.com>
	(Dennis W. Murata's message of "Mon, 5 Jun 2006 14:27:46 -0500")
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
Content-Transfer-Encoding: 7bit
To: "Murata, Dennis W (SAIC)" <dennis.murata@bp.com>
Cc: autofs@linux.kernel.org

==> Regarding [autofs] Hierarchical mount points in automount maps; "Murata, Dennis W \(SAIC\)" <dennis.murata@bp.com> adds:

dennis.murata> I am seeing some instability using hierarchical mount points
dennis.murata> in automount maps.  The version of autofs is
dennis.murata> autofs-4.1.3-168 on RHEL 3 update 7.  The workstations are
dennis.murata> dual opteron running x86_64 version of RHEL.  The maps are
dennis.murata> local to the workstation, and follow the format:
dennis.murata> 	foobar1/a     server1:/local/foobar1/a
dennis.murata> 	foobar1/b     server1:/local/foobar1/b
dennis.murata> 	foobar2/c     server1:/local/foobar2/c
dennis.murata> 	foobar3/d     server1:/local/foobar3/d
dennis.murata> 	foobar4/f     server1:/local/foobar4/f
dennis.murata> 	foobar4/g     server1:/local/foobar4/

dennis.murata> The map name is auto.foobars, the entry in the auto.master is:
dennis.murata> 	/foobars	   /etc/auto.foobars --ghost

dennis.murata> After a reboot, the directory structure is fine.  After a cd
dennis.murata> to /foobars, an ls will list all directories foobar1 through
dennis.murata> foobar4.  The subdirectories will be correct below foobar*.
dennis.murata> After a time period, I believe the timeout set in
dennis.murata> /etc/sysconfig/autofs, the mount points become confused.
dennis.murata> Instead of the subdirectories a and b listed below
dennis.murata> /foobars/foobar1, the directories will be listed below
dennis.murata> /foobars/foobar1/foobar1.  This can happen to any/all of the
dennis.murata> foobar* directories.
  
dennis.murata> I have tried various formats  of the automount map.  I have tried to escape the slash in the directory structure on the left hand side, i.e. foobar1\/a, I have tried something like this for auto.foobar:

dennis.murata> 	foobar1 \
dennis.murata> 	/a     server1:/local/foobar1/a \
dennis.murata> 	/b     server1:/local/foobar1/b
dennis.murata> 	foobar2 \
dennis.murata> 	/c     server1:/local/foobar2/c
dennis.murata> 	foobar3 \
dennis.murata> 	/d     server1:/local/foobar3/d
dennis.murata> 	foobar4 \
dennis.murata> 	/f     server1:/local/foobar4/f \
dennis.murata> 	/g     server1:/local/foobar4/g

This is the correct way to specify the map.  If the previous map you listed
worked, it was by accident.

dennis.murata> With all three tries, initially the mounts are correct,
dennis.murata> after a time the mounts become confused.  Without the
dennis.murata> --ghost, none of the subdirectories of foobar* are visible
dennis.murata> or even accessible.  Are hierachical mounts supported?  I
dennis.murata> was a little surprised this worked at all.  The automount
dennis.murata> maps I am used to dealing with came from Solaris and never
dennis.murata> used subdirectories on the left side.

I have been unable to duplicate this problem.  What is the kernel version
you are using?  Also, please provide all of the debugging information
request at:
  http://people.redhat.com/jmoyer/

Thanks,

Jeff
