From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Re: Intermittant problems mounting with automounter
Date: Tue, 14 Dec 2004 19:13:57 -0500
Message-ID: <41BF81C5.5040205@sun.com>
References: <200411302007.iAUK7GjH020588@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <200411302007.iAUK7GjH020588@jetcar.spd.analog.com>
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David Meleedy wrote:
> Well, in order to troubleshoot this issue further, autofs on Redhat
> Enterprise 3, update 3
> 
> I removed all options from the /etc/auto.master file:
> 
> from:
> 
> /cpd            /etc/auto.cpd  hard,intr,rsize=8192,wsize=8192
> 
> to:
> 
> /cpd            /etc/auto.cpd 
> 
> 
> After this change, the following errors seemed to go away:
> 
> ====
> Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
> Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
> Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
> Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
> Nov 19 11:27:38 codered kernel: nfs_read_super: get root inode failed
> Nov 19 11:27:38 codered kernel: nfs warning: mount version older than kernel
> Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
> Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
> Nov 19 11:27:38 codered kernel: nfs_read_super: get root inode failed
> Nov 19 11:27:38 codered automount[3623]: >> mount: wrong fs type, bad option, 
> bad superblock on aflac:/vol/vol1/cpd/nwd_usr,
> Nov 19 11:27:38 codered automount[3623]: >>        or too many mounted file 
> systems
> Nov 19 11:27:38 codered automount[3623]: mount(nfs): nfs: mount failure 
> aflac:/vol/vol1/cpd/nwd_usr on /cpd/usr
> Nov 19 11:27:38 codered automount[3623]: failed to mount /cpd/usr
> =====
> 
> So whatever it is might be caused by the options?
> 

These messages are due to starvation for reserved ports (< 1024).
Specifically, the kernel will only use ports < 800.  Currently, the
kernel uses one port per nfs filesystem.  If you mount filesystems very
fast, then you can also run out of reserved ports as the local (mountd
iirc?) will close tcp sessions and each must wait 2 minutes before being
released.

One solution is to try out the patch I posted last week that allows nfs
mounts to share tcp/udp connections:

http://marc.theaimsgroup.com/?l=linux-nfs&m=110261671705396&w=2

(against 2.6.9, although should apply to other kernels w/o too much
difficulty)

HTH,

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

iD8DBQFBv4HFdQs4kOxk3/MRAvoxAJ0XCN+p94P2SdOkm9GuLPpiA9CsOQCdEkk/
ljNrkssKI9W/O/QxGjFycYc=
=GF6k
-----END PGP SIGNATURE-----
