From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 12:09:17 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16746.45101.876872.951336@segfault.boston.redhat.com>
References: <20041011152938.GL21585@lego.fgm.com>
	<16746.43302.434588.743693@segfault.boston.redhat.com>
	<20041011160135.GM21585@lego.fgm.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20041011160135.GM21585@lego.fgm.com>
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
To: Martin Fick <fick@fgm.com>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] Automounting on /. deleting entire FS!; Martin Fick <fick@fgm.com> adds:

fick> Jeff, 1) Why does the automounter delete files (or entire
fick> filesystems)?
>> It doesn't, it simply mounted over your '/' mountpoint.  If you umount
>> /, you get what was there before (I'm guessing.  never really
>> overmounted / before).

fick> Actually, I have rebooted and that is not the case, everything IS
fick> gone, I even rebooted using another (backup) root filesystem (I keep
fick> one around for this reason) and mounted the old root and looked
fick> around.  Again, only the old mount points for partitions that were
fick> mounted are left.

fick> Are you saying that this not supposed to be the case?  Have I
fick> uncovered a bug?

Nothing is in /etc/ on your old root partition?  I don't see anything in
the autofs code that would remove an entire directory hierarchy plus its
contents.

-Jeff
