From: David Meleedy <david.meleedy@analog.com>
Subject: Re: Intermittant problems mounting with automounter
Date: Fri, 19 Nov 2004 11:35:57 -0500
Message-ID: <200411191635.iAJGZvwW019665@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4698961564948978=="
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
To: autofs@linux.kernel.org

--===============4698961564948978==
Content-Type: text; charset=us-ascii


To simplify this problem further (after looking at /var/log/messages)
I changed /etc/auto.master entry from:

/cpd            /etc/auto.cpd   hard,intr,rsize=8192,wsize=8192,vers=3

to:

/cpd            /etc/auto.cpd   hard,intr,rsize=8192,wsize=8192

I still had the problems, here is the /var/log/messages output:
(this shows what was happening when the mount failed.  Again,
it worked a minute or so later).



Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
Nov 19 11:27:38 codered kernel: nfs_read_super: get root inode failed
Nov 19 11:27:38 codered kernel: nfs warning: mount version older than kernel
Nov 19 11:27:38 codered kernel: RPC: Can't bind to reserved port (98).
Nov 19 11:27:38 codered kernel: nfs_get_root: getattr error = 5
Nov 19 11:27:38 codered kernel: nfs_read_super: get root inode failed
Nov 19 11:27:38 codered automount[3623]: >> mount: wrong fs type, bad option, 
ba
d superblock on aflac:/vol/vol1/cpd/nwd_usr,
Nov 19 11:27:38 codered automount[3623]: >>        or too many mounted file 
syst
ems
Nov 19 11:27:38 codered automount[3623]: mount(nfs): nfs: mount failure 
aflac:/v
ol/vol1/cpd/nwd_usr on /cpd/usr
Nov 19 11:27:38 codered automount[3623]: failed to mount /cpd/usr



________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA



--===============4698961564948978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============4698961564948978==--
