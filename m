From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Sat, 5 Jun 2004 22:18:55 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16578.32527.112071.411109@segfault.boston.redhat.com>
References: <16575.35426.918728.134817@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406040909310.8991@wombat.indigo.net.au>
	<16576.51269.311121.121046@segfault.boston.redhat.com>
	<16576.60526.394177.533027@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0406051003140.1643@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406051003140.1643@donald.themaw.net>
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

raven> On Fri, 4 Jun 2004, Jeff Moyer wrote:
>>
[snip]
>> One nit: icmp_ping_host takes a char * for the hostname, whereas
>> rpc_ping passes a const char *.  As such, we get a 'discards qualifier'
>> warning.  I didn't think it warrented converting the whole call chain to
>> consts, but if you're especially concerned about that, Ian, I'd be happy
>> to resubmit.
>> 

raven> I'll see if I can get rid of the warning in some simple way. If only
raven> as a clear indication it's what we intended to do.

raven> In fact I will be able to use this to make the umount smarter later
raven> some time.

Cool.
 
>> Comments?

raven> I've only had a brief look at the patch but it looks like good clean
raven> code.

raven> One small thing though.

raven> I understand you need to attribute Copyright to Redhat but don't you
raven> think it would be acceptable to add your name their as well?

Heh.  Well, I didn't write the ping code (only modified it to make the
timeouts finer granularity).  Lon Hohberger wrote it.  I'll be sure
to pass along your kudos (and suggestion).  ;)

-Jeff
