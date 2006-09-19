From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - zero timeout prevents shutdown
Date: Tue, 19 Sep 2006 12:33:52 +0800
Message-ID: <1158640433.3003.20.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
	 <20060918211123.84e583cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20060918211123.84e583cf.akpm@osdl.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Mon, 2006-09-18 at 21:11 -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 11:48:15 +0800 (WST)
> Ian Kent <raven@themaw.net> wrote:
> 
> > If the timeout of an autofs mount is set to zero then umounts
> > are disabled. This works fine, however the kernel module checks
> > the expire timeout and goes no further if it is zero. This is
> > not the right thing to do at shutdown as the module is passed
> > an option to expire mounts regardless of their timeout setting.
> 
> Is this a new feature, or a regression since <when>?

It's a regression which I must have introduced a long time ago. I can go
back and check the kernels if you'd like more specific info.

It should work this way and a recent report alerted me to it.

Ian



