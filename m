From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] autofs4 - use lookup access intent to support
	recursive bind mounts
Date: Mon, 28 Apr 2008 15:53:40 +0800
Message-ID: <1209369220.3243.18.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0804281410160.10684@raven.themaw.net>
	 <20080428062213.GB5882@ZenIV.linux.org.uk>
	 <1209364705.3243.1.camel@raven.themaw.net>
	 <20080428070514.GC5882@ZenIV.linux.org.uk>
	 <1209367536.3243.16.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1209367536.3243.16.camel@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>


On Mon, 2008-04-28 at 15:25 +0800, Ian Kent wrote:
> > ->lookup() and friends are going to stop getting struct nameidata *.
> > ->follow_link() obviously will keep it; ->d_revalidate() should
> > lose the sucker, but we might have to split it in two methods (which
> > is probably what'll be needed in your case).
> 
> Right.

Would it be sensible to use dentry->d_flags for this purpose?
Ian


