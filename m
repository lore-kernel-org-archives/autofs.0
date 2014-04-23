From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] autofs - fix lockref lookup
Date: Wed, 23 Apr 2014 14:46:24 -0700
Message-ID: <20140423144624.716f325d454f9debd97bef15@linux-foundation.org>
References: <20140423052035.5999.69412.stgit@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140423052035.5999.69412.stgit@perseus.fritz.box>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 23 Apr 2014 13:20:36 +0800 Ian Kent <raven@themaw.net> wrote:

> autofs needs to be able to see private data dentry flags for
> its dentrys that are being created but not yet hashed and for
> its dentys that have been rmdir()ed but not yet freed. It
> needs to do this so it can block processes in these states
> until a status has been returned to indicate the given
> operation is complete.
> 
> It does this by keeping two lists, active and expring, of
> dentrys in this state and uses ->d_release() to keep them
> stable while it checks the reference count to determine
> if they should be used.
> 
> But with the recent lockref changes dentrys being freed
> sometimes don't transition to a reference count of 0 before
> being freed so autofs can occassionally use a dentry that
> is invalid which can lead to a panic.

What's the value of "recent"?  I assume 3.14 is OK?
