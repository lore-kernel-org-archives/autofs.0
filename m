From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Fri, 4 Jun 2004 09:17:04 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16575.35426.918728.134817@segfault.boston.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Thu, 3 Jun 2004, Jeff Moyer wrote:

> Hello, Ian, list,
> 
> You may recall my asking for the rpc_ping function to take TCP only servers
> into account.  Well, be careful what you ask for!  Now, if a server is down
> in a replicated server configuration, it takes quite a while to timeout
> due to the TCP connect.  The mount will eventually succeed, but I've seen
> this take up to 10 minutes.

I'm not sure that I see that same behaviour in my test environment.

I'll check and get back.
It's probably best if we understand this a little better before jumping 
in.

> 
> Perhaps we should first test to see if a host is reachable at all before we
> begin our rpc pings?

Sigh!

Will the fall out from the replicated server implementation it never end.

Ian
