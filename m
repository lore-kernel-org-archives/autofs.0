From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] Bad race condition in the new autofs protocol
	somewhere
Date: Thu, 08 Feb 2007 11:33:10 +0900
Message-ID: <1170901990.3383.18.camel@raven.themaw.net>
References: <20070207173414.GA64492@dspnet.fr.eu.org>
	 <1170871661.3415.36.camel@raven.themaw.net>
	 <20070207181817.GA75717@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422902AbXBHCcc@vger.kernel.org>
In-Reply-To: <20070207181817.GA75717@dspnet.fr.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

On Wed, 2007-02-07 at 19:18 +0100, Olivier Galibert wrote:
> On Thu, Feb 08, 2007 at 03:07:41AM +0900, Ian Kent wrote:
> > It may be better to update to a later kernel so I don't have to port the
> > patch to several different kernels. Is that possible?
> 
> Sure, 2.6.20 or -git?

2.6.20 has all the patches I've proposed so far except for the one we're
working on so that would be best for me.

Seems there may still be a problem with the patch so I'll let you know
what's happening as soon as I can.

Ian

