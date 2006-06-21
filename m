From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
Date: Wed, 21 Jun 2006 21:39:25 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606212135540.14481@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060620233941.49ba2223.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20060620233941.49ba2223.akpm@osdl.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 20 Jun 2006, Andrew Morton wrote:

> 
> Also, did you consider broadening the ->d_revalidate() semantics?  It
> appears that all implementations return 0 or 1.  You could teach the VFS to
> also recognise and act upon a -ve return value, and do this trickery within
> the autofs d_revalidate(), perhaps?
> 

Now it occurs to me this is the only safe way to do this.
And a lot simpler.

Al, given this is such a heavily traveled piece of code, do you think 
it would be acceptable to change the semantics of revalidate in this way.

Ian

