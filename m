From: "Chris Penney" <penney@msu.edu>
Subject: Automount fails while manual mount works
Date: Fri, 27 Jul 2007 15:55:53 -0400
Message-ID: <111aefd0707271255t2b8e3f27mc99e664e4f65ca3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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

I have a curious problem that seems like it must be some dumb mistake,
but I can't seem to see it.

I have a SuSE Entperprise 9 (x86_64) system running automount (using
autofs4) that is setup so that it mounts /apps areas from different
systems as /a/<host>.  For one system I get permission denied when
trying to cd to it, but I can mount it by hand just fine.

/etc/auto.master:
/a     /etc/auto.a
-nosuid,rw,hard,intr,vers=3,proto=tcp,rsize=32768,wsize=32768

/etc/auto.a:
systema         systema.x.com:/apps
systemb         systemb.x.com:/apps
systemc         systemc.y.x.com:/apps

When I try to cd to /a/systemc I get:
automount[20198]: failed to mount /a/systemc

The wierd thing is that I can do this just fine:
mount -o nosuid,rw,hard,intr,vers=3,proto=tcp,rsize=32768,wsize=32768
systemc.y.x.com:/apps /mnt

I did a tcpdump and I get:

15:28:26.045956 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF],
length: 84) myhost.x.com.870 > systemc.y.x.com.sunrpc: UDP, length: 56
15:28:26.176648 IP (tos 0x0, ttl  56, id 0, offset 0, flags [DF],
length: 56) systemc.y.x.com.sunrpc > myhost.x.com.870: [udp sum ok]
UDP, length: 28
15:28:26.177334 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF],
length: 68) myhost.x.com.913444943 > systemc.y.x.com.nfs: 40 null
15:28:26.307373 IP (tos 0x0, ttl  56, id 0, offset 0, flags [DF],
length: 52) systemc.y.x.com.nfs > myhost.x.com.913444943: reply ok 24
null
15:28:26.307391 IP (tos 0xc0, ttl  64, id 35564, offset 0, flags
[none], length: 80) myhost.x.com > systemc.y.x.com: icmp 60:
myhost.x.com udp port 870 unreachable

The only thing different between systemc and systema/b (which are
fine) is that systemc (the one with problems) is at a remote location
on a ~0.110ms latency link.  Again, I can do a mount by hand just
fine, but automount fails.

Thanks,

    Chris

P.S. I'm not a list subscriber so please CC me if possible
