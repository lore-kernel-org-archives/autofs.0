From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Tue, 08 Jun 2004 09:09:04 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40C5E4A0.10405@sedona.intel.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<16576.60526.394177.533027@segfault.boston.redhat.com>
	<40C4B3FF.3060005@sedona.intel.com>
	<16580.46990.794712.901678@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16580.46990.794712.901678@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Jeff Moyer wrote:

>mlblandf> Would this patch cause problems for those of us who have icmp
>mlblandf> blocked?  If so, could we make it a run time option to
>mlblandf> enable/disable?
>
>Wow, you block icmp internally?  This would incur a timeout for every host
>listed in your replicated server entry, and with Ian's patch, it would
>incur a timeout for non-replicated servers, as well.  In fact, for the
>non-replicated server case, I think it would give a false negative, failing
>the mount even though the server is up.
>
>Is this really how you have things configured?  NFS clients can't ping
>their servers?
>  
>

In a large environment it wouldn't be uncommon to have NFS mounts that 
span across a WAN.  Using NFS over TCP seems to make the most sense in 
that situation.

As packets traverse the WAN, there may be routers that block icmp.  This 
is the type of situation where replicated server would make the most 
sense - find the fastest server.


Michael

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
