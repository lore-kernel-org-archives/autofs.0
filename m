From: Gerald Teschl <gerald@esi.ac.at>
Subject: Re: autofs RFE
Date: Mon, 8 Dec 2003 11:43:46 +0100 (CET)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312081124260.15293-100000@keen.esi.ac.at>
References: <Pine.LNX.4.33.0312081134310.26524-100000@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0312081134310.26524-100000@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Mon, 8 Dec 2003, Ian Kent wrote:

> I've been thinking about this for a while.
> 
> At the moment the userspace daemon has no way of knowing who the owner is.
> To change that would break backward compatability. So I'm not sure it's
> such a good idea.

OK, let me provide more details (this refers to RedHat/Fedora):

After login as console user I own the floppy dev:

brw-rw----    1 gerald   floppy     2,   0 Sep 15 15:40 /dev/fd0

The default fstab entry on RedHat/Fedora looks like

/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0 

and due to the "owner" option I (gerald) can say mount /mnt/floppy and a 
dos floppy will be mounted and all files are owned by me. If I say mount
/mnt/floppy as root, the files will be owned by root.

Now if I use autofs to mount the floppy the mount call will be done as 
root and the files will be owned by root (no matter if the owner option is
present or not). 

The ideal solution would be to make the mount call as the user requesting
the mount, but if I understand you right, this is to complex to find out.
So the solution to this problem should be the following:
If the "owner" option is present, do the mount call as the user owning
the device file.


> One way to deal with this is to use groups. The floppy group exists in
> RedHat and if you are a member and you allow group write you should have
> what you need. The cdrom is a little different. You may wish to create a
> new group called, say cdrom, and do the same thing with it.

This is not an option for us. Or system has about 200 guest accounts. The
guests need to have access to the floppy drive, but *only* to the drive
in the computer they are sitting in front of!

Thanks for considering this!

Gerald
