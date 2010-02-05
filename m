From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: Transient Automount Problems in CentOS 5.3
Date: Fri, 5 Feb 2010 18:30:47 +0100
Message-ID: <201002051830.47709.carsten.aulbert@aei.mpg.de>
References: <4B6AFAD1.1070601@berkeley.edu>
	<201002050859.05400.carsten.aulbert@aei.mpg.de>
	<4B6C511E.9060207@berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B6C511E.9060207@berkeley.edu>
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
To: Jon Forrest <jlforrest@berkeley.edu>
Cc: autofs@linux.kernel.org

Hi Jon

On Friday 05 February 2010 18:10:54 Jon Forrest wrote:
> 
> This results in
> 
>   icmp_seq=2 Frag needed and DF set (mtu = 1500)
> 
> which is not what I expected. I wonder where the
> "mtu = 1500" is coming from. ifconfig on the interface
> of the source machine is definitely 9000 (I just
> reconfirmed). I also confirmed that jumbo frames
> are enabled both on the switch and on the storage
> server. They are.
> 
> For yuks, I tried lowering the packet
> size lower, and I found that I continued to see this
> error until the packet size was 1472. So, either
> ping is doing something I don't expect, or somebody
> is lying about jumbo frames being enabled.
> 

That sounds that one component is not allowing jumbo frames through.

> This is a 48 node cluster, so doing something like
> that is something I'd like to hold off on doing
> until I've exhausted everything else.

48 are easy, it starts to get interesting in the not too low 3 digit regime, 4 
digits are more fun ;)

What I would do next are the following routes (try both):

Route A:

Set MTU1500 everywhere and stress the system and look if the problems go away.

Route B:

(a) Directly link two nodes and try the ping again, if that does not work, 
there seems to be a problem with the nodes NICs.

(b) Directly link a node a the 7340, try the ping again, if it does not work 
but (a) did, the 7340 is acting up.

(c) Try the ping between two nodes with a single switch in-between and see if 
that works.

Basically, start at the simplest set-up and work your way up the complexity 
ladder, it's tedious but eventually you'll find the problem.

Cheers

Carsten
