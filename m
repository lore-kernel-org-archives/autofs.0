From: Ian Kent <raven@themaw.net>
Subject: Re: stat of /users/no-such-user takes 15 seconds
Date: Sat, 26 Nov 2005 09:40:25 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511260937300.2070@donald.themaw.net>
References: <1132670358.4039.37.camel@brilong-lnx>
	<1132674350.4039.52.camel@brilong-lnx>
	<Pine.LNX.4.63.0511222351130.9982@donald.themaw.net>
	<Pine.LNX.4.63.0511231359220.20045@simba.math.ucla.edu>
	<x3kiruhbkzh.fsf@Psilocybe.Update.UU.SE>
	<Pine.LNX.4.58.0511251021100.3517@wombat.indigo.net.au>
	<17287.20879.104271.43152@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17287.20879.104271.43152@Psilocybe.Update.UU.SE>
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
To: Thorild Selen <thorild@Update.UU.SE>
Cc: autofs@linux.kernel.org

On Fri, 25 Nov 2005, Thorild Selen wrote:

Thanks for this info.

> Ian Kent writes:
>  > But, at this stage, autofs isn't going to be listening it's going to be 
>  > asking?
> 
> LCUP provides a syncOnly mode if you don't want to listen persistently
> but instead occasionally ask for changes. If I've understood it
> correctly, it would work basically like this:

OK. I see.

I'll investigate. I can't say when I'll get to this as I've got a bunch of 
stuff that just keeps building up while I'm working on missing basic 
features.

Ian
