From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 8 Jan 2004 20:35:07 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0401082026340.354-100000@donald.themaw.net>
References: <3FFC8E5B.40203@sun.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <3FFC8E5B.40203@sun.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 7 Jan 2004, Mike Waychison wrote:

>
> This is a good example of why this stuff should probably be merged into
> VFS,  autofs4 has yet to be updated to use this lock.  This comes with
> the decision to a) no longer support it as a module, only built in, or
> b) make vfsmount_lock accessible to modules.

Please don't say it this way.

A new implementation may mean current autofs becomes depricated but
this is a deprecation process, not a slash and burn, and needs to be
managed.

Ian

