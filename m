From: Jon Forrest <jlforrest@berkeley.edu>
Subject: Re: Transient Automount Problems in CentOS 5.3
Date: Fri, 05 Feb 2010 09:10:54 -0800
Message-ID: <4B6C511E.9060207@berkeley.edu>
References: <4B6AFAD1.1070601@berkeley.edu>
	<201002041757.18201.carsten.aulbert@aei.mpg.de>
	<4B6B0D61.1050605@berkeley.edu>
	<201002050859.05400.carsten.aulbert@aei.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <201002050859.05400.carsten.aulbert@aei.mpg.de>
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org

On 2/4/2010 11:59 PM, Carsten Aulbert wrote:

> (1) ping -s 8972 -Mdo<remote host>
> (try different payload sizes and remember that there might be some overhead in
> the switches needed)

This results in

  icmp_seq=2 Frag needed and DF set (mtu = 1500)

which is not what I expected. I wonder where the
"mtu = 1500" is coming from. ifconfig on the interface
of the source machine is definitely 9000 (I just
reconfirmed). I also confirmed that jumbo frames
are enabled both on the switch and on the storage
server. They are.

For yuks, I tried lowering the packet
size lower, and I found that I continued to see this
error until the packet size was 1472. So, either
ping is doing something I don't expect, or somebody
is lying about jumbo frames being enabled.

> (2) Use netperf between different nodes and see if the performance is not
> drastically reduced with large jumbo frames.

The funny thing is that performance seems to be fine,
although that's purely subjective. I'll try the netperf
test to see what the numbers really are.

> Would it be possible for you to recompile the kernel with the same settings
> and enable timings in printk lines (under kernel hacking)? That might help,
> but might be some work to get working.

This is a 48 node cluster, so doing something like
that is something I'd like to hold off on doing
until I've exhausted everything else.

I appreciate your suggestions.

-- 
Jon Forrest
Research Computing Support
College of Chemistry
173 Tan Hall
University of California Berkeley
Berkeley, CA
94720-1460
510-643-1032
jlforrest@berkeley.edu
