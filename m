From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs4: reinstate negatitive timeout of mount fails
Date: Tue, 21 Aug 2007 13:15:51 -0700
Message-ID: <20070821131551.4026fb96.akpm@linux-foundation.org>
References: <1187688369.3318.12.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752954AbXHUUQU@vger.kernel.org>
In-Reply-To: <1187688369.3318.12.camel@raven.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>

On Tue, 21 Aug 2007 17:26:09 +0800
Ian Kent <raven@themaw.net> wrote:

> Due to a change to fs/dcache.c:d_lookup() in the 2.6 kernel whereby only
> hashed dentrys are returned the negative caching of mount failures
> stopped working in the autofs4 module for nobrowse mount (ie. directory
> created at mount time and removed at umount or following a mount
> failure).
> 
> This patch keeps track of the dentrys from mount fails in order to be
> able check the timeout since the last fail and return the appropriate
> status. In addition the timeout value is settable at load time as a
> module option and via sysfs using the module
> parameter /sys/module/autofs4/parameters/negative_timeout.

Boy, that's a complex-looking patch.  I think I'll sit on this one
for 2.6.24 ;)

It seems to use a lot of list_for_each[_safe] which could
have been coded as list_for_each_entry[_safe], btw.
