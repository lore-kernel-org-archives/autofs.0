From: Ian Kent <raven@themaw.net>
Subject: Re: Local mounts without NFS server
Date: Fri, 30 Apr 2004 09:21:16 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404300918400.21424@wombat.indigo.net.au>
References: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason L Tibbitts III <tibbs@math.uh.edu>
Cc: autofs@linux.kernel.org

On Fri, 29 Apr 2004, Jason L Tibbitts III wrote:

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

Cool. Good bug report.

An unexpected side effect of the replicated server code.

I'll investigate and fix it.

Ian
