From: Ian Kent <raven@themaw.net>
Subject: Re: statfs() and autofs
Date: Mon, 21 Jul 2008 13:12:37 +0800
Message-ID: <1216617158.3093.16.camel@raven.themaw.net>
References: <20080715204839.GU5858@pixar.com>
	<1216179794.22783.46.camel@raven.themaw.net>
	<487D855B.8000405@loran.name>
	<Pine.LNX.4.64.0807201441330.3491@simba.math.ucla.edu>
	<20080721034112.GU5858@pixar.com>
	<1216615194.3093.8.camel@raven.themaw.net>
	<20080721050059.GW5858@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080721050059.GW5858@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org


On Sun, 2008-07-20 at 22:00 -0700, Chris Walker wrote:
> From raven [07/20 21:43]:
> > Just to be absolutely clear.
> > 
> > The "browse" or "--ghost option isn't being used, in oder to avoid mount
> > storms, but we still see stat(2) and statfs(2) (et. al.) not wait for a
> > mount to complete.
> > 
> > Is that right?
> > Is anyone in a position to test a kernel patch?
> 
> This is what I'm seeing and I'm only running automount with the --debug
> option. If I don't pass --ghost to automount, is there any other way
> browsing is enabled?

Depends on version.

Version 5 will honor the "browse" option in shared maps, essentially
causing indirect mounts to have "--ghost" option.

Ian
