From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
Date: Fri, 23 Jun 2006 14:43:59 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0606231434480.15807@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060620233941.49ba2223.akpm@osdl.org> <Pine.LNX.4.64.0606231159540.2904@raven.themaw.net>
 <20060622213050.fc753e91.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20060622213050.fc753e91.akpm@osdl.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Andrew Morton wrote:

> On Fri, 23 Jun 2006 12:14:09 +0800 (WST)
> Ian Kent <raven@themaw.net> wrote:
> 
> > > 
> > > Also, did you consider broadening the ->d_revalidate() semantics?  It
> > > appears that all implementations return 0 or 1.  You could teach the VFS to
> > > also recognise and act upon a -ve return value, and do this trickery within
> > > the autofs d_revalidate(), perhaps?
> > > 
> > 
> > Yep and I've now done this.
> > I think this is in fact the only way to do it.
> 
> Below is the combined patch for reviewing purposes.
> 
> Removing that __always_inline saves 30-odd bytes.  I suspect that removing
> it would be a performance loss in this case.  But I'll make it just
> `inline' because __always_inline is peculiar, and people will wonder what's
> special about this function.
> 

Thanks Andrew.
The combined diff is exactly what I'm trying to achieve.

I marked the function __always_inline because several other functions 
that appear to be frequently called from this code path are also declared 
this way. Hopefully someone with more experience of this area of the VFS 
will recommend the best choice.

Ian

