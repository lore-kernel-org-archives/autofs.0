From: Jeff Moyer <jmoyer@redhat.com>
Subject: rpc_ping always uses UDP
Date: Wed, 12 May 2004 15:00:28 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16546.29772.254542.152548@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: autofs@linux.kernel.org

Hello Ian, list,

I had a user report an issue which is summed up in the subject.  Basically,
he disallowed UDP traffic to his NFS server.  Because the autofs code uses
UDP in the rpc_ping function to determine if a server is alive, it would
conclude that the server was not alive.  He was, of course, using NFSv4
over TCP.

This is a bit of a corner case.  I'm not sure if this is a valid problem or
not, and I'm sure it could be argued either way.  So, what does the list
think?

To provide further information on the implementation implications, we would
actually have to look at the filesystem options, which is something we
don't really need to bother ourselves with, at the moment.  That part
sounds a little ugly to me.

So, thoughts?  Comments?

-Jeff
