From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: Transient Automount Problems in CentOS 5.3
Date: Thu, 4 Feb 2010 17:57:17 +0100
Message-ID: <201002041757.18201.carsten.aulbert@aei.mpg.de>
References: <4B6AFAD1.1070601@berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4B6AFAD1.1070601@berkeley.edu>
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
To: autofs@linux.kernel.org

Hi Jon,

On Thursday 04 February 2010 17:50:25 Jon Forrest wrote:
> I have a new cluster running CentOS 5.3.
> The cluster uses a Sun 7310 storage server
> that provides NFS service over a private
> 1Gb/s ethernet with 9K jumbo frames to the
> cluster.
> 
> We've noticed that a number of the compute
> nodes sometimes generate the
> 
> automount[15023]: umount_autofs_indirect: ask umount returned busy /home
> 
> message. When this happens the program running on the
> node dies. This has happened between 10 and 20 times.
> We're not sure what's going on on a node when this
> happens. Most of the time everything is fine and
> the home directories are automounted without problem.

Have you ramped up the number of NFS daemons, backlog stuff etc on the solaris 
box (/etc/default/nfs) and is the Solaris NIC running with jumbo frames as 
well (and the switch is *really* capable of doing it (please test with ping).

Cheers

Carsten
