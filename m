From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.1.4 release
Date: Tue, 19 Dec 2017 18:41:10 +0800
Message-ID: <d4f7b298-a858-9f92-4f9a-48ea56e953bb@themaw.net>
References: <6e84aeff-a175-10a0-315f-59912c5cc93b@themaw.net>
 <46356f65-d8ad-1ccf-c58a-46ea1ae819ff@math.utexas.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=JZjr8w2m6sYY2/JynDil71IlejUUD
        K/mkKw9e3jPYVc=; b=CnjMaYX0jtOpSEJoIDUgDVKcUDTKiesEG0be4niTzdRVu
        YPodcZPIoaxcuaiIkDmi33O6qmMxuhTEocROyssUArPeHEe8O6pmqQSUV9YrsW/1
        KWykGfV6Gd/6dAhcu7zUk9IN2GsZj3Ju/bMGBmfIXGbfL0BsLl9Xn8UVyt5TU0aD
        skxZwL0ujcyaTWzqre7tnhl5dLw/tDiWcUZr2DWXyU7m5yIUBxb1HzEDiaYRlHvw
        o3OyvvK8gNu+Dow2giYJXyGdm+Wv3fJHY3fV33N0Sl9Dlrj3VVVv+Ab247I7vZ8W
        MGBr5mZetGYfdRUfK1RcepVxdx3YXbfjCWOSgdyIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JZjr8w
        2m6sYY2/JynDil71IlejUUDK/mkKw9e3jPYVc=; b=WtV9bP/BoZXF034jjtikKi
        EnoLElmUJzbnzGqWoiXtf7AVS6hEKVJwTY8g3FlMvHaLJ1X0SG0h6PTRWDf1zhLo
        dhBJwv1VXwhB2rNDs5mQkai6HB4ez5V1Cpz+OvvC0FDpJMW5f4tsaJpbBgim8wvZ
        1C+lD9GhFmuomjUq5TxrXR6+uwEr3Mlr2Pwlp+blp8Lb17yj+Pow0Y2mqPLCJhL2
        3wu7ARbycWv2BfcMAU0pcKlgK7tbyTi0Q3xN9Ov1KBH71mmNb0P7xtU3NGVnd0Np
        9a0J9dGVPRTyHeSjtMX8LHzQtp4a93VvyBBdP85RFPHObrlkt6k2oBOcc2qUomlw
        ==
In-Reply-To: <46356f65-d8ad-1ccf-c58a-46ea1ae819ff@math.utexas.edu>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Patrick Goetz <pgoetz@math.utexas.edu>, autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On 19/12/17 17:45, Patrick Goetz wrote:
> On 12/19/2017 02:29 AM, Ian Kent wrote:
>> A new amd mount type has been added. The amd mount type "program"
>> has been added which allows a user provided program to be given
>> in a map entry that will be used for performing the mount and
>> optionally another program to be used at umount.
>>
> 
> What's a use case for this?

It was requested and it is one of the standard amd mount types
that hadn't been implemented. If nothing else it makes a slightly
more complete amd map format implementation.

I've seen a case where someone used a script to customize a mount
command to suit different environments, where the mount command
needed to be slightly different for different platforms. Probably
not so useful to autofs but am-utils can run on a number of different
OSes so the amd maps used by autofs (ideally unchanged from other arches)
need to be able to cope with this.

There's also the case where a mount needs to use a custom command to
perform the mount (and possibly the umount at expire).

Long ago this was requested for Sun format maps but I'm still not
in a position to implement that (and it isn't part of the defined
Sun format map syntax either).

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
