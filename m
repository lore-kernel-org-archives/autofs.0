From: Brian Long <brilong@cisco.com>
Subject: Re: Local mounts without NFS server
Date: Fri, 30 Apr 2004 10:44:46 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1083336286.21825.37.camel@brilong-lnx2.cisco.com>
References: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
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
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

Jason,

I like your idea about keeping the /cache up to date via rsync.  What
other maps, mounts or symlinks do you have to keep this working?  I'd be
interested in knowing how to set this up.  :)

For example, for hosts that don't have a /cache filesystem, do they have
a separate auto_usr_local map?  Do all your machines that have /cache
always mirror the same directories so you only maintain one
/etc/auto_usr_local file?

Thanks.

/Brian/

On Thu, 2004-04-29 at 16:33, Jason L Tibbitts III wrote:
> I'm new to this list but I've looked through the past few months in
> the archive and didn't see anything similar.  I've been using autofs
> for ages to manage home directories and third party applications
> across my network.  Now I've installed a new machine with Fedora Core
> 2 test 3 which is my first experience with autofs4.  Unfortunately it
> looks like one component of my setup isn't working or is no longer
> supported.
> 
> We have various pieces of third party software under /usr/local, which
> is an automount map.  Some applications are frequently used, so there
> is a local partition on each machine that has enough disk called
> /cache which is kept updated via rsync.  An entry in
> /etc/auto_usr_local looks like:
> 
> matlab          localhost:/cache/pkg/matlab-6.5.1
> 
> For years that entry has caused autofs to set up a bind mount so that
> /usr/local/matlab is bound to /cache/pkg/matlab-6.5.1.  This has
> worked on all clients.
> 
> Under FC2T3/autofs-4.1.2-2 this doesn't work _unless_ I export /cache
> via NFS.  This is what I see in the logs before the export with '-v'
> passed to automount:
> 
> Apr 29 14:18:37 compute08 automount[5140]: attempting to mount entry /usr/local/matlab
> Apr 29 14:18:37 compute08 automount[5158]: mount(nfs): no host elected
> Apr 29 14:18:37 compute08 automount[5158]: failed to mount /usr/local/matlab
> 
> After I do the export everything works fine, but NFS isn't actually
> used for the mount.  From /proc/partitions:
> 
> /dev/vg0/cache /usr/local/matlab ext3 rw 0 0
> 
> That's good, but why did I have to do the export?  The bind would
> succeed without it, so I'm not sure why it's necessary.
> 
> Thanks,
> 
>  - J<
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
-- 
       Brian Long                      |         |           |
       Americas IT Hosting Sys Admin   |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s
