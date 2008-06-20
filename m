From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] autofs4 - add missing kfree
Date: Fri, 20 Jun 2008 09:02:32 -0400
Message-ID: <x49ej6stg2f.fsf@segfault.boston.devel.redhat.com>
References: <20080620070923.17224.33149.stgit@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080620070923.17224.33149.stgit@raven.themaw.net> (Ian Kent's
	message of "Fri, 20 Jun 2008 15:09:25 +0800")
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent <raven@themaw.net> writes:

> It see that the patch tittled "autofs4 - fix pending mount race" is
> missing a change that I had recently made.
>
> It's missing a kfree for the case mutex_lock_interruptible() fails
> to aquire the wait queue mutex.

Yeah, missed that in the translation to the embedded qstr.

> Ian
>
> Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
