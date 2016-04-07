From: Omar Sandoval <osandov@osandov.com>
Subject: Re: Autofs and mount namespaces
Date: Thu, 7 Apr 2016 12:42:35 -0700
Message-ID: <20160407194235.GA18275@vader>
References: <20160407181911.GA9018@vader>
 <201604080354.YGshLn7u%fengguang.wu@intel.com>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+uEU2bWZTrhzVWmfl5K+BE8b08TXDV1zjm/wzyOr+1E=;
        b=Z3tUIzpGXydhVHc6ZJsXSCjw/ag/YW5ZnHD8Yl1PEby5t3DQUbOYvuvLm0hN1tvr4A
         Si5B6ktcZc/tdN94Vvpdz9KDPq7DqFmcRpIoTF7gpQw9GaO4HPdaLJyzQY5A/90UksdB
         NDQ2Lk3b2+goxppx0SZR4u5FoktKINHR/XYQuiXYgqQ9w1735whMMX0899/Y5dU2ag5N
         cC4tWCe5wvTiGK6ZMaBmLf+8XVvALqJWuq8FrBGuXHcSkAiKX5J4ArCBU3PJLroctHQQ
         xXEzlZjuW84Ah73SKg3wALR1vvblGAL62Z5XiWcb/DeDZuCbdpPXrq1iqKbudaJ1NdKV
         3Oww==
Content-Disposition: inline
In-Reply-To: <201604080354.YGshLn7u%fengguang.wu@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ian Kent <raven@themaw.net>, autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com

On Fri, Apr 08, 2016 at 03:08:42AM +0800, kbuild test robot wrote:
> Hi Omar,
> 
> [auto build test ERROR on v4.6-rc2]
> [also build test ERROR on next-20160407]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Omar-Sandoval/Autofs-and-mount-namespaces/20160408-022034
> config: i386-randconfig-i0-201614 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "lookup_mnt" [fs/autofs4/autofs4.ko] undefined!
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


Oh, yeah, that needs an EXPORT_SYMBOL(lookup_mnt).

-- 
Omar
