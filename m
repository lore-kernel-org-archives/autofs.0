From: Michael Blandford <mlblandf@sedona.ch.intel.com>
Subject: Re: [RFC] rpc_ping and looong timeouts
Date: Tue, 08 Jun 2004 10:51:11 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40C5FC8F.5090509@sedona.intel.com>
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
	<16581.63097.282897.254922@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org, raven@themaw.net

Jeff Moyer wrote:

>I guess we could come full circle on this issue, and try to solve it at the
>rpc layer.
>
I like this solution.  It removes the dependency on icmp.

Michael

Disclaimer: The content of this message is my personal opinion only and 
although I am an employee of Intel, the statements I make here in no way 
represent Intel's position on the issue, nor am I authorized to speak on 
behalf of Intel on this matter.
