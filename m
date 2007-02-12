From: Olivier Galibert <galibert@pobox.com>
Subject: Re: [PATCH 1/2] Re: [autofs] Bad race condition in the new autofs protocol somewhere
Date: Mon, 12 Feb 2007 14:57:49 +0100
Message-ID: <20070212135749.GA1681@dspnet.fr.eu.org>
References: <20070207173414.GA64492@dspnet.fr.eu.org> <1170871661.3415.36.camel@raven.themaw.net> <20070207181817.GA75717@dspnet.fr.eu.org> <1170901990.3383.18.camel@raven.themaw.net> <1171262594.18376.13.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964924AbXBLN5x@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1171262594.18376.13.camel@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

On Mon, Feb 12, 2007 at 03:43:14PM +0900, Ian Kent wrote:
> On Thu, 2007-02-08 at 11:33 +0900, Ian Kent wrote:
> > On Wed, 2007-02-07 at 19:18 +0100, Olivier Galibert wrote:
> > > On Thu, Feb 08, 2007 at 03:07:41AM +0900, Ian Kent wrote:
> > > > It may be better to update to a later kernel so I don't have to port the
> > > > patch to several different kernels. Is that possible?
> > > 
> > > Sure, 2.6.20 or -git?
> > 
> > 2.6.20 has all the patches I've proposed so far except for the one we're
> > working on so that would be best for me.
> > 
> > Seems there may still be a problem with the patch so I'll let you know
> > what's happening as soon as I can.
> 
> I think I'm just about done.
> 
> Could you try using the two patches here against 2.6.20 please:

The patch works beautifully, no more failures with my test rig, until
the point where the kernel crashes.  Since the crashes happen without
the patch too, you're off the hook, but that means I can't deploy it
for harsher testing yet.

No wonder Dave Jones is prudent about updating kernels in fc :-)

  OG.
