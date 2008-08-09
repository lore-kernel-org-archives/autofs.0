From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] autofs4 - cleanup autofs mount type usage
Date: Sat, 9 Aug 2008 08:47:39 -0400
Message-ID: <20080809124739.GA16308@infradead.org>
References: <20080807114002.4142.30417.stgit@web.messagingengine.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080807114002.4142.30417.stgit@web.messagingengine.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Thu, Aug 07, 2008 at 07:40:06PM +0800, Ian Kent wrote:
> Usage of the AUTOFS_TYPE_* defines is a little confusing and
> appears inconsistent.

Not enough of an explanation for this patch.

It does:

 - move AUTOFS_TYPE_INDIRECT/AUTOFS_TYPE_DIRECT/AUTOFS_TYPE_OFFSET
   to include/linux/auto_fs4.h.  Obviously okay but should mentioned
   in the changelog.
 - add a new, unused AUTOFS_TYPE_ANY constant. Why?
 - add a new AUTOFS_TYPE_TRIGGER and use it instead of
   AUTOFS_TYPE_DIRECT or in one single case
   (AUTOFS_TYPE_DIRECT|AUTOFS_TYPE_OFFSET).  Definitively needs a good
   explanation.
 - replaces one use of sbi->type = 0 with AUTOFS_TYPE_INDIRECT (0x0001).
   Why?
