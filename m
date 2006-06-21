From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
Date: Wed, 21 Jun 2006 13:25:23 +0100
Message-ID: <20060621122523.GX27946@ftp.linux.org.uk>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200606210618.k5L6IFDr008176@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: akpm@osdl.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 02:18:15PM +0800, Ian Kent wrote:
> While this problem has been present for a long time I've avoided resolving 
> it because it was not very visible. But now that autofs v5 has "mount and 
> expire on demand" of nested multiple mounts, such as is found when 
> mounting an export list from a server, solving the problem cannot be 
> avoided any longer.
> 
> I've tried very hard to find a way to do this entirely within the 
> autofs4 module but have not been able to find a satisfactory way to 
> achieve it.
> 
> So, I need to propose a change to the VFS.

NAK in that form.  Care to explain what should happen to mount tree
when you do that to mountpoint?
