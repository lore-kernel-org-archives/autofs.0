From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Mon, 5 Jul 2010 21:24:06 +0200
Message-ID: <20100705192358.GC5240@nowhere>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <1278195310-25590-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=oSySAozufVkAv5BcTjulfhBHqcu7WL5c5X9IzQSC3Xc=;
        b=htcXstiB54frJoFiOSo+anGRJsRdTieo8DW2ayHAd99Qu+lH9LtzlWHWdK5qkrgjM3
         PE83CRBtbBSN6GDCTOLNHcG+IOWPn4GJnBkNGBuGY5tj7GLLcf1G7Z9h2ktEN94O+TA+
         LCUsGHkTMGUQvfzU+0t6j8auTIrhtq7Jaq7aI=
Content-Disposition: inline
In-Reply-To: <1278195310-25590-4-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

On Sun, Jul 04, 2010 at 12:15:07AM +0200, Arnd Bergmann wrote:
> Handling of autofs ioctl numbers does not need to be generic
> and can easily be done directly in autofs itself.
> 
> This also pushes the BKL into autofs and autofs4 ioctl
> methods.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: H. Peter Anvin <hpa@zytor.com>



Peter, if you're fine with this version. May I apply it?
Unless you have a tree for autofs.

Thanks.
