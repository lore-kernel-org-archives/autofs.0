From: David Ahern <dsahern@gmail.com>
Subject: Re: NULL pointer dereference in autofs4_expire_wait
Date: Fri, 11 Oct 2013 07:29:24 -0600
Message-ID: <5257FD34.2060406@gmail.com>
References: <525736C7.9080400@gmail.com>  <1381457199.2631.3.camel@perseus.fritz.box> <1381485327.2631.18.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=AMvM+mfgCOcLQecVcRIujS++4ZKTZ2eDONbc9ONNzNU=;
        b=i81zb67ZPH5TzKilpdULXcT7sArPCQ/UaRGP4kepJDQKDalfDX/0+hO4kRA+++Hwnf
         GTClHgSxrY+A4MJOfnNDGUBZRiSHlF8rnMHuNBTEhhCB9dt9a9YMqnJXPT4n43Ig3EQp
         m5vVPXAV/8lV9bTvKalbGuSXNwh8McSUr7sKy2R1XjkgQcALHnH+7UlCPWv6/ks5vMuT
         aif3Im9hFowNz37Gnk73sk0rzk8vd7wfZFNXmYR6w7Y7yrCz5qFkv3qw9N8m8P7RlnEI
         MxM2bkR/SVjvd4OGH/LX9D+W5Hl6zv/FTcJy/h0w2QMUFa6jT9pixNMbY314pn6OfPkW
         G8Hg==
In-Reply-To: <1381485327.2631.18.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org

On 10/11/13 3:55 AM, Ian Kent wrote:
> On Fri, 2013-10-11 at 10:06 +0800, Ian Kent wrote:
>> On Thu, 2013-10-10 at 17:22 -0600, David Ahern wrote:
>>> Running 3.12-rc3 just hit BUG in autofs4_expire_wait
>>
>> It doesn't look like this could be due to Al's change to the locking in
>> autos4_wait() and that the only change to autofs that I'm aware of.
>>
>> Could you do a bisect please?
>
> Of course that assumes it's repeatable.
> Is it?
>
> Can you provide any information about the environment and activity that
> was happening at the time of the BUG()?

The system was up and running for 9 days before hitting the BUG. After 
that with 3 cpus on softlockup I had to do a reboot (forced). After the 
reboot I continued the workload again without a repeat incident (yet), 
so I am not sure bisect is going to be possible.

This is a corporate environment where practically everything is in an 
automount. Specific to this problem I was repeatedly building a 
workspace in one window, using cscope in another and checking code 
against a different workspace in a third -- all 3 of those were 
different automounts and different NAS servers.

 From objdump on vmlinux the line in question is fs/autofs4/expire.c:465

     if (ino->flags & AUTOFS_INF_EXPIRING) {

I will be continuing the sequence above today (working through compile 
problems for on OS port). I will bump the kernel to top of tree and see 
if it repeats.

David
