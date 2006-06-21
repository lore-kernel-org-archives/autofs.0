From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
Date: Wed, 21 Jun 2006 21:05:40 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606212103080.14481@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060621122523.GX27946@ftp.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20060621122523.GX27946@ftp.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ftp.linux.org.uk>
Cc: akpm@osdl.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Al Viro wrote:

> On Wed, Jun 21, 2006 at 02:18:15PM +0800, Ian Kent wrote:
> > While this problem has been present for a long time I've avoided resolving 
> > it because it was not very visible. But now that autofs v5 has "mount and 
> > expire on demand" of nested multiple mounts, such as is found when 
> > mounting an export list from a server, solving the problem cannot be 
> > avoided any longer.
> > 
> > I've tried very hard to find a way to do this entirely within the 
> > autofs4 module but have not been able to find a satisfactory way to 
> > achieve it.
> > 
> > So, I need to propose a change to the VFS.
> 
> NAK in that form.  Care to explain what should happen to mount tree
> when you do that to mountpoint?
> 

The flag is never set if it a mount succeeds so there's never a tree under 
it. But that's only my usage, so point taken.

Thinking about it that's not the only potential problem either.

Ian

