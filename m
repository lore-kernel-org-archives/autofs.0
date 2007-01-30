From: Ian Kent <raven@themaw.net>
Subject: Re: Race condition in autofs 4.1.4
Date: Tue, 30 Jan 2007 16:20:35 +0900
Message-ID: <1170141635.3373.5.camel@raven.themaw.net>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven> <1169835048.6781.16.camel@localhost>
	<1169861439.3595.11.camel@raven.themaw.net>
	<1170081194.2817.6.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170083944.2817.10.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1170089728.3404.18.camel@raven.themaw.net>
	<1170104185.6774.11.camel@localhost>
	<x49zm81czgq.fsf@segfault.boston.devel.redhat.com>
	<1170105687.6774.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1170105687.6774.17.camel@localhost>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Mon, 2007-01-29 at 22:21 +0100, Lukas Kolbe wrote:
> On Mo, 2007-01-29 at 16:09 -0500, Jeff Moyer wrote:
> 
> > I don't mean to muddy the waters, but you might try adding the patch
> > below to autofs.  I posted it a while back, but Ian's been busy with
> > v5 development.  This is from my git tree, so I'm not sure if it
> > applies to current v4 as is.
> 
> Thanks, I'll try it tomorrow. Seems reasonable to me.

Yep, Jeffs patch should work fine and you may not need to patch mount(8)
when using it.

Alas, while I can do that for v5 I'm concerned about the possible
performance impact it could have.

Ian
