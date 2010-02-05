From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: Transient Automount Problems in CentOS 5.3
Date: Fri, 5 Feb 2010 08:59:05 +0100
Message-ID: <201002050859.05400.carsten.aulbert@aei.mpg.de>
References: <4B6AFAD1.1070601@berkeley.edu>
	<201002041757.18201.carsten.aulbert@aei.mpg.de>
	<4B6B0D61.1050605@berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B6B0D61.1050605@berkeley.edu>
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

Hi Jon,

On Thursday 04 February 2010 19:09:37 Jon Forrest wrote:
> 
> First of all, the Sun 7310 is one of those servers
> that you "can't" login to. You manage it only
> via a Web interface.
> 
OK, sorry, not had such a beast under my fingers yet ;)

> I've set the server to use 500 NFS server threads.
> Is it necessary to go above that?
> 

That should be fine.

> Both the Sun server, the switch, and all the compute nodes
> in the cluster claim to support jumbo frames.

That's why I'm asking. We've had some network components (e.g. HP) which did 
support 9k Jumbo frames, however going beyond 3-4.5k caused such a severe 
performance drop that it was not advisable. What I would do to make certain 
this is not a problem:

(1) ping -s 8972 -Mdo <remote host>
(try different payload sizes and remember that there might be some overhead in 
the switches needed)
(2) Use netperf between different nodes and see if the performance is not 
drastically reduced with large jumbo frames.

> Turning them off is something that I could
> do, but I'd have to do it globally because this is
> a per interface settings. There's no
> way I can think of that would allow me to
> keep jumbo frames on on only certain nodes
> so that I could run a controlled experiment.
> 

If above's stuff is working, there should be no need.

> 
> I've looked this up and it might have something
> to do with the problem. The trouble is that I can't
> see when these error messages are generated so
> I can't try to correlate them with the autofs
> problem.

Would it be possible for you to recompile the kernel with the same settings 
and enable timings in printk lines (under kernel hacking)? That might help, 
but might be some work to get working.

Cheers

Carsten
