From: Ian Kent <raven@themaw.net>
Subject: Re: [autofs] [PATCH] autofs4: reinstate negatitive timeout of
	mount fails
Date: Wed, 22 Aug 2007 11:27:42 +0800
Message-ID: <1187753262.3899.13.camel@raven.themaw.net>
References: <1187688369.3318.12.camel@raven.themaw.net>
	 <20070821131551.4026fb96.akpm@linux-foundation.org>
	 <1187751415.3899.9.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756468AbXHVD2A@vger.kernel.org>
In-Reply-To: <1187751415.3899.9.camel@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 2007-08-22 at 10:56 +0800, Ian Kent wrote:
> On Tue, 2007-08-21 at 13:15 -0700, Andrew Morton wrote:
> > 
> > It seems to use a lot of list_for_each[_safe] which could
> > have been coded as list_for_each_entry[_safe], btw.
> 
> Mmm .. good point. I've not noticed the list_for_each_entry* macros.

A good idea but that change would cover more than just this patch so I'd
rather leave the patch as is and submit a cleanup patch to cover this
later.

Ian

