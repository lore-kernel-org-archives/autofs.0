From: SeongJae Park <sj38.park@gmail.com>
Subject: Re: [PATCH 0/5] Fix dead URLs to ftp.kernel.org
Date: Mon, 27 Mar 2017 21:42:48 +0900
Message-ID: <CAEjAshqR0Nhp4Wkmkg_HrswsiuUb3rYJ=TOUSBSvoUT3FSWTjg@mail.gmail.com>
References: <20170327054731.31882-1-sj38.park@gmail.com> <fabba6b8-8f8d-8f8f-1660-c579e6515563@suse.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yw0wMaLrC9rDCtb4vltN86w6GHN8/SEmF/dQ7VzQcZ0=;
        b=bNoF12JWj2QhJ/El/WHHE0GthYZW6Sehg4wF4/QO5bBwaskldUMZO58nGOZUXRr+5f
         XGtCELenaOomzXfag2FuVPdDuEgsTXI1jQJ2rr5uDo8CQvg3RIU9z/abr78TRrTn/nz0
         iAEANOHpUsSXO9oNeVwlt1TrBzOREXmqRdmpiXuDg99XpKYxFQ9WXWxlNmtx52RltceT
         6ZIzFnbsO7OHbN68CKj7B4Jbo2nX2+oor/bkoafPeitz2gpFsil7UVB13gC1bIe+hen1
         sGthiJKeozjyIMc8i4XNl2ljw6IDt6xSgQbMl9kK597sfT+AbVIbJr+T5QgUz1sGqUCA
         uQXA==
In-Reply-To: <fabba6b8-8f8d-8f8f-1660-c579e6515563@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Marek <mmarek@suse.com>
Cc: rml@tech9.net, axboe@fb.com, shli@kernel.org, Ian Kent <raven@themaw.net>, yamada.masahito@socionext.com, linux-raid@vger.kernel.org, autofs@vger.kernel.org, linux-kbuild@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Mar 27, 2017 at 8:54 PM, Michal Marek <mmarek@suse.com> wrote:
> Dne 27.3.2017 v 07:47 SeongJae Park napsal(a):
>> URLs to `ftp.kernel.org` exist here and there though `ftp.kernel.org` is
>> already dead [0].  This patchset fixes those URLs to use `www.kernel.org`
>> instead.
>>
>> The change is splitted into multiple patches for independent review and merge
>> of each maintainer, though the change is trivial.
>>
>> [0] https://www.kernel.org/shutting-down-ftp-services.html
>>
>> SeongJae Park (5):
>>   MAINTAINERS: Fix a dead URL to ftp.kernel.org
>>   drivers/block: Fix a dead URL to ftp.kernel.org
>>   drivers/md: Fix a dead URL to ftp.kernel.org
>>   fs/autofs4: Fix a dead URL to ftp.kernel.org
>>   scripts: Fix dead URLs to ftp.kernel.org
>
> I guess the change be sent in a single patch to the trivial tree.

Sounds reasonable.  I will post the single patch as a reply to this mail.


Thanks,
SeongJae Park

>
> Michal
>
