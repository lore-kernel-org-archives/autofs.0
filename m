From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/3] autofs: add ignore mount option
Date: Wed, 30 Jan 2019 04:18:28 +0000
Message-ID: <20190130041827.GI2217@ZenIV.linux.org.uk>
References: <154725122396.11260.16053424107144453867.stgit@pluto-themaw-net>
 <154725123970.11260.6113771566924907275.stgit@pluto-themaw-net>
 <20190129171622.5b75f794d2b1e4d1055331eb@linux-foundation.org>
 <553f4a0daf09407371193d7d4782a759561a626a.camel@themaw.net>
 <804b86df6fd678147da816be038b11c87333b23f.camel@themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <804b86df6fd678147da816be038b11c87333b23f.camel@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jan 30, 2019 at 10:44:15AM +0800, Ian Kent wrote:

> Al,
> 
> On a different note the above request also raised another
> question about statvfs(3) automount behaviour.
> 
> In glibc statvfs(3) uses statfs(2) and translates the return
> to a statvfs structure.
> 
> I wasn't aware but apparently statvfs(3) (and presumably statfs(2))
> doesn't trigger an automount on Solaris whereas we do. I think
> statfs() is probably the only exception to the convention that
> stat family system calls don't trigger an automount.
> 
> So far I've said that this is a long standing behaviour in the
> Linux kernel and changing it could lead to unpleasant surprises
> for those that have come to expect this behaviour so such a change
> would not be well received.
> 
> But I do need to ask your opinion, so what are your thoughts about
> changing this?

Probably should've done it that way, but I'm afraid it's much too
late by now...
