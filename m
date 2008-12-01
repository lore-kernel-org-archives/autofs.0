From: "Paolo Minazzi" <paolo.minazzi@gmail.com>
Subject: Re: automount usb key (vfat and ntfs)
Date: Mon, 1 Dec 2008 16:52:35 +0100
Message-ID: <4aa525de0812010752k3fb5c3f2x213d35977b56e043@mail.gmail.com>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>
	<4933FD65.5060802@ssa.crane.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4933FD65.5060802@ssa.crane.navy.mil>
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
To: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Cc: autofs@linux.kernel.org

> So, have you tried something like:
> pen   -fstype=vfat,ntfs-3g        :/dev/sda1
>
> --
> Todd Denniston
> Crane Division, Naval Surface Warfare Center (NSWC Crane)
> Harnessing the Power of Technology for the Warfighter
>

Thanks for your replay.
From the documentation I have read that the 2nd parameter to the last
parameter are specific mount parameter, so it does not solve the
problem.

For example
pen   -fstype=vfat,gid=102,umask=002        :/dev/sda1

means do

mount -t vfat -o gid=102,umask=002 /dev/sda1 /media/pen


It would be interesting if it was possible specifiy different fstype,
each one with her parameters.

For example:

pen   -fstype=vfat,gid=102                :/dev/sda1
pen   -fstype=ntfs-3g,gid=104           :/dev/sda1

In this example the daemon first will try to mount vfat with gid=102.
Then, if it fails, it retry with ntfs-3g with gid=104.

Thanks for your time

Paolo
