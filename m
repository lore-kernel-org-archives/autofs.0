From: Ian Kent <raven@themaw.net>
Subject: Re: replicated mounts patch
Date: Thu, 21 Apr 2005 12:35:58 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504211222340.7676@wombat.indigo.net.au>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net> 
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net> 
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.58.0504200903300.7460@wombat.indigo.net.au> 
	<1113959940.5879.5.camel@tleilax.poochiereds.net> 
	<Pine.LNX.4.62.0504202319550.9260@donald.themaw.net> 
	<16998.31297.836977.160607@segfault.boston.redhat.com>
	<1114013003.9683.31.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1114013003.9683.31.camel@barsoom.rdu.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Wed, 20 Apr 2005, Jeffrey Layton wrote:

> On Wed, 2005-04-20 at 11:50 -0400, Jeff Moyer wrote:
> > Does this patch actually change any of those interactions?  I guess I'll
> > have to look at this earlier than I had planned.
> > 
> 
> It shouldn't -- I just use the existing rpc_time() function, so it
> should do the RPC ping pretty much the same as the original code. The
> only difference should be that my patch looks for the tcp and nfsvers=3
> mount options and does the ping accordingly if they're specified.

Hold on. I haven't got far into the patch at all.

I was talking about the function to check whether an address is local.
It uses a UDP socket connection to the discard port for this.

My question was, what if UDP is blocked?
I was trying to show up issues we've had in the past related to socket 
connections.

Ian
