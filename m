From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: Re: Intermittant problems mounting with automounter
Date: Tue, 14 Dec 2004 09:10:58 -0500
Message-ID: <41BEF472.EAAE7682@ssa.crane.navy.mil>
References: <200411302007.iAUK7GjH020588@jetcar.spd.analog.com>
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
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org

David Meleedy wrote:
> 
> Well, in order to troubleshoot this issue further, autofs on Redhat
> Enterprise 3, update 3
> 
> I removed all options from the /etc/auto.master file:
> 
> from:
> /cpd            /etc/auto.cpd  hard,intr,rsize=8192,wsize=8192
> to:
> /cpd            /etc/auto.cpd
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
Check on your server, the above looks like messages I have seen on some
clients lately, and see if you have messages of the form
Nov 19 11:27:?? server rpc.mountd: getfh failed: Operation not permitted

These happened to me when some clients who were using soft mount option
finally switched to hard.
I had to fallover from one of my nfs drbd cluster machines to the other to
fix it. effectively it looked to the client like a server reboot.  shutting
down the nfsserver and nfslock services then restarting them might be
enough.

Note: soft mounts caused many other problems, so for me this switching to
hard mount is only a quick annoyance to avoid other more troublesome
problems, I just had to learn to recognize it.

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane) 
Harnessing the Power of Technology for the Warfighter
