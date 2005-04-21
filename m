From: Ian Kent <raven@themaw.net>
Subject: Re: replicated mounts patch
Date: Thu, 21 Apr 2005 12:39:26 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504211236540.7676@wombat.indigo.net.au>
References: <1113875877.4581.15.camel@tleilax.poochiereds.net> 
	<1113912312.1274.26.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.62.0504200053250.8587@donald.themaw.net> 
	<1113933871.1274.56.camel@barsoom.rdu.redhat.com> 
	<Pine.LNX.4.58.0504200903300.7460@wombat.indigo.net.au> 
	<1113959940.5879.5.camel@tleilax.poochiereds.net> 
	<Pine.LNX.4.62.0504202319550.9260@donald.themaw.net>
	<1114012444.9683.28.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1114012444.9683.28.camel@barsoom.rdu.redhat.com>
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

> On Wed, 2005-04-20 at 23:24 +0800, raven@themaw.net wrote:
> > I've tested this and it certainly seems to work.
> > 
> > But another thing came to mind.
> > 
> > We've had complaints about ports and protocols being blocked for the 
> > rpc_ping function.
> > 
> > Any thoughts on how to work around that?
> 
> My patch should address this somewhat -- it looks for the 'tcp' and
> 'nfsvers=' mount options and does the RPC ping according to those. So if
> the ping doesn't work due to blocked ports, then the mount won't work
> either.

I saw that but as I said I haven't got that far yet.
It is clearly the right approach though.

> 
> > The other thing that plagues us is that when we open TCP sockets they hang 
> > around which causes port exaustion.
> > Thoughts on that as well?
> 
> On this part, there's not much we can do. The kernel leaves sockets in
> FIN_WAIT for a little while in case any stray packets come in after the
> connection has been closed. I don't think much (if anything) can be done
> from userspace to affect this, other than to close the socket as soon as
> possible.

Yes. The only thing we can do is be careful to limit the number of TCP 
connections we make as much as possible.

Ian
