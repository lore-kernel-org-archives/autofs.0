From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] Make stat/lstat/fstatat pass AT_NO_AUTOMOUNT to
 vfs_statx()
Date: Fri, 5 May 2017 00:53:27 +0100
Message-ID: <20170504235326.GL29622@ZenIV.linux.org.uk>
References: <149393701678.21194.2478177197944898836.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <149393701678.21194.2478177197944898836.stgit@warthog.procyon.org.uk>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: torvalds@linux-foundation.org, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>

On Thu, May 04, 2017 at 11:30:16PM +0100, David Howells wrote:
> stat/lstat/fstatat need to pass AT_NO_AUTOMOUNT to vfs_statx() as the
> pre-statx code didn't set LOOKUP_AUTOMOUNT, even though fstatat() accepted
> the AT_NO_AUTOMOUNT flag.

Applied.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
