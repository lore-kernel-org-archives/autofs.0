From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] autofs4 - fix infamous "Busy inodes after umount ..." message.
Date: Sun, 24 Jul 2005 12:48:28 +0200
Message-ID: <200507241248.29501.agruen@suse.de>
References: <Pine.LNX.4.63.0507241000120.2330@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0507241000120.2330@donald.themaw.net>
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Edwards <edwardsg@sgi.com>, Greg Banks <gnb@sgi.com>

Hi Ian,

On Sunday 24 July 2005 04:12, Ian Kent wrote:
> If the automount daemon receives a signal which causes it to sumarily
> terminate the autofs4 module leaks dentries. The same problem exists with
> detached mount requests without the warning.
>
> This patch cleans these dentries at umount.

thanks for working on this. For credits, SGI reported this bug, helped with 
debugging, and verified the fix.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH
