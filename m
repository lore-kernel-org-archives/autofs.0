From: Martin Fick <fick@fgm.com>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 12:01:35 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041011160135.GM21585@lego.fgm.com>
References: <20041011152938.GL21585@lego.fgm.com>
	<16746.43302.434588.743693@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <16746.43302.434588.743693@segfault.boston.redhat.com>
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
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

Jeff,


> fick>    1) Why does the automounter delete files (or entire filesystems)?
> 
> It doesn't, it simply mounted over your '/' mountpoint.  If you umount /,
> you get what was there before (I'm guessing.  never really overmounted /
> before).

Actually, I have rebooted and that is not the case,
everything IS gone, I even rebooted using another (backup)
root filesystem  (I keep one around for this reason) and
mounted the old root and looked around.  Again, only the
old mount points for partitions that were mounted are
left.  

Are you saying that this not supposed to be the case?  Have
I uncovered a bug?





> fick>    2) How can one go about automounting a cdrom on /cdrom?
> 
> You could automount it in /misc/cdrom, and create a symlink.
> 
> # ln -sf /misc/cdrom /cdrom

Thanks.  I was hoping for a solution that did it for real,
thus the attempted hack triggering this conversation.




 
> fick>    4) Are my files really gone?  Is there anything I can do to
> fick> recover? (it is an ext3 fs, not ext2)
> 
> No, see the answer to 1) above.  If you can't simply umount /, then you can
> boot in single user mode.  This shouldn't start the automounter.  Then, you
> can edit your automount config files to not overmount /.  You should be
> good to go after that.



I didn't do single user, I guess I could check that too,
but I'm pretty sure that won't work either -> see above.





> fick>   Still weeping/laughing,
> 
> You gave me a chuckle.

If I can't share the misery, at least I can share the fun.:) 
Actually I think my wife is sharing the misery, :(



  -Martin
