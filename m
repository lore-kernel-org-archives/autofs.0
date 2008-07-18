From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 7/7] autofs4 - remove unused ioctls
Date: Fri, 18 Jul 2008 16:09:48 -0400
Message-ID: <x497ibjc5tf.fsf@segfault.boston.devel.redhat.com>
References: <20080718023651.12802.59107.stgit@raven.themaw.net>
	<20080718023751.12802.96268.stgit@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080718023751.12802.96268.stgit@raven.themaw.net> (Ian Kent's
	message of "Fri, 18 Jul 2008 10:37:52 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

Ian Kent <raven@themaw.net> writes:

> The ioctls AUTOFS_IOC_TOGGLEREGHOST and AUTOFS_IOC_ASKREGHOST were
> added several years ago but what they were intended for has never
> been implemented (as far as I'm aware noone uses them) so remove them.

Yeah, the only other consumer of the autofs interfaces (that I know) is
autodir, and that doesn't use the reghost ioctls.

> Signed-off-by: Ian Kent <raven@themaw.net>

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
