From: Martin Fick <fick@fgm.com>
Subject: Re: Automounting on /. deleting entire FS!
Date: Mon, 11 Oct 2004 13:16:12 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20041011171612.GO21585@lego.fgm.com>
References: <20041011152938.GL21585@lego.fgm.com>
	<16746.43302.434588.743693@segfault.boston.redhat.com>
	<20041011160135.GM21585@lego.fgm.com>
	<16746.45101.876872.951336@segfault.boston.redhat.com>
	<20041011162927.GN21585@lego.fgm.com>
	<20041011170010.GI27189@debian-server.aei.mpg.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20041011170010.GI27189@debian-server.aei.mpg.de>
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

On Mon, Oct 11, 2004 at 07:00:11PM +0200, Steffen Grunewald wrote:
> On Mon, Oct 11, 2004 at 12:29:27PM -0400, Martin Fick wrote:
> > > Nothing is in /etc/ on your old root partition?  I don't see anything in
> > > the autofs code that would remove an entire directory hierarchy plus its
> > > contents.
> > Well, I don't have acces to the system here, I am at work,
> > but I didn't see any files, just a few vacant directories
> > left such as:
> > 
> > 	/bin (maybe)
> > 	/dev
> > 	/etc
> > 	/home/fick (my home dir, empty!)
> > 	/mnt
> > 	/usr (was mounted externally)
> 
> Looks like the contents of fs cache. 
> You might try to find out what's there (from single user best, but
> another root partition would do too) using df. Make sure to first mount
> read-only, then (when you can see everything is somehow still alive)
> remount rw. fsck'ing may be a Very Bad Idea. If you can see files it'd
> be a good idea to do some kind of backup (if it works, you won't need it
> afterwards in 99% of all cases) before going rw.

  Hmm, I'n not familiar with the automounter design at all,
what do you mean by fs cache.  Chances are fsck has already
been run since the first time I rebooted it was into the
same partition.  I'm not really sure what you are
suggesting here since I already remounted it from another
partition and saw the above directories?




> There's still hope.

  thanks, :)




> (BTW, it's a quite common trap, almost as efficient as chown -R xyz .*)

  What is the common trap, automounting over slash?




> > I had assumed at first that it was something like what you
> > suggested and so I simply rebooted into the other partition
> > and was shocked to find that nothing came back!
> 
> ??? so you started another kernel and gave it the root=... arg?
> Then of course automount would be running before you can do anything...
> there's perhaps even more hope than you'd expect!


  No no no, I started another kernel and another root
partition, then mounted the old root on /mnt and looked
around.



  -Martin
