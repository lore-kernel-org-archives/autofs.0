From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Mon, 05 Jul 2010 12:42:59 -0700
Message-ID: <4C3235C3.7050303@zytor.com>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de> <1278195310-25590-4-git-send-email-arnd@arndb.de> <20100705192358.GC5240@nowhere>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100705192358.GC5240@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, autofs@linux.kernel.org

On 07/05/2010 12:24 PM, Frederic Weisbecker wrote:
> On Sun, Jul 04, 2010 at 12:15:07AM +0200, Arnd Bergmann wrote:
>> Handling of autofs ioctl numbers does not need to be generic
>> and can easily be done directly in autofs itself.
>>
>> This also pushes the BKL into autofs and autofs4 ioctl
>> methods.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: H. Peter Anvin <hpa@zytor.com>
> 
> Peter, if you're fine with this version. May I apply it?
> Unless you have a tree for autofs.
> 
> Thanks.

Ian Kent is the maintainer of autofs4 and patches for autofs4 should go
through him (or acked by him.)

autofs 3 is officially unmaintained; I'm more than happy to have you
push the autofs 3 bits of this patch.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
