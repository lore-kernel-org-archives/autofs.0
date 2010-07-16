From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 3/6] autofs/autofs4: move compat_ioctl handling into fs
Date: Fri, 16 Jul 2010 02:14:03 +0200
Message-ID: <AANLkTimVzSzCl2XfWBg5HauYtIT5znxkm6M0yo_1en2b@mail.gmail.com>
References: <1278195310-25590-1-git-send-email-arnd@arndb.de>
	<20100705195837.GF5240@nowhere>
	<1278378690.3070.6.camel@localhost>
	<201007061335.00264.arnd@arndb.de>
	<202899B0-BADE-4CD0-B0E4-1A2FC99397D6@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y+qKU+w6Jy9eTOhswIR6ao46POuY7UK30s+ffravFDM=;
        b=J/KUfM68JYpKfAm03RDVh+sAla1wexkb19+AbKQaaXtXZcsLvYZ3oSkgOhdDW+z5uy
         xHF52h5OV0E6DhHyQnBVvm6H34kYKgUJBxHc4A4Cu+6wBwn2zjgKaYalJ5sDMLrCTlZs
         UStySd5SklEN2i7uvB3wV78GO7C8AdmlYqHSU=
In-Reply-To: <202899B0-BADE-4CD0-B0E4-1A2FC99397D6@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, "autofs@linux.kernel.org" <autofs@linux.kernel.org>

2010/7/6 Ian Kent <raven@themaw.net>:
>
>
> On 06/07/2010, at 7:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>>
>> Well, the only use of the BKL in autofs4 is in the ioctl function. You
>> can probably replace that trivially with a global mutex, but from a quick
>> inspection, even that should not be needed: The only ioctl command in
>> autofs4 that does not already seem to have adequate locking is
>> autofs4_get_set_timeout, which is even easier to change and still harmless
>> if you don't do it at all.
>
> That's right of course.
>
> Even this shouldn't be a problem as it is called by a single instance, per autofs mount, of the daemon only. A fair amount of effort has gone into trying to make the autofs4 module independent of the BKL over time. However I would still rather not do the change concurrently with the ioctl changes.
>
> Ian


In any case, can we let you handle this patch for 2.6.36 inclusion?

Thanks.
