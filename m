From: "William.Crocker" <william.crocker@analog.com>
Subject: Newbie needs help with automounter.
Date: Sat, 9 Oct 2004 20:37:10 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200410100037.i9A0bA020600@novus.adsdesign.analog.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Hello:

I am new to autofs/automounter and need help understanding
the following messages which I found in /var/log/messages.

These messages appeared when I tried to
change directory to /proj/asic on cfl30.

If I stop and then start autofs it will work for a while
and then start failing again.

Thanks in advance.

Bill

------------- /var/log/messages -------------

Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
Oct  9 18:30:31 cfl30 kernel: nfs warning: mount version older than kernel
Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
Oct  9 18:30:31 cfl30 automount[14622]: >> mount: wrong fs type, bad option, bad superblock on 831ntap:/vol/vol0/proj/asic,
Oct  9 18:30:31 cfl30 automount[14622]: >>        or too many mounted file systems
Oct  9 18:30:31 cfl30 automount[14622]: mount(nfs): nfs: mount failure 831ntap:/vol/vol0/proj/asic on /proj/asic
Oct  9 18:30:31 cfl30 automount[14622]: failed to mount /proj/asic
Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
Oct  9 18:30:31 cfl30 kernel: nfs warning: mount version older than kernel
Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
Oct  9 18:30:31 cfl30 automount[14624]: >> mount: wrong fs type, bad option, bad superblock on 831ntap:/vol/vol0/proj/asic,
Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
Oct  9 18:30:31 cfl30 automount[14624]: >>        or too many mounted file systems
Oct  9 18:30:31 cfl30 automount[14624]: mount(nfs): nfs: mount failure 831ntap:/vol/vol0/proj/asic on /proj/asic
Oct  9 18:30:31 cfl30 automount[14624]: failed to mount /proj/asic
