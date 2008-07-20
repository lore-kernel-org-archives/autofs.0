From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: statfs() and autofs
Date: Sun, 20 Jul 2008 15:24:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
	<487D855B.8000405@loran.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <487D855B.8000405@loran.name>
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
To: Jonathan Loran <jonathan@loran.name>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Tue, 15 Jul 2008, Jonathan Loran wrote:
> Ian Kent wrote:
> > On Tue, 2008-07-15 at 13:48 -0700, Chris Walker wrote:
> > >
> > > When statfs() is called on an automounted directory, it returns before
> > > the automount occurs. This results in output like this initially:

> > That may be because there are a group of system calls that don't trigger
> > a mount because we have to avoid mount storms for map entries that use
> > the browse option. In particular stat(2) and calls that use the same
> > kernel path lookup flags, such as statfs(2).
> 
> I need to say that this basically has to be declared a bug.  

I see this two ways.  First, for the folks who have giant NAS boxes with a 
thousand exported filesysems, if ghost mounts (visibility on the client of 
non-mounted filesystems) are turned on and someone does "ls -F /net/nasbox" 
the resulting mount storm, when it stats every exported directory, is a 
serious pain in the butt, and when ghost mounts (browsing) were introduced 
there was a lot of howling until the mount storms were tamed.

On the other hand, the issue is Not Autofs' Problem, and if stat() or 
statfs() is directed at a nonlocal directory, information about its 
referent should be returned, not about the soon-to-be-underlying mount 
point.  "ls", Nautilus, etc. are supposed to use mental telepathy to avoid 
causing mount storms; it is not autofs' place to interpret why the 
information is wanted and whether major resources should be expended to 
make it available.

Actually, only the sysop knows which is more important: doing the mount 
storm to respond to stat() or statfs(), or avoiding the storm.

Could we have two kinds of browsing, with or without mount storms, i.e. 
with or without a response to stat() or statfs()?  This would be 
configurable the same way browsing is, individually per map row.  The 
default should be to do the mount, because most sites export a reasonable 
number of filesystems from each server and so the mount storm is not a big 
deal, but a sysop who exports lots of directories from one NAS box and also 
turns on browsing in the client is advised to pick the non-mounting browse 
variant.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
