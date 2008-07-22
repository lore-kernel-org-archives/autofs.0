From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] autofs4 - use struct qstr in waitq.c
Date: Tue, 22 Jul 2008 16:13:57 -0700
Message-ID: <20080722161357.802ad1a5.akpm@linux-foundation.org>
References: <20080617122336.14725.64829.stgit@raven.themaw.net>
	<20080617122406.14725.84758.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20080617122406.14725.84758.stgit@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: linux-kernel@vger.kernel.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>

On Tue, 17 Jun 2008 20:24:06 +0800
Ian Kent <raven@themaw.net> wrote:

> From: Jeff Moyer <jmoyer@redhat.com>
> 
> The autofs_wait_queue already contains all of the fields of the
> struct qstr, so change it into a qstr.
> 
> This patch, from Jeff Moyer, has been modified a liitle by myself.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> Signed-off-by: Ian Kent <raven@themaw.net>

So this patch which had been happily sitting in -mm for a month has
suddenly broken because linux-next's three-day-old
4bce7ce7c7d0d57b78dacc3a2bd87ec63b2d9b4c has removed LOOKUP_ACCESS.

This is suboptimal.

Now what do I do?
