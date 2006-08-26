From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in ldap
 automatically
Date: Sat, 26 Aug 2006 18:51:54 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0608261840290.29842@raven.themaw.net>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
	<44EEEC55.2040101@inria.fr>
	<Pine.LNX.4.64.0608252033290.30811@raven.themaw.net>
	<44EEF1E6.7040008@inria.fr>
	<1156511928.30971.12.camel@raven.themaw.net>
	<1156512652.30971.19.camel@raven.themaw.net>
	<44EF1747.5010103@inria.fr> <E1GGe66-00006L-00@mta2.cl.cam.ac.uk>
	<1156562424.3023.82.camel@raven.themaw.net>
	<E1GGrxB-0004pk-00@mta2.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1GGrxB-0004pk-00@mta2.cl.cam.ac.uk>
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
To: Piete.Brooks--autofs@cl.cam.ac.uk
Cc: autofs@linux.kernel.org

On Sat, 26 Aug 2006, Piete.Brooks--autofs@cl.cam.ac.uk wrote:

> > I didn't mean to be nasty.
> 
> Not taken as such. Sorry -- I should scatter a few more ":-)"'s around :-))
> 
> > It's just that it seems like every time I do something in response to
> > requests someone else then wants the opposite.
> 
> That's where judgement kicks in.
> When you have equal numbers objecting to both options, you've got it right :-))
> 
> > Actually, using the multiple schema we were seeing up to "nine" queries
> > per lookup during a mount failure situation
> 
> Ahh -- I was thinking of the multiple schema only during initial discovery.
> I was assuming that like the mount_bind code, at the start of day it would 
> look at its environment and decide how to do things.
> If not told what schema to use, it would try the pre defined (3 at the moment) 
> schema until one of them worked, and then latch onto that one.
> (e.g. default is the null string, and if it finds the string null, call a 
> discovery procedure).
> 
> As such this would not effect a mount failure -- it would only be done once at 
> startup (and when it gets a HUP etc)

Yep. I guessed that was what you were getting at after I posted.

It's a good idea however I'd rather not change that part of the 
code for this release becuase there's already been major changes in that 
module so I'll let that settle. I'll reconsider it for the next release.

> 
> 
> Would it be OTT to add an option to say whether the initial lookup of 
> "auto.master" was single level or recursive?
> [ I really don't understand why recursive is needed if auto.master is at the 
> top level :-( ]

Guillaume has his autofs stuff at a level below the top by the look of it.

I'm reluctant to add an option as if there's choice then people will 
always be asking questions about it. I like to keep the configuration to a 
minimum.

I'm not clear on the performance implications of this yet so I'll change 
it and wait till someone can give feedback on cost. LDAP servers seem to 
cope fairly well with this type of query anyway (default option for 
ldapsearch) and it's only done at startup, to get the base for future 
searches.

Ian
