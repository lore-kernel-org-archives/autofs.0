From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Looking for infor on executable map format
Date: Mon, 29 Mar 2004 11:42:55 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0403291129590.3206@fafnir.cft.ca.us>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<Pine.LNX.4.58.0403291450290.18783@wombat.indigo.net.au>
	<Pine.LNX.4.58.0403291822090.26549@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403291822090.26549@raven.themaw.net>
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
Cc: autofs@linux.kernel.org, Jim Carter <jimc@krienke.org>

> On Mon, 29 Mar 2004, Rainer Krienke wrote:

> > This outputs eg something like
> >
> > -fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192 \
> >         /export/user serverhost:/export/user
> > 	.....
> >
> > So there are options, a qouted newline and then the map entry without
> > the key.

Hmmm, the daemon code that handles executable maps likes to see
    [-mount-options] [mapkey] mapreferent
([] indicating optional), whereas the file map handler wants
    mapkey [-mount-options] mapreferent
It's rather surprising that the mapkey is legal in the middle position -- I
would expect it to always be in the same place and to never be optioal -- I
can understand that it's mandatory in a file map, and if it were forbidden
in an executable map, but optional?

I suspect that the ugly parser code never even looks at it; the parser uses
the last whitespace-separated field as the referent, and the first or
second as the mount options, depending on the type of map and whether the
field beings with a hyphen.

In any case, a comment in the man page (even if not representing the
parser's complete range of behavior bug for bug :-) would be helpful for
people writing executable maps.  Answering Reiner's first question, I said,
"what's it likely that /sbin/automount needs to know?  Either an imitation
file map (wrong, rejected), or the same minus the key (acceptable when I
tried it)."

That also ties in with the formst which you would get with a NIS map if you
could get NIS maps to work on your system.  (I haven't worked on that one
for a long time; maybe it's fixed in recent updates and I can lose the
executable home map.)


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
