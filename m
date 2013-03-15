From: Andreas Oberritter <obi@saftware.de>
Subject: Re: [PATCH v2] autofs-5.0.7 - create a shared library
Date: Fri, 15 Mar 2013 15:28:51 +0100
Message-ID: <51433023.4060008@saftware.de>
References: <1363274460-27237-3-git-send-email-obi@saftware.de> <1363300213-12657-1-git-send-email-obi@saftware.de> <5142F7BE.400@msgid.tls.msk.ru> <51432119.2010200@saftware.de> <5143249F.1030808@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <5143249F.1030808@msgid.tls.msk.ru>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: autofs@vger.kernel.org

On 15.03.2013 14:39, Michael Tokarev wrote:
> 15.03.2013 17:24, Andreas Oberritter wrote:
>> On 15.03.2013 11:28, Michael Tokarev wrote:
>>> 15.03.2013 02:30, Andreas Oberritter wrote:
>>>> This reduces the (stripped) binary size from 1.6M to 572K
>>>> on my system.
>>>
>>> But it creates an additional file, the shared library, which
>>> also occupes space.
>>>
>>> What's the reason for that?  Instead of just one executable
>>> we now have executable plus a library, which together is
>>> larger than single executable.
>>
>> The numbers I mentioned are the total size of all created binaries (i.e.
>> excluding configuration und documentation, but including all modules and
>> the automount executable, and of course including the shared library).
>>
>> So why does this save space? Because the static library was linked into
>> every module and into the automount executable.
> 
> Aha. So that's the library linked into every module.  That explains
> things.
> 
> But now I've another question. Maybe it is better to link whole that
> lib into the main executable, instead of linking it to every module?

I hope you don't mind me forwarding your response to the list.

This may work (using -Wl,--whole-archive), but I think this would
require some more testing.

A first compile-test shows that this would save further 36K on my
system, compared to the shared library.

Regards,
Andreas

