From: Paul Raines <raines@nmr.mgh.harvard.edu>
Subject: Re: rm hangs on symlinks to down mount points
Date: Wed, 31 Dec 2003 09:25:18 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312310919320.24097-100000@gate.nmr.mgh.harvard.edu>
References: <Pine.LNX.4.44.0312310153360.407-100000@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0312310153360.407-100000@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>


I believe I made a mistake and feel pretty stupid now.  I think the hung
automount subprocesses are not hanging on the mount but on the umount.  
Does autofs ever call umount with the -f option after the first (few)
regular umount's fail. If autofs has made a mount, the server dies, then
the mount times out from no use so autofs wants to umount it, how does
autofs handle the situation?

On Wed, 31 Dec 2003, Ian Kent wrote:
> > Yet somehow it is invovled.  I never have the problem with any hard mounts.
> > On those I can always succeed in unmounting them when they go down. I do
> > that by killing processes and doing a 'umount -f'.  A small percentage of
> > mounts made by autofs seem to become "permanent".  They seem usually tied
> > to a automount subprocess that will not go away.  Again, I can do a 'kill
> > -9' on that automount subprocess.  After that, sometimes an 'umount -f'
> > will work, and sometimes I still get 'device busy'.
> 
> Now your talking about different problems that appear related. The mounts
> are tied to the automount process and if you 'kill -9' the process,
> antomount can't clean up and you should expect to have problems. One
> possibility to help with this is to implement a umount_begin function in
> the kernel module to allow it to clean up if possible during a umount -f.
> I'm not sure how much mileage this will get but could prove effective.
