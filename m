From: Ian Kent <raven@themaw.net>
Subject: Re: Looking for infor on executable map format
Date: Tue, 30 Mar 2004 09:05:47 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403300903490.6000@wombat.indigo.net.au>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<Pine.LNX.4.58.0403291450290.18783@wombat.indigo.net.au>
	<Pine.LNX.4.58.0403291822090.26549@raven.themaw.net>
	<Pine.LNX.4.53.0403291129590.3206@fafnir.cft.ca.us>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403291129590.3206@fafnir.cft.ca.us>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, Jim Carter <jimc@krienke.org>

On Mon, 29 Mar 2004, Jim Carter wrote:

> > On Mon, 29 Mar 2004, Rainer Krienke wrote:
> 
> > > This outputs eg something like
> > >
> > > -fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192 \
> > >         /export/user serverhost:/export/user
> > > 	.....
> > >
> > > So there are options, a qouted newline and then the map entry without
> > > the key.
> 
> Hmmm, the daemon code that handles executable maps likes to see
>     [-mount-options] [mapkey] mapreferent
> ([] indicating optional), whereas the file map handler wants
>     mapkey [-mount-options] mapreferent
> It's rather surprising that the mapkey is legal in the middle position -- I
> would expect it to always be in the same place and to never be optioal -- I
> can understand that it's mandatory in a file map, and if it were forbidden
> in an executable map, but optional?

Umm. I'm going to have to check that. Seems to me that an executable map 
should be expected to emit the same map format as other maps.

> 
> In any case, a comment in the man page (even if not representing the
> parser's complete range of behavior bug for bug :-) would be helpful for
> people writing executable maps.  Answering Reiner's first question, I said,

Yep.

Ian
