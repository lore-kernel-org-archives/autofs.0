From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: Local mounts without NFS server
Date: 30 Apr 2004 09:57:52 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <ufa65bh1pjj.fsf@epithumia.math.uh.edu>
References: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
	<1083336286.21825.37.camel@brilong-lnx2.cisco.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083336286.21825.37.camel@brilong-lnx2.cisco.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Long <brilong@cisco.com>
Cc: autofs@linux.kernel.org

>>>>> "BL" == Brian Long <brilong@cisco.com> writes:

BL> I like your idea about keeping the /cache up to date via
BL> rsync.

Well, it's actually a hack but it works well enough.

BL> What other maps, mounts or symlinks do you have to keep this
BL> working?

Just to /etc/auto_usr_local files, one for the hosts with /cache and
one without.  These days, though, every machine has enough disk to
cache what it needs.  That wasn't the case back when I put this
together.

BL> For example, for hosts that don't have a /cache filesystem, do
BL> they have a separate auto_usr_local map?

Yes, the hosts pull what they need from a server, and hosts without
/cache pull a different auto_usr_local map.  I guess if I used
failover I wouldn't even have to do that, but I'm not sure if that's
supported far enough back.

BL> Do all your machines that have /cache always mirror the same
BL> directories so you only maintain one /etc/auto_usr_local file?

Yes, that makes it simple.  But it wouldn't be too hard to pull down
directories until the disk gets too full and either use failover or
autogenerate /etc/auto_usr_local depending on what you could fit.  I
don't have enough third-party applications to make that worthwhile.
(Just Mathematica, Matlab, Maple, the Portland Group compilers and
some locally compiled stuff that I really should turn into RPMs.)

 - J<
