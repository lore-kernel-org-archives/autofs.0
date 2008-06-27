From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: automount in status D
Date: Fri, 27 Jun 2008 10:05:45 +0200
Message-ID: <48649F59.2050206@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi all,

we have a weird problem here and I fear I need to reboot the box
(painful, many users involved), but maybe there is a way out:

I'm automounting many nodes and usually everything seems to work nicely.
However, I'm seeing this here right now:

# ps aux|grep auto.node
root      2022  0.0  0.0  30304  1240 ?        Ds   Jun19   0:21 /usr/sbin/automount --pid-file=/var/run/autofs/_atlas_node.pid --timeout=5 /atlas/node yp auto.node_local
root     11489  0.0  0.0  30516  1108 ?        D    Jun26   0:00 /usr/sbin/automount --pid-file=/var/run/autofs/_atlas_node.pid --timeout=5 /atlas/node yp auto.node_local
root     28610  0.0  0.0   2736   656 pts/31   S+   10:03   0:00 grep auto.node


As you can see there are two automounter processes in D (or Ds) state sitting there for the same mount point (the PID-file contains 2022). 

My questions:

Any idea how this happened?

Any idea how to get this resolved (possibly without a reboot)?

TIA

Carsten

PS: 
# ypcat auto.node_local
-fstype=nfs,nfsvers=3,soft,intr,rsize=32768,wsize=32768,tcp       &:/local
