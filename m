From: Jason L Tibbitts III <tibbs@math.uh.edu>
Subject: Re: Local mounts without NFS server
Date: 29 Apr 2004 21:29:46 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <ufaad0ukxk5.fsf@epithumia.math.uh.edu>
References: <ufa65bi8qxv.fsf@epithumia.math.uh.edu>
	<Pine.LNX.4.58.0404300918400.21424@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404300918400.21424@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

>>>>> "IK" == Ian Kent <raven@themaw.net> writes:

IK> An unexpected side effect of the replicated server code.

Ah, I see how it would interfere, given that all of the hosts are
pinged (via RPC) and localhost fails since it doesn't export anything.

IK> I'll investigate and fix it.

Thanks.  Could you just call is_local_addr and if so check that the
path exists instead of doing the RPC ping?  That way you could use
localhost and remote hosts as alternate servers.  (I could use this
for machines without enough disk to cache things.)

 - J<
