From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Newbie needs help with automounter.
Date: Mon, 11 Oct 2004 13:11:42 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <416ABECE.2010701@sun.com>
References: <200410100037.i9A0bA020600@novus.adsdesign.analog.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <200410100037.i9A0bA020600@novus.adsdesign.analog.com>
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
To: "William.Crocker" <william.crocker@analog.com>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

William.Crocker wrote:
> Hello:
> 
> I am new to autofs/automounter and need help understanding
> the following messages which I found in /var/log/messages.
> 
> These messages appeared when I tried to
> change directory to /proj/asic on cfl30.
> 
> If I stop and then start autofs it will work for a while
> and then start failing again.
> 
> Thanks in advance.
> 
> Bill
> 
> ------------- /var/log/messages -------------
> 
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 kernel: nfs warning: mount version older than kernel
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 automount[14622]: >> mount: wrong fs type, bad option, bad superblock on 831ntap:/vol/vol0/proj/asic,
> Oct  9 18:30:31 cfl30 automount[14622]: >>        or too many mounted file systems
> Oct  9 18:30:31 cfl30 automount[14622]: mount(nfs): nfs: mount failure 831ntap:/vol/vol0/proj/asic on /proj/asic
> Oct  9 18:30:31 cfl30 automount[14622]: failed to mount /proj/asic
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 kernel: nfs warning: mount version older than kernel
> Oct  9 18:30:31 cfl30 kernel: RPC: Can't bind to reserved port (98).
> Oct  9 18:30:31 cfl30 automount[14624]: >> mount: wrong fs type, bad option, bad superblock on 831ntap:/vol/vol0/proj/asic,
> Oct  9 18:30:31 cfl30 kernel: NFS: cannot create RPC transport.
> Oct  9 18:30:31 cfl30 automount[14624]: >>        or too many mounted file systems
> Oct  9 18:30:31 cfl30 automount[14624]: mount(nfs): nfs: mount failure 831ntap:/vol/vol0/proj/asic on /proj/asic
> Oct  9 18:30:31 cfl30 automount[14624]: failed to mount /proj/asic
> 

This occurs when the kernel can't bind to a reserved port (<1024) when
building the rpc transport.  In fact, the rpc code further limits the
available ports to 1-800.   You can try upping the value of
XPRT_MAX_RESVPORT in net/sunrpc/xprt.c to 1024, or higher if your nfs
servers don't care what port the client is connecting from.

This said, this is likely a symptom of one of two things:

- - You are mounting hundreds of nfs filesystems (the current code does
not multiplex rpc connections at all).
- - Automounter ran wild and is mounting filesystems that are not getting
freed/umounnted properly.

Can you post the output of 'cat /proc/mounts' and 'netstat -a --inet' as
well as versioning information for your kernel and automounter you are
using?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBar7NdQs4kOxk3/MRAmKVAKCbxhhMthZ+T2fLG9XZ4Y04+0V1gwCfQ6IQ
oBaXn6tijYWEgbArqoSTlG8=
=LBX8
-----END PGP SIGNATURE-----
