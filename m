From: Ian Kent <raven@themaw.net>
Subject: Re: Question about timeout option.
Date: Mon, 28 Apr 2008 17:01:08 +0800
Message-ID: <1209373268.3243.30.camel@raven.themaw.net>
References: <48148A3A.5070303@bononline.nl>
	<1209311979.7913.37.camel@raven.themaw.net>
	<481585F6.8080707@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <481585F6.8080707@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Mon, 2008-04-28 at 10:08 +0200, Stef Bon wrote:
> Ian Kent wrote:
> > On Sun, 2008-04-27 at 16:14 +0200, Stef Bon wrote:
> >   
> >> Hello,
> >>
> >> 22 april I posted a message with the question about the timeout option.
> >>
> >> Has anybody read it, and possibly have a clue?
> >>     
> >
> > I read it.
> > Try using -browse or browse (not --browse).
> >   
> Yes, thanks that did it! Somehow the option browse did not get through 
> to the daemon.

The pattern in the tokenizer is:

-g|--ghost|-?browse     { return(OPT_GHOST); }

to match the browse option in non-linux maps. Our option is usually -g
or --ghost but we probably should use [-]browse these days to be
compatible.

> In my autofs configuration it was set to "no", and the option in the 
> master file was ignored.

I think you'll find that --browse just doesn't work.
The default browse mode is "no" because of the impact this can have for
maps with thousands of entries.

Ian
