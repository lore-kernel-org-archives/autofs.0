From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 9 Aug 2017 17:51:17 +0800
Message-ID: <f7ea302d-2e17-b8bf-242e-fc06c4a0adcb@themaw.net>
References: <150216641255.11652.4204561328197919771.stgit@pluto.themaw.net>
 <4689.1502267949@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=RBNn4PSlGRDtUtIZf7
        w3QWxVPOOixBPhlP4zKuMjJkw=; b=VRj1c5gsoXbU2cQaoVspgOsAyCiD0p9Ycz
        RWYt612nsIzluT/WlIVHeGj0AMiY63SKzriGkpxa4nGA3yfXed4pUG92lGSr1syc
        8hL3Wc/aK7yaecQqpGeoYq+v8/ImR5cWXvjQAFYOlZQdD30sEji8SmbYAgTS4keC
        Evt3yUsKqETS7X5zZrxc0KvlxcP6SE1Q7HUBvIib/ZL/RVrV635DfXhK86oNmat+
        ni/yf9d6xSy75kpAvv+2dIDlvfBb+bN55b8rfZ9mFbxFDOuQCfgUQbijudsxDDmq
        5Z6ryjEkHxH54tWg8B7s7FD8bqrZdpalyuHxoHfB/krmj0c0QhCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=RBNn4PSlGRDtUtIZf7w3QWxVPOOixBPhlP4zKuMjJkw=; b=kkfYu91/
        WzTIRBclYHHkLae+YWT8BXPYMgPngoV1hl0T9TVxzas0VgxbiFMAdUixSw5uFXX4
        3pxrtn/Xw0+rR/kI3Y4rR5cZr6bn6POGLtvfQ/gtgiY1m1bEULNBMJhOM9lH1GzA
        0QLxc4SGQDfBETEQqjrxjtdSKOTLD2479b/Z6ZBDQ7RoF+XhtAsgXqYpCfIW7mxK
        ptWKHFKRmYgAvpY9cuNG9dwHyZzi69IyHgt4m3aV4KcXmVL23Nl3bm/PJ5C6jWf9
        ux3w9qyKcqeheCGGRlgOaRC39m9xkk2rq6uqT+AZeG0XztJrcRL3BdLC3MB2Gscp
        G4b7UWmGXQ3IOA==
In-Reply-To: <4689.1502267949@warthog.procyon.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Ondrej Holy <oholy@redhat.com>, Colin Walters <walters@redhat.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On 09/08/17 16:39, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
>> In order to handle the AT_NO_AUTOMOUNT for both system calls the
>> negative dentry case in follow_automount() needs to be changed to
>> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
>> required flags are clear).
> 
> Should the be EREMOTE instead of ENOENT?

I thought about that and ended up thinking ENOENT was more sensible
but I'll look at it again.

Thanks
Ian
