From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Tue, 8 Jun 2004 13:25:13 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16581.63097.282897.254922@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<16576.60526.394177.533027@segfault.boston.redhat.com>
	<40C4B3FF.3060005@sedona.intel.com>
	<16580.46990.794712.901678@segfault.boston.redhat.com>
	<40C5E4A0.10405@sedona.intel.com>
	<Pine.LNX.4.58.0406090009180.22861@donald.themaw.net>
	<16581.59576.649866.64681@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406090030140.22861@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406090030140.22861@donald.themaw.net>
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
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; raven@themaw.net adds:

raven> On Tue, 8 Jun 2004, Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts;
>> raven@themaw.net adds:
>> 
raven> On Tue, 8 Jun 2004, Michael Blandford wrote:
>> >> Jeff Moyer wrote:
>> >> 
>> >> >mlblandf> Would this patch cause problems for those of us who have
>> icmp >> >mlblandf> blocked?  If so, could we make it a run time option
>> to >> >mlblandf> enable/disable?
>> >> >
>> >> >Wow, you block icmp internally?  This would incur a timeout for
>> every >> host >listed in your replicated server entry, and with Ian's
>> patch, it >> would >incur a timeout for non-replicated servers, as well.
>> In fact, >> for the >non-replicated server case, I think it would give a
>> false >> negative, failing >the mount even though the server is up.
>> >> >
>> >> >Is this really how you have things configured?  NFS clients can't
>> ping >> >their servers?
>> >> >  
>> >> >
>> >> 
>> >> In a large environment it wouldn't be uncommon to have NFS mounts
>> that >> span across a WAN.  Using NFS over TCP seems to make the most
>> sense in >> that situation.
>> >> 
>> >> As packets traverse the WAN, there may be routers that block icmp.
>> This >> is the type of situation where replicated server would make the
>> most >> sense - find the fastest server.
>> >> 
>> 
raven> I was thinking that we could make disabling ICMP ping a configure
raven> option.  What do you think?
>> Well, if it's not hard to do...

raven> Should be fairly straight forward.  The code sections are small and
raven> easily identified.

raven> Of course it would be neccessary to make an SRPM from the tarball,
raven> install it and edit the configure statement, then rebuild.

Wow, I misread that initially.  I was thinking of a run-time configuration.
I'm not sure I like the idea of a configure option, as it just makes
support that much more difficult.

I guess we could come full circle on this issue, and try to solve it at the
rpc layer.

There are 2 issues here.  First, for UDP, the portmapper lookup has a
static timeout of 60 seconds, and that is not tunable (afaict).  For TCP,
it takes a long time to timout a connect call.  I've already written code
to address the TCP connect issue.

As it happens, the UDP issue is not insurmountable.  We can simply write
code which queries the portmapper ourselves.  Here is the excerpt from
pmap_getport, edited to show only the UDP stuff:

static const struct timeval tottimeout =  {60, 0};

u_short
pmap_getport (address, program, version, protocol)
     struct sockaddr_in *address;
     u_long program;
     u_long version;
     u_int protocol;
{
  address->sin_port = htons (PMAPPORT);
  client = INTUSE(clntudp_bufcreate) (address, PMAPPROG, PMAPVERS, timeout,
					&socket, RPCSMALLMSGSIZE,
					RPCSMALLMSGSIZE);
  if (client != (CLIENT *) NULL)
    {
      struct rpc_createerr *ce = &get_rpc_createerr ();
      parms.pm_prog = program;
      parms.pm_vers = version;
      parms.pm_prot = protocol;
      parms.pm_port = 0;	/* not needed or used */
      if (CLNT_CALL (client, PMAPPROC_GETPORT, (xdrproc_t)INTUSE(xdr_pmap),
		     (caddr_t)&parms, (xdrproc_t)INTUSE(xdr_u_short),
		     (caddr_t)&port, tottimeout) != RPC_SUCCESS)

clntudp_bufcreate is simply clnt_create.  In this case, we fill in
address->sin_port, so the clnt_create call will not do a pmap_lookup.

Next we do a clnt_call, passing in a timeout.  Note the 60 second timeout
above.  There, you're done.  So, if we add the TCP case back into the code,
we do the nonblocking connect, and then do that clnt_create with this
socket.

Ian, I think this is do-able, and not entirely disgusting.  What's more is
that we can get rid of the ping.c file.  ;)  I was never really happy with
using a separate protocol anyway.  The more I think about this, the more I
like it.

Comments?  If you like it, I'll set aside some time to implement it.

-Jeff
