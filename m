From: Jon Forrest <jlforrest@berkeley.edu>
Subject: Re: Transient Automount Problems in CentOS 5.3
Date: Thu, 04 Feb 2010 10:09:37 -0800
Message-ID: <4B6B0D61.1050605@berkeley.edu>
References: <4B6AFAD1.1070601@berkeley.edu>
	<201002041757.18201.carsten.aulbert@aei.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <201002041757.18201.carsten.aulbert@aei.mpg.de>
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

On 2/4/2010 8:57 AM, Carsten Aulbert wrote:

> Have you ramped up the number of NFS daemons, backlog stuff etc on the solaris
> box (/etc/default/nfs) and is the Solaris NIC running with jumbo frames as
> well (and the switch is *really* capable of doing it (please test with ping).

First of all, the Sun 7310 is one of those servers
that you "can't" login to. You manage it only
via a Web interface.

I've set the server to use 500 NFS server threads.
Is it necessary to go above that?

Both the Sun server, the switch, and all the compute nodes
in the cluster claim to support jumbo frames.
Turning them off is something that I could
do, but I'd have to do it globally because this is
a per interface settings. There's no
way I can think of that would allow me to
keep jumbo frames on on only certain nodes
so that I could run a controlled experiment.

Running ping shows no problems.

I've thought it might be useful to turn off
automounting on a few of the cluster nodes to
see what happens.

One additional thing I've discovered is that the
compute nodes all are showing a bunch of this
error message via dmesg:

eth0: too many iterations (6) in nv_nic_irq.

I've looked this up and it might have something
to do with the problem. The trouble is that I can't
see when these error messages are generated so
I can't try to correlate them with the autofs
problem.

I'm grasping at straws here.

I appreciate any addition suggestions.

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
