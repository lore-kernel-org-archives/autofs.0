From: Ian Kent <raven@themaw.net>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Wed, 9 Jun 2004 09:13:33 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406090905580.11930@wombat.indigo.net.au>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<40C4B3FF.3060005@sedona.intel.com><40C5E4A0.10405@sedona.intel.com>
	<Pine.LNX.4.58.0406090009180.22861@donald.themaw.net>
	<16581.59576.649866.64681@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406090030140.22861@donald.themaw.net>
	<16581.63097.282897.254922@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16581.63097.282897.254922@segfault.boston.redhat.com>
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

On Tue, 8 Jun 2004, Jeff Moyer wrote:

> 
> I guess we could come full circle on this issue, and try to solve it at the
> rpc layer.
> 
> There are 2 issues here.  First, for UDP, the portmapper lookup has a
> static timeout of 60 seconds, and that is not tunable (afaict).  For TCP,
> it takes a long time to timout a connect call.  I've already written code
> to address the TCP connect issue.
> 
> As it happens, the UDP issue is not insurmountable.  We can simply write
> code which queries the portmapper ourselves.  Here is the excerpt from
> pmap_getport, edited to show only the UDP stuff:
> 
> static const struct timeval tottimeout =  {60, 0};
> 
> u_short
> pmap_getport (address, program, version, protocol)
>      struct sockaddr_in *address;
>      u_long program;
>      u_long version;
>      u_int protocol;
> {
>   address->sin_port = htons (PMAPPORT);
>   client = INTUSE(clntudp_bufcreate) (address, PMAPPROG, PMAPVERS, timeout,
> 					&socket, RPCSMALLMSGSIZE,
> 					RPCSMALLMSGSIZE);
>   if (client != (CLIENT *) NULL)
>     {
>       struct rpc_createerr *ce = &get_rpc_createerr ();
>       parms.pm_prog = program;
>       parms.pm_vers = version;
>       parms.pm_prot = protocol;
>       parms.pm_port = 0;	/* not needed or used */
>       if (CLNT_CALL (client, PMAPPROC_GETPORT, (xdrproc_t)INTUSE(xdr_pmap),
> 		     (caddr_t)&parms, (xdrproc_t)INTUSE(xdr_u_short),
> 		     (caddr_t)&port, tottimeout) != RPC_SUCCESS)
> 
> clntudp_bufcreate is simply clnt_create.  In this case, we fill in
> address->sin_port, so the clnt_create call will not do a pmap_lookup.
> 
> Next we do a clnt_call, passing in a timeout.  Note the 60 second timeout
> above.  There, you're done.  So, if we add the TCP case back into the code,
> we do the nonblocking connect, and then do that clnt_create with this
> socket.
> 
> Ian, I think this is do-able, and not entirely disgusting.  What's more is
> that we can get rid of the ping.c file.  ;)  I was never really happy with
> using a separate protocol anyway.  The more I think about this, the more I
> like it.

I'm in.

Doing everything using the method as we are going to use for NFS is 
definutely the way to go if we can.

What have we got to work with in terms of patches/code examples (besides 
above). What would you like/have time to do and what can I do. We don't 
want to duplicate efforts here.

> 
> Comments?  If you like it, I'll set aside some time to implement it.

Jeff's hogging all the fun.

Seriously though, whatever you do is a be a big help.
Thanks Jeff.

Ian
