From: raven@themaw.net
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Wed, 9 Jun 2004 00:15:59 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406090009180.22861@donald.themaw.net>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<40C4B3FF.3060005@sedona.intel.com><40C5E4A0.10405@sedona.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40C5E4A0.10405@sedona.intel.com>
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
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org

On Tue, 8 Jun 2004, Michael Blandford wrote:

> Jeff Moyer wrote:
> 
> >mlblandf> Would this patch cause problems for those of us who have icmp
> >mlblandf> blocked?  If so, could we make it a run time option to
> >mlblandf> enable/disable?
> >
> >Wow, you block icmp internally?  This would incur a timeout for every host
> >listed in your replicated server entry, and with Ian's patch, it would
> >incur a timeout for non-replicated servers, as well.  In fact, for the
> >non-replicated server case, I think it would give a false negative, failing
> >the mount even though the server is up.
> >
> >Is this really how you have things configured?  NFS clients can't ping
> >their servers?
> >  
> >
> 
> In a large environment it wouldn't be uncommon to have NFS mounts that 
> span across a WAN.  Using NFS over TCP seems to make the most sense in 
> that situation.
> 
> As packets traverse the WAN, there may be routers that block icmp.  This 
> is the type of situation where replicated server would make the most 
> sense - find the fastest server.
>

I was thinking that we could make disabling ICMP ping a configure option.
What do you think?

Still, I can't see why an internal WAN would block ICMP. It's needed for 
proper operation of your net.

If your talking about NFS over the public network you really should be 
using a VPN. In which case you don't need to (and probably shouldn't) 
block ICMP.

Ian
