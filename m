From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] autofs4 - zero timeout prevents shutdown
Date: Mon, 18 Sep 2006 21:11:23 -0700
Message-ID: <20060918211123.84e583cf.akpm@osdl.org>
References: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, 19 Sep 2006 11:48:15 +0800 (WST)
Ian Kent <raven@themaw.net> wrote:

> If the timeout of an autofs mount is set to zero then umounts
> are disabled. This works fine, however the kernel module checks
> the expire timeout and goes no further if it is zero. This is
> not the right thing to do at shutdown as the module is passed
> an option to expire mounts regardless of their timeout setting.

Is this a new feature, or a regression since <when>?

Thanks.
