From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Sat, 5 Jun 2004 23:00:50 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16578.35042.873671.838640@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<16576.60526.394177.533027@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406051327020.12824@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406051327020.12824@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; raven@themaw.net adds:

raven> On Fri, 4 Jun 2004, Jeff Moyer wrote: A couple of things ...

>>
jmoyer> I've strace'd the automount process, and a lot of time is spent in
jmoyer> the clnt_create, for both UDP and the TCP.  I implemented a
jmoyer> non-blocking connect, and it took my ls time down from 8m21s to
jmoyer> 2m4s.  I'm still looking into why the UDP stuff isn't timing out
jmoyer> sooner.
>> The clnt_create call does not take a timeout.  One of the things it does
>> is to contact the remote portmapper to get the port for the specified
>> program number.  There is a hard-coded default timeout in that code of
>> 60 seconds, which explains my 2 minutes.
>> 
>> This patch simply implements an icmp ping (code shamelessly stolen from
>> clumanager), and does this before even attempting to do the rpc pings.
>> If the icmp ping works, then we continue as usual.  This takes care of
>> the host down case quite nicely:
>> 
>> One nit: icmp_ping_host takes a char * for the hostname, whereas
>> rpc_ping passes a const char *.  As such, we get a 'discards qualifier'
>> warning.  I didn't think it warrented converting the whole call chain to
>> consts, but if you're especially concerned about that, Ian, I'd be happy
>> to resubmit.

raven> I've put a cast in to eliminate the warning.

raven> I added the Makefile glue and ...

Whoops, I can't believe I left that out!  Sorry!

raven> I noticed that, for the case the request is not a replicated server
raven> entry a mount is still attempted so I added a ping check.

raven> I've attached the complete patch but here is what I added. Can you
raven> test it in your environment before I commit it please:

Yes, that looks correct to me.  I tested it with the same test case I was
using before, and all is well.  One thing:

  mount_nfs.c: In function `get_best_mount':
  mount_nfs.c:232: warning: implicit declaration of function `icmp_ping_host'

You forgot to #include "ping.h"!  Maybe between the two of us we'll get
this right.  ;)

Thanks, Ian!

Jeff
