From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Fri, 4 Jun 2004 15:06:45 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16576.51269.311121.121046@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; Ian Kent <raven@themaw.net> adds:

raven> On Thu, 3 Jun 2004, Jeff Moyer wrote:
>> Hello, Ian, list,
>> 
>> You may recall my asking for the rpc_ping function to take TCP only
>> servers into account.  Well, be careful what you ask for!  Now, if a
>> server is down in a replicated server configuration, it takes quite a
>> while to timeout due to the TCP connect.  The mount will eventually
>> succeed, but I've seen this take up to 10 minutes.

raven> I'm not sure that I see that same behaviour in my test environment.

raven> I'll check and get back.  It's probably best if we understand this a
raven> little better before jumping in.

I've strace'd the automount process, and a lot of time is spent in the
clnt_create, for both UDP and the TCP.  I implemented a non-blocking
connect, and it took my ls time down from 8m21s to 2m4s.  I'm still looking
into why the UDP stuff isn't timing out sooner.

>> Perhaps we should first test to see if a host is reachable at all before
>> we begin our rpc pings?

raven> Sigh!

raven> Will the fall out from the replicated server implementation it never
raven> end.

Despair not!  I'm sure we're on the home stretch, here!  ;)  I'll post a
patch for review when it's baked.

-Jeff
