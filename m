From: raven@themaw.net
Subject: Re: PATCH - 2.6.6-bk3 autofs4 DPRINTK cleanup
Date: Mon, 17 May 2004 18:47:05 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405171846110.8844@donald.themaw.net>
References: <1084753980.21164.6.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0405170954280.10453@wombat.indigo.net.au>
 <1084769470.21217.11.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1084769470.21217.11.camel@localhost.localdomain>
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
To: Joe Perches <joe@perches.com>
Cc: autofs@linux.kernel.org, jeremy@goop.org

On Sun, 16 May 2004, Joe Perches wrote:

> On Sun, 2004-05-16 at 19:04, Ian Kent wrote:
> > Hi Joe,
> > 
> > Why are you removing the function names from the printks?
> 
> Hi Kent.

That's Ian please.

> 
> The function names were moved to the DPRINTK macro itself
> so they can't be out of date again.

Cool. I stand corrected.

Ian
