From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v3] use pkg-config to search for libtirpc to fix
 cross-compilation
Date: Fri, 7 Jul 2017 08:56:21 +0800
Message-ID: <cc2a1c58-56d4-a3f3-2e8b-09d357ae9a92@themaw.net>
References: <20170630085439.GA14206@waldemar-brodkorb.de>
 <20170706210947.GG2081@waldemar-brodkorb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=+nv8LEYFIfngPBUoGb
        OeBnE6H2y7YAYGDlzepSCObWY=; b=jLeARmBfy6PYZ5BIC0EiPFyD8g5rOd7dGo
        nhQ3ubFm+c7ie536Qxamv7r11tN58ZMleCLan2qaHRuhZ6uxArIt/pe3uJHLfedA
        24wtvN+aUiQvi6vW9kXDu8o/FHz14zWw4xxxdnilGBIhJOJvIYpOKBcwUJa7EsfD
        SsC05q4QMD2QGqlpdF446Fe2COOcsv6iQqRVY/BQtZiAuBhnUk4xrE5iwPHs2lRI
        9kXvJXU1T2PA/AF5qtx6cVcqHqu4zPzxrrDyVjxMLhrWfyfR+4E/r2bOrpf12t3K
        kDf4+KD7IKwxbnjzKpbDgJwLMOe9Oz4XTZiKMFfeC0HQbidLXL8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=+nv8LEYFIfngPBUoGbOeBnE6H2y7YAYGDlzepSCObWY=; b=rvQIuCEz
        qu1qm+tdve3dC1oFVGdg49QRBQZd8SY7jksDhAU0Qr9QKkTCxJR+FQKO+5t46XfT
        jkzqjkPpOadL3oKGq40T2uZNH0j4BORATS+CDAZZ7F1/IhHiXvomATxgy+q/MBOZ
        uw686mQo8acg4huBolJ+y8dI4iVG4w9YdXTG9xcpQy5rI2Or/OODAQlwXuCJeXzR
        efOdNu8kPUrW3Y+MFTUDLIw5XWhc9Ih8JGKjnQz7Q0OvuHQSili11z5yi7Vx9Pfo
        /IfbBmtLAo6H8KFCgqiOBJtLe71OOo1Zx/WUzCyD3Wy65qqazQspceifnpNpEVFo
        BqpV43CypRkbRg==
In-Reply-To: <20170706210947.GG2081@waldemar-brodkorb.de>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Waldemar Brodkorb <wbx@openadk.org>, autofs@vger.kernel.org

On 07/07/17 05:09, Waldemar Brodkorb wrote:
> Hi,
> 
> friendly ping?

Oh right, I didn't say what's happening.

The patch is in my patch queue.

I'll get to committing what I have in the queue fairly soon.

There were a couple of bugs in the 5.1.3 release that need to be fixed.
So another release will be done sooner rather than later as well, can't 
say exactly when but I'd like to do it fairly soon.

> 
>> When trying to cross-compile autofs for example with a buildsystem
>> like buildroot, the compilation fails in case the user wants to use
>> libtirpc library as RPC implementation. A hard coded include path
>> in aclocal.m4 is used. Other opensource software like rpcbind or
>> nfs-utils are suing autotools pkgconfig infrastructure to find
>> the libtirpc headers and to pass the correct linker flags.
>>
>> Convert configure.in to use PKG_CHECK_MODULES and remove the
>> hand written autoconf macros from aclocal.m4. Move aclocal.m4
>> to m4 directory, so that autoconf does not skip global
>> directories, otherwise pkg.m4 (pkg-config macros) are not found.
>>
>> This fixes cross-compilation of autofs and allows to use
>> alternative C libraries as uClibc-ng without internal RPC
>> support to be used in cross-compiling environments.

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
