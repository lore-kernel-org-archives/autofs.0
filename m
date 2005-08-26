From: robsims@robsims.com (Rob Sims)
Subject: Re: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
	usage problems
Date: Fri, 26 Aug 2005 10:14:54 -0600
Message-ID: <20050826161454.GA3465@robsims.com>
References: <20050825221428.GC1867@robsims.com>
	<Pine.LNX.4.58.0508261141230.2586@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508261141230.2586@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

On Fri, Aug 26, 2005 at 11:44:21AM +0800, Ian Kent wrote:
> On Thu, 25 Aug 2005, Rob Sims wrote:
 
> > > THE PROBLEM DESCRIPTION:

> > > Autofs hangs and refuses to mount any directories for a period of time
> > > after cd'ing to /net/<Netapp>/vol/vol[0-3] and waiting a while.
> > > The only way to clear this is to reboot the client.

> > I didn't see a resolution to this in the archive - was it resolved?
> > How?
 
> This has come up several times and as far as I know we can resolve or 
> work around these problems.
 
> If you have a problem then we need to establish versions and symptoms to 
> know what needs to be done to resolve it.
 
What we're seeing is very similar to the original poster's description.
Netapp, 2.4 kernel, hierarchical mounts like:
vol0
vol0/a
vol0/b
vol1
vol1/c
etc.

The problem seems to have disappeared when we dropped the number of
exports to under 32.  The log indicates that vol2 couldn't be unmounted
because it was busy.  My guess is that 33+ unmount requests were issued
for the children, at least one failed due to lack of resources, and then
the parent unmount failed because of the failed child unmount.  The
parent directory is then mounted mupltiple times (one extra per
expiration?)


