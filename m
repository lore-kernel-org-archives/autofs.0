From: Jeffrey Layton <jtlayton@poochiereds.net>
Subject: Re: replicated mounts patch
Date: Wed, 20 Apr 2005 12:03:23 -0400
Message-ID: <1114013003.9683.31.camel@barsoom.rdu.redhat.com>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net>
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net>
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.58.0504200903300.7460@wombat.indigo.net.au>
	<1113959940.5879.5.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504202319550.9260@donald.themaw.net>
	<16998.31297.836977.160607@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16998.31297.836977.160607@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, raven@themaw.net

On Wed, 2005-04-20 at 11:50 -0400, Jeff Moyer wrote:
> Does this patch actually change any of those interactions?  I guess I'll
> have to look at this earlier than I had planned.
> 

It shouldn't -- I just use the existing rpc_time() function, so it
should do the RPC ping pretty much the same as the original code. The
only difference should be that my patch looks for the tcp and nfsvers=3
mount options and does the ping accordingly if they're specified.

-- 
Jeffrey Layton <jtlayton@poochiereds.net>
