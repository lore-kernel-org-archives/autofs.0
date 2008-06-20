From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] autofs4 - detect invalid direct mount requests
Date: Fri, 20 Jun 2008 09:00:20 -0400
Message-ID: <x49iqw4tg63.fsf@segfault.boston.devel.redhat.com>
References: <20080620051301.9988.94307.stgit@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753895AbYFTNBY@vger.kernel.org>
In-Reply-To: <20080620051301.9988.94307.stgit@raven.themaw.net> (Ian Kent's
	message of "Fri, 20 Jun 2008 13:13:03 +0800")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

Ian Kent <raven@themaw.net> writes:

> autofs v5 dierct and offset mounts within an autofs filesystem are
> triggered by existing autofs triger mounts so the mount point dentry
> must be positive. If the mount point dentry is negative then the
> trigger doesn't exist so we can return fail immediately.

What are the conditions that lead us here in that case?

-Jeff
