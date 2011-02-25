From: Ian Kent <raven@themaw.net>
Subject: Re: Before I start carving wheels....
Date: Fri, 25 Feb 2011 11:19:34 +0800
Message-ID: <1298603974.3439.48.camel@perseus>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>
	<1298529776.2916.96.camel@perseus> <1298544135.3058.63.camel@perseus>
	<4D66BB5B.4040808@blueskystudios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=AdZqYcVTVfKuFxcL7auXMwa25Gc=;
	b=nv/ccF+KCsoWt+RHXZWI1W+jvmCK0+eT0oB/BUr1BLDCQh7AoyFCZJ5LEl++xmAv0ZHjhnDEROiSjd59ZotI9pOFdTY734C2G/a/EoG6epSilBHDAWPrivck7b/Tsh7RJ/aiAmow1/YqHe0I4CEGeyQA8nqJg8Verhg/80NH2kc=
In-Reply-To: <4D66BB5B.4040808@blueskystudios.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Vincent Liggio <vince@blueskystudios.com>
Cc: autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On Thu, 2011-02-24 at 15:11 -0500, Vincent Liggio wrote:
> On 02/24/2011 05:42 AM, Ian Kent wrote:
> >
> > It looks like amd should work with autofs protocol version v4.
> > You should also try "modprobe autofs4" before starting amd and see what
> > happens.
> 
> We tried that before, and this is what happens:
> 
> Feb 24 14:40:39 canton_64 amd[1504]: initializing amd.conf map amd.net 
> of type nis
> Feb 24 14:40:39 canton_64 amd[1504]: amd.net mounted fstype toplvl on /net
> Feb 24 14:40:39 canton_64 amd[1504]: autofs: using protocol version 5

This is wrong, amd hasn't used the correct mount options or I'm not
parsing the options correctly. Not sure that I am parsing the options
incorrectly since autofs version 4 needs to use the version 4 protocol
and it seems to be able to request that OK.

> Feb 24 14:40:39 canton_64 amd[1504]: /net set to never timeout
> 
> Then we change to a directory and we get:
> 
> Feb 24 14:40:57 canton_64 amd[1504]: Unknown autofs packet type 3
> 
> lsmod
> Module                  Size  Used by
> autofs4                22687  13
> ipv6                  278339  24
> ppdev                   7925  0
> parport_pc             21081  0
> parport                31509  2 ppdev,parport_pc
> e1000                  92062  0
> i2c_piix4              11998  0
> shpchp                 29568  0
> i2c_core               26926  1 i2c_piix4
> mptspi                 14609  3
> mptscsih               28444  1 mptspi
> mptbase                74728  2 mptspi,mptscsih
> scsi_transport_spi     22211  1 mptspi
> 
