From: Ian Kent <raven@themaw.net>
Subject: Re: Looking for infor on executable map format
Date: Mon, 29 Mar 2004 18:29:28 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403291822090.26549@raven.themaw.net>
References: <200403261040.08085.krienke@uni-koblenz.de>
	<Pine.LNX.4.58.0403291450290.18783@wombat.indigo.net.au>
	<200403290900.23350.krienke@uni-koblenz.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200403290900.23350.krienke@uni-koblenz.de>
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
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: autofs@linux.kernel.org, Jim Carter <jimc@krienke.org>

On Mon, 29 Mar 2004, Rainer Krienke wrote:

> 
> This outputs eg something like 
> 
> -fstype=nfs,hard,intr,nodev,nosuid,nonstrict,rsize=8192,wsize=8192 \
>         /export/user serverhost:/export/user 
> 	.....
> 
> So there are options, a qouted newline and then the map entry without the key. 
> Fine. Would be nice if this information could be integrated into the man 
> pages as well. However what about my --bind paramter (alltough it turned out 
> that I probably do not need it)? Could it be given in the first line, i.e 
> does autofs treat the first line somwhat different to allow options like 

Point taken. Bug me if you don't see anything in the next release please.

The code which handles the option parsing is a bit ugly so I'd have to 
have a look, as options are generally passed starting with a single "-". 
However the bind mount is always attempted first. Thinking about it I 
think the code does check for "--". But does it handle the space....

Ian
