From: "Peter C. Norton" <spacey@lenin.net>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Mon, 7 Jun 2004 20:17:07 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040608031707.GE11008@lenin.net>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<40C4B3FF.3060005@sedona.intel.com>
	<Pine.LNX.4.58.0406080855390.17060@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406080855390.17060@wombat.indigo.net.au>
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
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Tue, Jun 08, 2004 at 08:56:34AM +0800, Ian Kent wrote:
> On Mon, 7 Jun 2004, Michael Blandford wrote:
> 
> > Jeff Moyer wrote:
> > 
> > >This patch simply implements an icmp ping (code shamelessly stolen from
> > >clumanager), and does this before even attempting to do the rpc pings.  If
> > >the icmp ping works, then we continue as usual.  This takes care of the
> > >host down case quite nicely:
> > >
> > >  
> > >
> > 
> > Would this patch cause problems for those of us who have icmp blocked?  
> > If so, could we make it a run time option to enable/disable?
> > 
> 
> So you have ICMP blocked but allow NFS?

Its possible that some sites will have killed ping and pong because of
various viruses in the past, but allow everything else.

-Peter

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.
