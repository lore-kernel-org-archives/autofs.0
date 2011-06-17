From: James Pearson <james-p@moving-picture.com>
Subject: Odd NIS map failure with mount point creation time in the
	future?
Date: Fri, 17 Jun 2011 15:12:17 +0100
Message-ID: <4DFB60C1.4080801@moving-picture.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org

I using CentOS 5 on a large number of boxes with a NIS indirect 
automount map.

I've been using the following syntax in /etc/auto.master:

/mntpoint    yp:custom.map

And this has worked fine for ages

Recently, I wanted to provide some custom local overrides to mount 
points in the NIS map, so I've changed /etc/auto.master to be:

/mntpoint    custom.map

and created a file called /etc/custom.map which contains something like:

host1    host:/disk1
+custom.map

i.e. include the NIS map after any local mount point settings

On most machines, this works fine - but on a number of machines, after a 
reboot, the mounts from the NIS map fail to mount - although the other 
mounts from /etc/custom.map mount fine.

One thing I noticed in common on all the machines with this problem is 
that datestamp on the automount mount point (/mntpoint) was in the 
future - by an hour or two. I guess the hardware clock is an hour or two 
ahead of the real time.

ntp runs on all these boxes - but starts after autofs - however if I 
change ntp to startup before autofs, then autofs works fine after a 
reboot ...

Any idea why autofs fails to read entries from the included NIS map when 
the creation date of the map mount point is in the future? - but works 
fine when the same NIS map is referenced directly from /etc/auto.master?

James Pearson
