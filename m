From: Martin Fick <fick@fgm.com>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 14:02:46 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041011180246.GP21585@lego.fgm.com>
References: <20041011152938.GL21585@lego.fgm.com>
	<16746.43302.434588.743693@segfault.boston.redhat.com>
	<20041011160135.GM21585@lego.fgm.com>
	<16746.45101.876872.951336@segfault.boston.redhat.com>
	<20041011162927.GN21585@lego.fgm.com>
	<20041011170010.GI27189@debian-server.aei.mpg.de>
	<20041011171612.GO21585@lego.fgm.com>
	<20041011172446.GJ27189@debian-server.aei.mpg.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041011172446.GJ27189@debian-server.aei.mpg.de>
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
To: Steffen Grunewald <steffen.grunewald@aei.mpg.de>
Cc: autofs@linux.kernel.org

Steffen,


> > > Looks like the contents of fs cache.
> > > You might try to find out what's there (from single user best, but
> > > another root partition would do too) using df. Make sure to first mount
> > > read-only, then (when you can see everything is somehow still alive)
> > > remount rw. fsck'ing may be a Very Bad Idea. If you can see files it'd
> > > be a good idea to do some kind of backup (if it works, you won't need it
> > > afterwards in 99% of all cases) before going rw.
> >
> >   Hmm, I'n not familiar with the automounter design at all,
> > what do you mean by fs cache.  Chances are fsck has already
> > been run since the first time I rebooted it was into the
> > same partition.  I'm not really sure what you are
> > suggesting here since I already remounted it from another
> > partition and saw the above directories?
>
> Well, I'm a bit confused. You "rebooted into the same partition" ... and
> "remounted it from another partition".

  Yes


> At the same time, or were these different attempts?

  Separate attempts.  When I first noticed something wrong
(ls would no longer work), I rebooted into the same
partition figuring that if the automounter was somehow
covering up the / filesystem, that it would not do that on
reboot since I would not have accesed /cdrom yet. I assume
that with ext3, this would have fscked the partition.

  Once I rebooted and realized that (alomst) everything
was  still gone, I rebooted into my safe partition and
mounted the original (potentially trashed) partition on
/mnt so that I could peruse it, -> files still missing.
This mounting would probably not have run fsck (I did not
run it manually.)




> YOu should really "boot single" to be able to rename the auto.master
> file. What about Knoppix? It's a perfect tool to repair damaged
> installations :-)

  I will boot single tonight and look around even more.
When this first happened, I simply decided to cut my losses
and stop (you know, late at night).  I figured I simply did
something that would trash my filesystem, but I wasn't sure
and wanted more info before I decided to cut my losses and
rebuild.  It sounds like I am getting the signal that I
should not have actually lost anything, so I will need to
go home and take a deeper look.



> Hmmm. What did 'df' tell you?

  Again, mind you this was late Friday, but I think I
recall trying df and noticing that the available space was
very large and used space very low.  Before that my system
was pretty tight, at least 80% used.  This was another
indicator to me that I had goofed royally and that the
filesystem was not simply being masked.

  I'm sorry that I can't double check everyting I am saying
until tonight, I will though.  You now have me convinced
that my system should not have been deleted.  Is this
something that is valuable for this list to be sure about,
should I hold off rebuilding my machine until we know
exactly what happened?

  I am running debian sid if that makes a difference,


  -Martin
