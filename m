From: Ian Kent <raven@themaw.net>
Subject: Re: Local mounts without NFS server
Date: Fri, 30 Apr 2004 14:23:24 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404301421240.27225@wombat.indigo.net.au>
References: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
 <Pine.LNX.4.58.0404300918400.21424@wombat.indigo.net.au>
 <ufaad0ukxk5.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ufaad0ukxk5.fsf@epithumia.math.uh.edu>
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

> >>>>> "IK" == Ian Kent <raven@themaw.net> writes:
> 
> IK> An unexpected side effect of the replicated server code.
> 
> Ah, I see how it would interfere, given that all of the hosts are
> pinged (via RPC) and localhost fails since it doesn't export anything.

I shouldn't be pinging local addresses at all.

> 
> IK> I'll investigate and fix it.
> 
> Thanks.  Could you just call is_local_addr and if so check that the
> path exists instead of doing the RPC ping?  That way you could use
> localhost and remote hosts as alternate servers.  (I could use this
> for machines without enough disk to cache things.)

I shouldn't need to do that either.

This is a programming error. I'll fix it tonight I hope.

Ian
