From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Sat, 10 Jan 2004 13:56:47 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0401101347210.2403-100000@wombat.indigo.net.au>
References: <Pine.LNX.4.53.0401091249250.9335@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0401091249250.9335@simba.math.ucla.edu>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Carter <jimc@math.ucla.edu>
Cc: Mike Waychison <Michael.Waychison@sun.com>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, 9 Jan 2004, Jim Carter wrote:

> On Sat, 10 Jan 2004, Ian Kent wrote:
> > On Thu, 8 Jan 2004, Mike Waychison wrote:
> > > This module will have its own new autofs module (hopefully named
> > > something other than autofs to avoid confusion/mishaps).  The VFS will
>
> autofs v3 -> autofs.o
> autofs v4 -> autofs4.o
> May I suggest autofs5.o?  It should still be named "autofs-something",
> after all.
>

Nop. I will continue to develop under the v4 banner. As far as I'm
concerned Peter Anvin has claimed v5 and I don't want to challenge that.
Mike Waychisons' initiative may possibly be called v6???

In any case the module works fine with v3 and v4 (I haven't tested
4.0.0pre10 for a while though). The 4.1 daemon detects the enhanced module
if present. It is currently dubed 4.04. The 'plays well with others' is a
self imposed design requirement.

Ian

