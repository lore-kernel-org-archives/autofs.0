From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Mon, 7 Jun 2004 14:44:30 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16580.46990.794712.901678@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<16576.60526.394177.533027@segfault.boston.redhat.com>
	<40C4B3FF.3060005@sedona.intel.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40C4B3FF.3060005@sedona.intel.com>
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
To: Michael Blandford <mlblandf@sedona.ch.intel.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] [RFC] rpc_ping and looong timeouts; Michael Blandford <mlblandf@sedona.ch.intel.com> adds:

mlblandf> Jeff Moyer wrote:
>> This patch simply implements an icmp ping (code shamelessly stolen from
>> clumanager), and does this before even attempting to do the rpc pings.
>> If the icmp ping works, then we continue as usual.  This takes care of
>> the host down case quite nicely:
>> 
>> 
>> 

mlblandf> Would this patch cause problems for those of us who have icmp
mlblandf> blocked?  If so, could we make it a run time option to
mlblandf> enable/disable?

Wow, you block icmp internally?  This would incur a timeout for every host
listed in your replicated server entry, and with Ian's patch, it would
incur a timeout for non-replicated servers, as well.  In fact, for the
non-replicated server case, I think it would give a false negative, failing
the mount even though the server is up.

Is this really how you have things configured?  NFS clients can't ping
their servers?

-Jeff
