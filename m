From: raven@themaw.net
Subject: Re: Mounting an NFS file system upon itself or something
 like that
Date: Sat, 13 Nov 2004 14:37:02 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0411131431270.9059@donald.themaw.net>
References: <1100090139.4310.32.camel@dyn059070.shef.ac.uk>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1100090139.4310.32.camel@dyn059070.shef.ac.uk>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Le Moigne <a.lemoigne@sheffield.ac.uk>
Cc: autofs@linux.kernel.org


To start with lets have the versions of everything.

kernel, patched or not, and autofs.

I believe that autofs should do a bind mount of the lical filesystem in 
this case.

On Wed, 10 Nov 2004, Alan Le Moigne wrote:

> Hi,
> 
> I am new to autofs and I hope you can help. Here's the problem: I am
> managing a Linux cluster working under Red Hat 9. I've got 21 nodes in
> the cluster but for the sake of the example, let's say I've got only 3
> called node2, node3 and node4. Each of them has its own hard disk and I
> want to distribute this partition to all the other nodes through NFS and
> autofs.
> 
> For example on node2, my data are stored in /data/node2. /data/node3 and
> /data/node4 are just mount points where I want to mount partitions from
> node3 and node4 respectively. On node3, I've got physical data in
> /data/node3 whereas /data/node2 and /data/node4 are just mount points
> and so on...
> 
> I am trying to mount the NFS file systems with autofs. My auto.master
> contains:
> 
> /data/ /etc/auto.data
> 
> and /etc/auto.data :
> 
> node2 -fstype=nfs,hard,intr,rsize=8192,wsize=8192
> 192.168.101.2:/data/node2
> node3 -fstype=nfs,hard,intr,rsize=8192,wsize=8192
> 192.168.101.3:/data/node3
> node4 -fstype=nfs,hard,intr,rsize=8192,wsize=8192
> 192.168.101.4:/data/node4
> 
> 
> If I use that on node2, /data/node3 and /data/node4 are mounted
> correctly but /data/node2 is empty i.e. the NFS file system isn't
> mounted upon itself. I think NFS allows this since when I use /etc/fstab
> only, without autofs, and mount /data/node2 manually, it works.
> 
> There is probably a way of doing that with multi-mount but I can't
> figure it out. The ideal case would be to be able to use the same
> auto.master and auto.data files on all the nodes so that I can put them
> in the slave image on the master node and all the slave nodes get them
> from there.
> 
> Any idea or comment is very welcome.
> 
> Alan.
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
