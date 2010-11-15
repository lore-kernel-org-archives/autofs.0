From: Avi Kivity <avi@redhat.com>
Subject: Re: autofs4 hang in 2.6.37-rc1
Date: Mon, 15 Nov 2010 11:02:11 +0200
Message-ID: <4CE0F713.8090503@redhat.com>
References: <4CDFDC2B.6040205@redhat.com> <4CDFE948.4020709@redhat.com>	 <201011141615.32166.arnd@arndb.de> <1289784674.3248.11.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1289784674.3248.11.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Arnd Bergmann <arnd@arndb.de>, autofs@linux.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On 11/15/2010 03:31 AM, Ian Kent wrote:
> >
> >  If the ioctl can sleep for multiple seconds, the mutex should
> >  indeed be dropped, and that would be safe because we used to
> >  do the same with the BKL.
> >
> >  The question is why this would sleep for more than 120 seconds.
>
> umount against a server that isn't responding can easily take more than
> 2 minutes.

Well, in my setup, the server should be responding.

-- 
error compiling committee.c: too many arguments to function
