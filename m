From: mmarion@qualcomm.com
Subject: Re: Server IP address change screws up active mounts
Date: Mon, 17 May 2004 13:11:05 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200405172011.i4HKB5bv007009@miguelito.qualcomm.com>
References: <200405132140.i4DLeg1s019737@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200405132140.i4DLeg1s019737@jetcar.spd.analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On 13 May, David Meleedy wrote:

> One question I had for you guys happened to us when we were moving
> our subnets to an internal 10. net.  We were using autofs version 3
> on redhat 8, and I haven't had a chance to test this with version 4
> yet, but the problem might still exist.

It still exists in autofs4 because, like Dennis said, it's really a mount/nfs
issue, not autofs.  If you run a mount -t nfs you'll note that the IP of the
server is stored in the mount into.

It's ugly, but one fix I've found to clear these up is to temporarily setup an
aliased ethernet entry with the IP of the server and netmask 255.255.255.255
(so you don't lose contact with a whole network), umount the mount, then shut
down that aliased ethernet entry, and let automounter remount the path on the
hosts' new ip.  This is on each client btw.

i.e. if the host was 10.0.0.10 and is now 10.0.1.10, mount will show something
like:
myhost:/some/path on /some/path type nfs
(rw,noquota,addr=10.0.0.10)

do something like:
ifconfig eth0:1 inet 10.0.0.10 netmask 255.255.255.255 up
umount /some/path
ifconfig eth0:1 down
ls /some/path    so that automount remounts it on new host ip... and you
should be ok.

I'm working on an audit script to do just this on our /net path, because /net
is used by a lot of our engineers to access other desktop's local disk/scratch
space, and when users' move... the machines move and often get re-IPd.  I've
noted that when a box moves, and then things like df hang, the automount daemon
on /net will hang when checking for paths to expire and will never expire any
anymore.  It will however still respond to and mount new /net requests.  So 
eventually a host can hit the max number of allowable mounts.  

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
[Joe just pulled Antonio away from a beautiful woman he was talking to, to move
a cabinet a tiny bit]
Antonio: "We barely moved it!"   Joe: "Yeah I know, but it was askew!  Isn't it 
amazing how something like that can throw off your whole day?"
Antonio: "Yes, and you know I only wish I could stay and slap you senseless.. 
but there's a goddess waiting for me in the terminal." -- Wings
