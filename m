From: Ian Kent <raven@themaw.net>
Subject: Re: auto.net gets a key with a path under SLES9.
Date: Wed, 16 Nov 2005 00:40:16 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511160036370.2260@donald.themaw.net>
References: <4378ED9A.6090903@deragon.biz>
	<Pine.LNX.4.58.0511150826030.27505@wombat.indigo.net.au>
	<17273.61751.864306.585017@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0511160007560.2260@donald.themaw.net>
	<437A0CB7.20701@deragon.biz>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <437A0CB7.20701@deragon.biz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

On Tue, 15 Nov 2005, Hans Deragon wrote:

> Ian Kent wrote:
> > On Tue, 15 Nov 2005, Jeff Moyer wrote:
> > 
> > 
> > > ==> Regarding Re: [autofs] auto.net gets a key with a path under SLES9.;
> > > Ian Kent <raven@themaw.net> adds:
> > > 
> > > raven> On Mon, 14 Nov 2005, Hans Deragon wrote: Thanks for reporting this
> > > raven> Hans.
> > > 
> > > 
> > > > > Greetings.
> > > > > 
> > > > > 
> > > > > I compiled autofs 4.1.4 for SuSE Linux Enterprise Server 9 (SLES9). I
> > > > > did found a little problem with auto.net.  The original code has:
> > > > > 
> > > > > key=$1
> > > > > 
> > > > > However, under SLES9, in my network environment, $key can be of the
> > > > > form
> > > > > "server/something[/otherthing]*", which is wrong.  $key should only be
> > > > > a
> > > > > server name.  I fixed the problem with:
> > > > > 
> > > > > key=`echo $1 | perl -wp -e 's%^(\w+)(\/?.+)*$%$1%;'`
> > > > > 
> > > > > My fix removes any path after the server name.
> > > 
> > > raven> Interesting. I'm not sure why that's happening either.
> > > 
> > > 
> > > > > Exactly why automount passes a server name containg some path is
> > > > > unclear
> > > > > for me.  But I wanted to report this here.  If other suffer from this,
> > > > > you might want to consider some fix like mine (maybe using sed which
> > > > > is
> > > > > more standard).
> > > 
> > > raven> Yep. Sounds like a good idea.
> > > 
> > > raven> I'll put it on the queue of stuff for 4.1 so I can do it when I
> > > raven> eventually get back to it.
> > > 
> > > Ian, this sounds more like papering over the real problem to me.  Do you
> > > agree?  I'd like to see some debug output.
> > 
> > 
> > Yep. Absolutely right.
> > 
> > Your post was clearly more useful than what I had to say.
> > 
> > And I agree it is likely one of the issues we have recently investigated.
> > Perhaps the SuSE folks haven't merged some of the recent kernel patches.
> > 
> > Hans, could you spend a bit of time to get us a debug log please.
> > 
> > Ian
> 
> No problem.  Just give me instructions on how to proceed.  I am not that
> familiar with autofs and its code/features.
> 

It is fairly straight forward.
Just add --debug or just -d to the master map entry for the autofs mount 
point you want to collect debug info. for.

If you concerned feel free to replace host names or IP addresses (if any) 
but please keep the trace in tact otherwise.

eg.

/net	/etc/auto.net --debug

Should do the trick.

Ian