Relevant log messages:
Aug 25 06:27:35 mvweb automount[18208]: running expiration on path /net/goodserver
Aug 25 06:27:36 mvweb automount[18208]: expired /net/goodserver
Aug 25 06:27:36 mvweb automount[18218]: running expiration on path /net/netapp
Aug 25 06:27:36 mvweb automount[18218]: >> umount: /net/netapp/vol/vol2: device is busy
Aug 25 06:27:52 mvweb last message repeated 10919 times
Aug 25 06:27:52 mvweb automount[18218]: lookup(program): looking up netapp
Aug 25 06:27:52 mvweb automount[18218]: lookup(program): netapp -> -fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192,async  ^I/vol/vol0 netapp:/vol/vol0  ^I/vol/vol0/mounta netapp:/vol/vol0/mounta  ^I/vol/vol0/restricted netapp:/vol/vol0/restricted  ^I/vol/vol0/mountb netapp:/vol/vol0/mountb  ^I/vol/vol0/mountc netapp:/vol/vol0/mountc  ^I/vol/vol0/mountd netapp:/vol/vol0/mountd  ^I/vol/vol1 netapp:/vol/vol1  ^I/vol/vol1/backb netapp:/vol/vol1/backb  ^I/vol/vol1/mounte netapp:/vol/vol1/mounte  ^I/vol/vol1/mountf netapp:/vol/vol1/mountf  ^I/vol/vol1/mountg netapp:/vol/vol1/mountg  ^I/vol/vol1/mounth netapp:/vol/vol1/mounth  ^I/vol/vol1/mounti netapp:/vol/vol1/mounti  ^I/vol/vol1/mountj netapp:/vol/vol1/mountj  ^I/vol/vol1/mountk netapp:/vol/vol1/mountk  ^I/vol/vol1/mountl netapp:/vol/vol1/mountl  ^I/vol/vol1/mountm netapp:/vol/vol1/mountm  ^I/vol/vol1/mountn netapp:/vol/vo
 l1/mountn  ^I/vol/vol2 netapp:/vol/vol2  ^I/vol/vol2/mounto$ netapp:/vol/vol2/mounto$  ^I!
 /vol/
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): expanded entry: -fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192,async  ^I/vol/vol0 netapp:/vol/vol0  ^I/vol/vol0/mounta netapp:/vol/vol0/mounta  ^I/vol/vol0/restricted netapp:/vol/vol0/restricted  ^I/vol/vol0/mountb netapp:/vol/vol0/mountb  ^I/vol/vol0/mountc netapp:/vol/vol0/mountc  ^I/vol/vol0/mountd netapp:/vol/vol0/mountd  ^I/vol/vol1 netapp:/vol/vol1  ^I/vol/vol1/backb netapp:/vol/vol1/backb  ^I/vol/vol1/mounte netapp:/vol/vol1/mounte  ^I/vol/vol1/mountf netapp:/vol/vol1/mountf  ^I/vol/vol1/mountg netapp:/vol/vol1/mountg  ^I/vol/vol1/mounth netapp:/vol/vol1/mounth  ^I/vol/vol1/mounti netapp:/vol/vol1/mounti  ^I/vol/vol1/mountj netapp:/vol/vol1/mountj  ^I/vol/vol1/mountk netapp:/vol/vol1/mountk  ^I/vol/vol1/mountl netapp:/vol/vol1/mountl  ^I/vol/vol1/mountm netapp:/vol/vol1/mountm  ^I/vol/vol1/mountn netapp:/vol/v
 ol1/mountn  ^I/vol/vol2 netapp:/vol/vol2  ^I/vol/vol2/mounto netapp:/vol/vol2/mounto  ^I/!
 vol/vo
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): dequote("fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192,async") -> fstype=nfs,hard,intr,nodev,nosuid,nonstric
t,rsize=8192,wsize=8192,async
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): gathered options: fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192,async
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): dequote("/vol/vol0") -> /vol/vol0
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): dequote("netapp:/vol/vol0") -> netapp:/vol/vol0
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): multimount: netapp:/vol/vol0 on /vol/vol0 with options fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192,async
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): mounting root /net, mountpoint netapp/vol/vol0, what netapp:/vol/vol0, fstype nfs, options hard,intr,nodev,nosuid,rsize=8192,w
size=8192,async
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs):  root=/net name=netapp/vol/vol0 what=netapp:/vol/vol0, fstype=nfs, options=hard,intr,nodev,nosuid,rsize=8192,wsize=8192,async
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): nfs options="hard,intr,nodev,nosuid,rsize=8192,wsize=8192,async", nosymlink=0
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): calling mkdir_path /net/netapp/vol/vol0
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): calling mount -t nfs -s -o hard,intr,nodev,nosuid,rsize=8192,wsize=8192,async netapp:/vol/vol0 /net/netapp/vol/vol0
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): mounted netapp:/vol/vol0 on /net/netapp/vol/vol0
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): dequote("/vol/vol0/mounta") -> /vol/vol0/mounta
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): dequote("netapp:/vol/vol0/mounta") -> netapp:/vol/vol0/mounta
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): multimount: netapp:/vol/vol0/mounta on /vol/vol0/mounta with options fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize
=8192,async
Aug 25 06:27:52 mvweb automount[18218]: parse(sun): mounting root /net, mountpoint netapp/vol/vol0/mounta, what netapp:/vol/vol0/mounta, fstype nfs, options hard,intr,nodev,nosuid,
rsize=8192,wsize=8192,async
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs):  root=/net name=netapp/vol/vol0/mounta what=netapp:/vol/vol0/mounta, fstype=nfs, options=hard,intr,nodev,nosuid,rsize=8192,wsize
=8192,async
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): nfs options="hard,intr,nodev,nosuid,rsize=8192,wsize=8192,async", nosymlink=0
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): calling mkdir_path /net/netapp/vol/vol0/mounta
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): calling mount -t nfs -s -o hard,intr,nodev,nosuid,rsize=8192,wsize=8192,async netapp:/vol/vol0/mounta /net/netapp/vol/vol0/back
a
Aug 25 06:27:52 mvweb automount[18218]: mount(nfs): mounted netapp:/vol/vol0/mounta on /net/netapp/vol/vol0/mounta
...

-- 
Rob
