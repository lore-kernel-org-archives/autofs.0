From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Local mounts without NFS server
Date: 29 Apr 2004 15:33:32 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

I'm new to this list but I've looked through the past few months in
the archive and didn't see anything similar.  I've been using autofs
for ages to manage home directories and third party applications
across my network.  Now I've installed a new machine with Fedora Core
2 test 3 which is my first experience with autofs4.  Unfortunately it
looks like one component of my setup isn't working or is no longer
supported.

We have various pieces of third party software under /usr/local, which
is an automount map.  Some applications are frequently used, so there
is a local partition on each machine that has enough disk called
/cache which is kept updated via rsync.  An entry in
/etc/auto_usr_local looks like:

matlab          localhost:/cache/pkg/matlab-6.5.1

For years that entry has caused autofs to set up a bind mount so that
/usr/local/matlab is bound to /cache/pkg/matlab-6.5.1.  This has
worked on all clients.

Under FC2T3/autofs-4.1.2-2 this doesn't work _unless_ I export /cache
via NFS.  This is what I see in the logs before the export with '-v'
passed to automount:

Apr 29 14:18:37 compute08 automount[5140]: attempting to mount entry /usr/local/matlab
Apr 29 14:18:37 compute08 automount[5158]: mount(nfs): no host elected
Apr 29 14:18:37 compute08 automount[5158]: failed to mount /usr/local/matlab

After I do the export everything works fine, but NFS isn't actually
used for the mount.  From /proc/partitions:

/dev/vg0/cache /usr/local/matlab ext3 rw 0 0

That's good, but why did I have to do the export?  The bind would
succeed without it, so I'm not sure why it's necessary.

Thanks,

 - J<
