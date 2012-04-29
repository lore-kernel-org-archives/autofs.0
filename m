From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v2] Introduce a version6 of autofs interface, to fix design
 error.
Date: Sun, 29 Apr 2012 10:37:00 +0400
Message-ID: <4F9CE18C.2060806@msgid.tls.msk.ru>
References: <20120427.151433.1007849975903946491.davem@davemloft.net> <20120427.151651.2274764174217164454.davem@davemloft.net> <CA+55aFzPbAprx-iT0TYh24uS7+JnL92mbTg_js6Cd_O0q+Dvmw@mail.gmail.com> <20120427.152404.2292425516870981391.davem@davemloft.net> <CA+55aFzGO+PHmjjVgxnYawbB-wFAqHtkh19vTv1AwQNpc9MsWg@mail.gmail.com> <20120427234215.079a1565@pyramind.ukuu.org.uk> <CA+55aFxq4TunFa8mqJk5MHfvvFSg7Dr54acW7Cnqc5amOPdqrg@mail.gmail.com> <CA+55aFzdEcfXVXXqCumVJo=9+fK+1HvH6L4qY03HfTTvCs1Fwg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFzdEcfXVXXqCumVJo=9+fK+1HvH6L4qY03HfTTvCs1Fwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Meyer <thomas@m3y3r.de>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, autofs@vger.kernel.org, raven@themaw.net, stable@kernel.org

On 28.04.2012 20:10, Linus Torvalds wrote:
> On Fri, Apr 27, 2012 at 4:27 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The attached patch implements that, and makes autofs automatically set
>> the O_DIRECT flag.
> 
> Ok, since the packetized pipe approach makes the "compat" games in
> autofs unnecessary (autofs can just always do the bigger write), I
> have now reverted the commit that started this issue in my tree (and
> marked it for stable). So automount should work again.
> 
> However, I would still like to know if systemd works with the attached
> patch (it's pretty much the same patch as before, but the revert made
> for some changes in the autofs code).
> 
> Thomas?

I installed 32bit userspace together with systemd in a vrtual machine
today, and tried it with this patch (and with the previous autofs
'fix' reverted).

And no, it does not quite work.  Strace shows that systemd correctly
reads first 300 bytes, but next read returns 4 bytes, so it reads
these and waits for next 300-4 = 296 bytes of data.

/proc/1/fdinfo/16  -- the autofs pipe fd# -- shows flags=02004000
which is O_CLOEXEC|O_NONBLOCK, but this is the other end of the
pipe..  shouldn't the READ side of the pipe have O_DIRECT flag now?

Thanks,

/mjt
