From: raven@themaw.net
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Sat, 5 Jun 2004 10:08:58 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406051003140.1643@donald.themaw.net>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
 <16576.51269.311121.121046@segfault.boston.redhat.com>
 <16576.60526.394177.533027@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16576.60526.394177.533027@segfault.boston.redhat.com>
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

On Fri, 4 Jun 2004, Jeff Moyer wrote:

> 
> jmoyer> I've strace'd the automount process, and a lot of time is spent in
> jmoyer> the clnt_create, for both UDP and the TCP.  I implemented a
> jmoyer> non-blocking connect, and it took my ls time down from 8m21s to
> jmoyer> 2m4s.  I'm still looking into why the UDP stuff isn't timing out
> jmoyer> sooner.
> 
> The clnt_create call does not take a timeout.  One of the things it does is
> to contact the remote portmapper to get the port for the specified program
> number.  There is a hard-coded default timeout in that code of 60 seconds,
> which explains my 2 minutes.
> 
> This patch simply implements an icmp ping (code shamelessly stolen from
> clumanager), and does this before even attempting to do the rpc pings.  If
> the icmp ping works, then we continue as usual.  This takes care of the
> host down case quite nicely:
> 
> # time ls /multi/multi1
> foo
> 
> real    0m0.208s
> user    0m0.010s
> sys     0m0.010s
> 
> Ian, I can also post the nonblocking connect patch, but I'm unsure of its
> usefulness vs. complexity ratio.  I say we only cross that bridge if we
> need to.

Agreed.

> 
> One nit: icmp_ping_host takes a char * for the hostname, whereas rpc_ping
> passes a const char *.  As such, we get a 'discards qualifier' warning.  I
> didn't think it warrented converting the whole call chain to consts, but if
> you're especially concerned about that, Ian, I'd be happy to resubmit.
>

I'll see if I can get rid of the warning in some simple way. If only as a 
clear indication it's what we intended to do.

In fact I will be able to use this to make the umount smarter later some 
time.
 
> 
> Comments?

I've only had a brief look at the patch but it looks like good clean code.

One small thing though.

I understand you need to attribute Copyright to Redhat but don't you think 
it would be acceptable to add your name their as well?

Ian
