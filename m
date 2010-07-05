From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Mon, 5 Jul 2010 21:48:01 +0200
Message-ID: <20100705194759.GE5240@nowhere>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <1278195310-25590-4-git-send-email-arnd@arndb.de> <20100705192358.GC5240@nowhere> <4C3235C3.7050303@zytor.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=N+NTsVrrp6X1MyJptDG4GdlVy8W4efRjTZFyw/dfr1s=;
        b=QOcMBsstVXJvUvHcviDzkCLr75X4aOkrH66OQ/TqXF0so7ipPszmkTtbxqRzgd7CUm
         5Csol4lSzI7Y8dwIzxy0RzXAwFLkwW6lzarOJPDN9JLL5iIcodPqYDHS8HeX/GuHpOUV
         uji1jCdC3BhlLmzXSQDYoU/V5C/OH7uu753ms=
Content-Disposition: inline
In-Reply-To: <4C3235C3.7050303@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

On Mon, Jul 05, 2010 at 12:42:59PM -0700, H. Peter Anvin wrote:
> On 07/05/2010 12:24 PM, Frederic Weisbecker wrote:
> > On Sun, Jul 04, 2010 at 12:15:07AM +0200, Arnd Bergmann wrote:
> >> Handling of autofs ioctl numbers does not need to be generic
> >> and can easily be done directly in autofs itself.
> >>
> >> This also pushes the BKL into autofs and autofs4 ioctl
> >> methods.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Cc: H. Peter Anvin <hpa@zytor.com>
> > 
> > Peter, if you're fine with this version. May I apply it?
> > Unless you have a tree for autofs.
> > 
> > Thanks.
> 
> Ian Kent is the maintainer of autofs4 and patches for autofs4 should go
> through him (or acked by him.)
> 
> autofs 3 is officially unmaintained; I'm more than happy to have you
> push the autofs 3 bits of this patch.


Sure, I can split up the patch and integrate the autofs 3 part, I'll send
the standalone autofs4 version to Ian.

Thanks.
