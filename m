From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: [PATCH] More autofs cleanup
Date: Sun, 13 Aug 2006 02:40:17 -0400
Message-ID: <20060813064017.GS26249@mail.iSKUNK.ORG>
References: <20060811023733.GC26249@mail.iSKUNK.ORG>
	<1155372266.14008.16.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZmUaFz6apKcXQszQ"
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1155372266.14008.16.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org
Cc: Ian Kent <raven@themaw.net>


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, 2006 Aug 12 16:44:26 +0800, Ian Kent wrote:
> 
> Thanks Daniel.
> 
> A small point.
> When you send patches could you send them in-line in the mail.
> It's much easier to deal with and keeps the flow of though going.

Understood, will keep in mind.

> >   (You might want to update config.h.in, given that it uses an #ident 
> >   directive that gcc complains about in pedantic mode)
> 
> All the CVS identification will be removed when I get to it.

Here, it's just the old-autoheader-output problem. New versions of 
autoheader don't use #ident.

> I'll need to put this to one side for a while and merge it by hand as
> stress testing autofs has exposed a number of more nasty problems that
> compiler warnings.

Oh, certainly. This is peripheral work, after all. (With the potential 
exception of it pointing out some odd bug, as last time.)

> Just so we're on the same page, what CFLAGS are you using?
> I'm fairly lazy about compiler warnings most of the time.
> You wouldn't guess, would you.

Tsk tsk :-)

For development, I normally use

	-O0 -g3 -ansi -pedantic -fno-common -pipe -W -Wall -Wcast-align 
	-Wcast-qual -Wconversion -Wformat=2 -Winline -Wnested-externs 
	-Wpointer-arith -Wshadow -Wstrict-prototypes -Wundef 
	-Wno-unused-parameter -Waggregate-return -Wnested-externs

For autofs, you have to drop -ansi (otherwise you don't get __u64, needed 
in auto_fs4.h), and -Wconversion generates more noise than it's worth.

I've attached the script I use to produce my warning summaries, in case you 
find it useful.

> > Makefile.conf.in:
> > 
> > * Added a dummy @substitution@ for datarootdir, so that config.status 
> >   doesn't print a warning at the end of a configure script run.
> 
> OK. I'll have a look at that.

Another problem with the makefiles is that they assign CFLAGS from scratch, 
and allow the environment to override it, instead of having a line like

	CFLAGS = @CFLAGS@

so that they pick up whatever was in the environment at configure time. 
This threw me off for a bit---it's definitely not the behavior one expects 
when a package uses autoconf.

> >      22 warning: cast discards qualifiers from pointer target type
> > 
> > 	(This seems to be done deliberately, so no prob)
> 
> No sure I what to do about this.
> I'd like to rationalize it sometime but I always break stuff when I try.
> There's more important issues to address at the moment.

Yeah, I get the impression some previous maintainer went a little 
const-happy and used it willy-nilly everywhere. Bad enough to see the code 
de-const-ing a pointer, then passing it to free()....


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)

--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=warning-summary

#!/usr/bin/env perl
# warning-summary

use strict;
use warnings;

open(OUT, "| sort | uniq -c | sort -nr");

while (<>)
{
	/warning:/ || next;
	/\(near initialization for .*\)/ && next;

	s/^.*: warning: //g;

	s/\barg(ument|) \d+\b/arg$1 N/g;

	s/\b(type|function|variable|enumeration value|declaration of|argument N of|type of) '[^']+'/$1 'blah'/g;

	s/"[^"]+" (is not defined)/"BLAH" $1/g;

	s/'[^']+' (defined but not used)/'blah' $1/g;

	s/format '%\w+'/format '%blah'/g;

	s/'\d+'/'NNN'/g;

	s/'[^']+' (declared 'static' but never defined)/'blah' $1/g;

	print OUT;
}

close(OUT);

# end warning-summary

--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--ZmUaFz6apKcXQszQ--

