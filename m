From: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 3/4] autofs - make mountpoint checks namespace aware
Date: Fri, 16 Sep 2016 14:14:57 -0700
Message-ID: <20160916211457.GA18830@vader.DHCP.thefacebook.com>
References: <20160914061434.24714.490.stgit@pluto.themaw.net>
 <20160914061445.24714.68331.stgit@pluto.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpY4ulnkqsChm5kVZckq14481GPY78p4FTt30QBUp2Y=;
        b=j8VeM1jNz+O8Ou8sP5yEalFrbv1biv/GvslSBRwbNfXqJDPgY7/6fZIzSsaR8zFo9W
         caJxiEgTj1sBSI2ReOs/dwPt/o5prjq1mwtplU1iqcb+JEDWLgYDRrdWBEFcBE86lw3H
         1ywQ/0QQ1Jems5+n/JdzuKHQymAuQ/ilYAcgRXcVkSoi9d5cJ54dHjHn+zkZvFz6ElFY
         gR1NdTW4nJ7o47uNmnc587ZO0uXE9b5NUj3QcTCtJsufqxi6GqUGcVK3lAE9B9BbbSPl
         NarY5MPDK4aMSZdcXB89Pr/7hUaKiT5zhRVtQbEK+FL7nYNdZVFGqaTZG1/iYbbVKTMI
         iXpQ==
Content-Disposition: inline
In-Reply-To: <20160914061445.24714.68331.stgit@pluto.themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kernel-team@fb.com

On Wed, Sep 14, 2016 at 02:14:45PM +0800, Ian Kent wrote:
> If an automount mount is clone(2)ed into a file system that is
> propagation private, when it later expires in the originating
> namespace subsequent calls to autofs ->d_automount() for that
> dentry in the original namespace will return ELOOP until the
> mount is manually umounted in the cloned namespace.
> 
> In the same way, if an autofs mount is triggered by automount(8)
> running within a container the dentry will be seen as mounted in
> the root init namespace and calls to ->d_automount() in that namespace
> will return ELOOP until the mount is umounted within the container.
> 
> Also, have_submounts() can return an incorect result when a mount
> exists in a namespace other than the one being checked.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Al Viro <viro@ZenIV.linux.org.uk>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Omar Sandoval <osandov@osandov.com>

I can confirm that this fixes my repro and hasn't caused any other
problems as far as I can tell.

Tested-by: Omar Sandoval <osandov@fb.com>

-- 
Omar
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
