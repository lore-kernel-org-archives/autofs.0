From: Avi Kivity <avi@redhat.com>
Subject: Re: autofs4 hang in 2.6.37-rc1
Date: Mon, 15 Nov 2010 15:27:21 +0200
Message-ID: <4CE13539.1020106@redhat.com>
References: <4CDFDC2B.6040205@redhat.com> <4CE00194.3070601@redhat.com>	 <1289785533.3248.18.camel@localhost>  <201011150954.34289.arnd@arndb.de> <1289827341.3248.49.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1289827341.3248.49.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: Arnd Bergmann <arnd@arndb.de>, autofs@linux.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

On 11/15/2010 03:22 PM, Ian Kent wrote:
> >  Ian, if you can prove that the lock is not needed, I think we shold
> >  just remove it.
>
> I don't think I can prove it but I will have a long look at the code.
> I don't think it is needed and I expect I'll recommend it be removed.

I've been running with the lock removed for a while with no ill effect.  
Of course it doesn't prove anything but at least it's a workaround for me.

-- 
error compiling committee.c: too many arguments to function
