From: Bryce as root <root@www.linux.org.uk>
Subject: fast mounting problems
Date: Tue, 31 Aug 2004 17:55:41 +0100 (BST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <E1C2Bv4-0002u8-7T@www.linux.org.uk>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Relating to Autofs 4.1

This relates to a bug I've filed with RHAT
( https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966 )

In our testing enviroment we use autofs a lot and have been experiancing
problems of being unable to mount directories every now and again

To this end I build a test script to exercise the autofs daemon which
nicely exposes the problem (again covered in the bugzilla report)

What appears to be happening is that autofs is spawning forked copies of
itself to help facilitate loading FS's
however, initially when debugging it seemed like the first batch of NFS
directories were mounted before the second forked process times out
trying to rpc_ping the server because the initial process never bothered to
close the socket.

Now Jeff Moyer at RedHat spotted that and gave me a patch for rpc_stubs.c
which alleviates the problem slightly, however, while the parent and then
the first child process play nice, any further forked processes also run
into this rpc_ping port being held open and consequently fail to mount and
you'd see something like this in the system messages log

Aug 18 18:59:12 localhost automount[8746]: attempting to mount entry/test/947
Aug 18 18:59:12 localhost automount[9050]: >> nfs bindresvport: Address already in use
Aug 18 18:59:12 localhost automount[9050]: mount(nfs): nfs: mount failure 192.168.1.100:/compile/nfs/947 on /test/947

soooooo,.... ideas on how to make the other children processes play nice?

Phil
=--=
