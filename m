From: Ian Kent <raven@themaw.net>
Subject: Re: automount doesn't reread file map, automount terminates
 on empty file map
Date: Thu, 16 Dec 2004 11:00:33 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0412161052250.20186@wombat.indigo.net.au>
References: <1102796222l.6265l.2l@mercury>
	<Pine.LNX.4.58.0412151807070.30726@wombat.indigo.net.au>
	<1103144614l.6934l.0l@mercury>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1103144614l.6934l.0l@mercury>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Jahns <Thomas.Jahns@gmx.net>
Cc: autofs@linux.kernel.org

On Wed, 15 Dec 2004, Thomas Jahns wrote:

> Hi,
> 
> On 12/15/04 11:08:44, Ian Kent wrote:
> > On Sat, 11 Dec 2004, Thomas Jahns wrote:
> > > I'm currently experimenting with a script-created map and face the
> > > following two problems:
> > >
> > > - After the script rewrites the map, I need to kill -HUP the
> > > corresponding automount to reread the map, the documentation says
> > > the daemon would read a changed map on next access of the
> > > directory?
> > 
> > Known problem with 4.1.
> > But what vesion are you running?
> 
> sorry I forgot to mention some essential information it seems, I use  
> the 4.1.3-6 debian package.

I can't remember the patches that Arthur included in the deb (Arthur?).
I'll check if we can't raise him.

A further difficulty with this is that to fix this problem a small kernel 
patch was needed. But what kernel are you using (ie. are the latest kernel 
updates included in it)?

> 
> > >
> > > - Unfortunately there exists the possibility, that the script might
> > > leave the map empty. The corresponding automount process will then
> > > exit. Is there perhaps some comment convention or anything else I
> > > could do to keep the automount process running?
> > 
> > Known problem but not yet fixed.
> 
> Okay, could I perhaps add some dummy entry? Any device/location I could  
> specify that would never ever get mounted?

Any bogus entry should be OK.

Must admint I've known about this for a while but it slipped through the 
cracks. Now is difficult as there have been so many changes, making 
patches is going to start to be difficult to get them to apply. So I'm 
likely not to add much to the current code until after I make a new 
release.

Ian
