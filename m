From: Vincent Liggio <vince@blueskystudios.com>
Subject: Re: Before I start carving wheels....
Date: Thu, 24 Feb 2011 15:11:07 -0500
Message-ID: <4D66BB5B.4040808@blueskystudios.com>
References: <mj849qulir49bmajiif61sp3.1298416168018@email.android.com>	
	<alpine.LFD.1.10.1102222203150.7886@gardencity.blueskystudios.com>	
	<x497hcqj0jg.fsf@segfault.boston.devel.redhat.com>	
	<4D6521B0.2050608@blueskystudios.com>
	<1298517415.2916.27.camel@perseus>	
	<alpine.LFD.1.10.1102232319330.12273@gardencity.blueskystudios.com>	
	<1298529776.2916.96.camel@perseus>
	<1298544135.3058.63.camel@perseus>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1298544135.3058.63.camel@perseus>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Lee Damon <nomad@ee.washington.edu>, am-utils@fsl.cs.sunysb.edu

On 02/24/2011 05:42 AM, Ian Kent wrote:
>
> It looks like amd should work with autofs protocol version v4.
> You should also try "modprobe autofs4" before starting amd and see what
> happens.

We tried that before, and this is what happens:

Feb 24 14:40:39 canton_64 amd[1504]: initializing amd.conf map amd.net 
of type nis
Feb 24 14:40:39 canton_64 amd[1504]: amd.net mounted fstype toplvl on /net
Feb 24 14:40:39 canton_64 amd[1504]: autofs: using protocol version 5
Feb 24 14:40:39 canton_64 amd[1504]: /net set to never timeout

Then we change to a directory and we get:

Feb 24 14:40:57 canton_64 amd[1504]: Unknown autofs packet type 3

lsmod
Module                  Size  Used by
autofs4                22687  13
ipv6                  278339  24
ppdev                   7925  0
parport_pc             21081  0
parport                31509  2 ppdev,parport_pc
e1000                  92062  0
i2c_piix4              11998  0
shpchp                 29568  0
i2c_core               26926  1 i2c_piix4
mptspi                 14609  3
mptscsih               28444  1 mptspi
mptbase                74728  2 mptspi,mptscsih
scsi_transport_spi     22211  1 mptspi
