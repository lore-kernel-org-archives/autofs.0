From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: Segmentation fault in st_queue_handler()
Date: Tue, 25 Feb 2014 11:18:48 -0300
Message-ID: <CAEySpB5g2FMMYgL5-uVYzNK2fi3a2LoQVH=uEPUCNfvZc-Z7ww@mail.gmail.com>
References: <CAEySpB5YrZdPtv=DPXYKf759k7BtCF7JMfK5rmZNDCMs5CuvUw@mail.gmail.com>
	<1322007510.3340.14.camel@perseus.themaw.net>
	<CAEySpB6K3RffsKbnDPMW9Evu_3gayrmm59jdTKMoZd7sqfYL5A@mail.gmail.com>
	<CAEySpB7z0Wy88MLJ-L6CHoRdgGoozmPqF8RqEeHOAG6KO01uZw@mail.gmail.com>
	<CAEySpB4rf8JvSY2yoGX6jhRr3nUQExTGX3pxAodwO0AgHi8ZZA@mail.gmail.com>
	<1322786402.2171.30.camel@perseus.themaw.net>
	<CAEySpB6rq5wU+45_+0BHR3zXVZUhGKbmW-pB4ZN31oubXP9zAA@mail.gmail.com>
	<1390265483.2541.50.camel@perseus.fritz.box>
	<CAEySpB5oKye2KJ5H_J=a5YoTBVvPEBW7CN5o6HU+FTmmqh2u5g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bjtvvNwNlvOghDOTlWeIwRR+rWIhfX0nJ36uJCCAQ8c=;
        b=QswLH+QJtjE0023vXLzHd/ju0S5/m0S5GrK6mwpAmNRFPpomZeC3Mk1s+NcLF9yWTO
         jGlSKawRU99xaPWhQ3AJWbkf+aYQ7gE7WvJ0yeyuEWFxdl9d4NomXi42OIqhk3b2RLa0
         uhpKeZmsgaNLwguoWLIY9rzqI3vd75Qbaf44blMrHyDXWYi80EK5v94uFPoxgjpqv0v9
         5x+mIUDZiYeNhhRIcdIUM6Rx2mOSIUdnQwm7E9zTjCh6GZ0Dfrk32drFos1h1JT+Mxh/
         tWN+8Slbc/qk474+JaBcTF/2FiQUUKP2MQL4QqSCshtMFr+u1GaVKWTbR0uz+GDbA5X2
         gnsA==
In-Reply-To: <CAEySpB5oKye2KJ5H_J=a5YoTBVvPEBW7CN5o6HU+FTmmqh2u5g@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>

(...)

>>> Hello Ian,
>>>
>>> Sorry to resurrect such an old thread. We're still carrying this patch
>>> in our package and I'd like to get rid of it, preferably by getting it
>>> accepted upstream :-)
>>>
>>> As described above, the core dump analysis really pointed to an
>>> use after free condition when (&task->pending)->next == task. It's
>>> unfortunate that we received such report only once and had no
>>> specific info about the circumstances that could trigger the problem.
>>>
>>> In any case, moving free(task) to the end of the block should be
>>> safe and is actually how it was done before commit 6273ab63c. Do
>>> you think you can accept the patch as is?
>>
>> I didn't see a patch in the previous thread.
>> Presumably you have a patch with a description you could post.
>>
>> TBH, I don't think it's worth perusing this further since the change
>> looks safe enough I can just add it to my commit queue for the next time
>> I commit changes.
>
> Sure! Please see the patch attached (for some reason Gmail is no
> longer expanding tabs here).

Hello Ian,

Looks like this one was not included in the last commit round.
Could you perhaps schedule it for the next one?

Thanks,
Leonardo
