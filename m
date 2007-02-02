From: Ian Kent <raven@themaw.net>
Subject: Re: automounted symlink to automount sometimesfails,
	doing	DNS query of partial path
Date: Fri, 02 Feb 2007 23:45:40 +0900
Message-ID: <1170427540.28994.1.camel@raven.themaw.net>
References: <CECD6E8A589E8447BC6E836C8369AFF50C4BB8A1@us-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <CECD6E8A589E8447BC6E836C8369AFF50C4BB8A1@us-email.terastack.bluearc.com>
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
To: Martin Dorey <mdorey@bluearc.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-02-01 at 18:08 -0800, Martin Dorey wrote:
> > Is there still a mount present on the mount-point when this
> > happens.
> 
> Looking at my console logs, there appeared to be a directory
> /net/us-titan.us.dev.bluearc.com/ARCHIVE and umounting that returned
> success once and then failure the next time.  umounting
> /net/us-titan.us.dev.bluearc.com then said it wasn't mounted.  I'm not
> sure if that answers your question.

I just wanted to know if typing mount<ret> showed a mount present on 
/net/us-titan.us.dev.bluearc.com/ARCHIVE

> -------------------------------------
> Martin's Outlook, BlueArc Engineering
> 
> 
> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Monday, January 29, 2007 23:34
> To: Martin Dorey
> Cc: Lukas Kolbe; autofs@linux.kernel.org
> Subject: RE: [autofs] automounted symlink to automount
> sometimesfails,doing DNS query of partial path
> 
> On Mon, 2007-01-29 at 12:13 -0800, Martin Dorey wrote:
> > > I suspect that 2.6.18 (or even 17) will help with Martins problem.
> > 
> > In my original post, I said:
> > 
> > >> The machine which had this problem last week is running
> 2.6.18-3-686
> > and
> > >> autofs 4.1.4+debian-1.  I think its mount table cleared up after
> say
> > five
> > >> minutes.  It also contained spuriously few, spuriously capitalized
> > mount
> > >> entries (including at least ARCHIVE) before the problem went away.
> > 
> > Ian correctly divined that I was (disingenuously, sorry) being
> ambiguous
> > about whether it *had* been running 2.6.18 at the time of the problem.
> > That was because I couldn't think of an easy way to prove it one way
> or
> > the other.  I've given it some more thought and realized that I still
> > have old enough auth.log entries.  These convince me that my
> > recollection was right - that I was already running 2.6.18 at the time
> > of the first occurrence of the problem.
> 
> oops.
> 
> > 
> > Jan  8 18:20:12 duezer sudo:  martind : TTY=pts/2 ;
> > PWD=/home/martind/work/misc ; USER=root ;
> COMMAND=/usr/X11R6/bin/apt-get
> > install linux-image-2.6.18-3-686
> > Jan  8 18:21:39 duezer sudo:  martind : TTY=pts/2 ;
> > PWD=/home/martind/work/misc ; USER=root ; COMMAND=/sbin/reboot
> > 
> > Jan 13 14:59:38 duezer sudo:  martind : TTY=pts/0 ;
> > PWD=/home/martind/work/parrot ; USER=root ; COMMAND=/bin/umount
> > /net/us-titan.us.dev.bluearc.com/ARCHIVE/
> > 
> > This is the same machine (and kernel) on which I later tried but
> failed
> > to reproduce the problem (and on which it still hasn't recurred in the
> > intervening time).  I can't help but suspect that the spurious
> > capitalization of some of the mount point names - like ARCHIVE - is a
> > clue.  I wonder what could cause that?
> 
> Don't know but autofs doesn't change the entries so it shouldn't be
> that. Is there still a mount present on the mount-point when this
> happens.
> 
> Ian
> 
> 
