From: Alan Le Moigne <a.lemoigne@sheffield.ac.uk>
Subject: Re: Mounting an NFS file system upon itself or something
	like that
Date: Sat, 13 Nov 2004 16:55:01 +0000
Message-ID: <1100364900.41963c6501643@webmail.shef.ac.uk>
References: <1100090139.4310.32.camel@dyn059070.shef.ac.uk>
	<41927D13.2000402@moving-picture.com>
	<Pine.LNX.4.58.0411131439060.9059@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411131439060.9059@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org, James Pearson <james-p@moving-picture.com>


> > 
> > > Hi,
> > > 
> > > I am new to autofs and I hope you can help. Here's the problem: I am
> > > managing a Linux cluster working under Red Hat 9. I've got 21 nodes in
> > > the cluster but for the sake of the example, let's say I've got only 3
> > > called node2, node3 and node4. Each of them has its own hard disk and I
> > > want to distribute this partition to all the other nodes through NFS and
> > > autofs.
> > > 
> > > For example on node2, my data are stored in /data/node2. /data/node3 and
> > > /data/node4 are just mount points where I want to mount partitions from
> > > node3 and node4 respectively. On node3, I've got physical data in
> > > /data/node3 whereas /data/node2 and /data/node4 are just mount points
> > > and so on...
> > > 
> > > I am trying to mount the NFS file systems with autofs. My auto.master
> > > contains:
> > > 
> > > /data/ /etc/auto.data
> > > 
> > > and /etc/auto.data :
> > > 
> > > node2 -fstype=nfs,hard,intr,rsize=8192,wsize=8192
> > > 192.168.101.2:/data/node2
> > > node3 -fstype=nfs,hard,intr,rsize=8192,wsize=8192
> > > 192.168.101.3:/data/node3
> > > node4 -fstype=nfs,hard,intr,rsize=8192,wsize=8192
> > > 192.168.101.4:/data/node4
> > > 
> > > 
> > > If I use that on node2, /data/node3 and /data/node4 are mounted
> > > correctly but /data/node2 is empty i.e. the NFS file system isn't
> > > mounted upon itself. I think NFS allows this since when I use /etc/fstab
> > > only, without autofs, and mount /data/node2 manually, it works.
> > > 
> > > There is probably a way of doing that with multi-mount but I can't
> > > figure it out. The ideal case would be to be able to use the same
> > > auto.master and auto.data files on all the nodes so that I can put them
> > > in the slave image on the master node and all the slave nodes get them
> > > from there.
> > > 
> > > Any idea or comment is very welcome.
> > 
> > I don't think you can mix local mounts and automounts in that way - the 
> > way I would do it (in fact, this is the way I do it):
> > 
> > mount the local disks as /nodeX
> > 
> > The /etc/auto.data file contains something like:
> > 
> > node2 [options] 192.168.101.2:/node2
> > node3 [options] 192.168.101.3:/node3
> > node4 [options] 192.168.101.4:/node4
> > 
> > on machine node2, /data/node2 will be a bind mount (not over NFS) of 
> > /node2 - all the other /data/nodeX mounts will be over NFS.
> 
> Yep. Thanks James. I think my previous post was wrong.
> 
> That's the way we do it as well.
> 
> We mount stuff like
> 
> /local/dsk/voln
> 
> or
> 
> /local/dsk/home
> 
> and direct maps with
> 
> /nfs/<server>/... -> <server>:/local/dsk/...
> 
> and indirect mounts (under /home) with
> 
> <server> -> <server>:/local/dsk/home
> 
> Ian
> 
> 

Thanks a lot James and Ian for your answers. I have now found a solution to the
problem thanks to James' post. I am not sure I fully understand what Ian means
but for the record, here's my solution:

I mount the local disk as /node (and not /nodeX since this isn't necessary). And
the /etc/auto.data file contains:
node2 -fstype=nfs,... 192.168.101.2:/node
node3 -fstype=nfs,... 192.168.101.3:/node
node4 -fstype=nfs,... 192.168.101.4:/node

That is I am mounting everything through NFS even when the disk is local. For
the purists, there might be some issue of performance by doing it that way but
I don't care too much as long as it's working. My main concern is that all the
nodes have exactly the same /etc/auto.data and the same partitions /node for
the local disk and /data/node2, /data/node3,... as mount points. That way I can
put everything in a single slave image on the master node from where the slave
nodes  find their configuration when they boot up.

Alan.
