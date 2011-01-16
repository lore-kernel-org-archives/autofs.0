From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Sun, 16 Jan 2011 12:21:47 +1100
Message-ID: <AANLkTinMOzWQ60EiF1LJLUs-Vy4TscK-zLOY9qn=3bPU@mail.gmail.com>
References: <20110114070224.GB19804@ZenIV.linux.org.uk>
	<20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	<2443.1295005428@redhat.com>
	<6672.1295025969@redhat.com>
	<20110114174340.GG19804@ZenIV.linux.org.uk>
	<20110114175648.GH19804@ZenIV.linux.org.uk>
	<20110114180625.GI19804@ZenIV.linux.org.uk>
	<AANLkTimMVF7HSOqJGWphY2fbaXDbegppe+Vug8e5V1HN@mail.gmail.com>
	<20110115133029.GN19804@ZenIV.linux.org.uk>
	<AANLkTinG5yUjKns5nAzgtW526kKOBHT-eG1YyKR83wh5@mail.gmail.com>
	<20110116002459.GP19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KvxVOj9Op6CyAWLbH08JJ6iOBpK8TEknON0vAtSZV4c=;
        b=eCI+d1SB9xGK7aRE8BsjTTMienU1ganWNsuapzq9ZGLj1hJOK7tzRGF1IWys5opOVd
         /6Z/oDskzqUrpF3p8pGLucAcBEHzovlHcWNh3umLvCJqFA+3WI+hKrhbF7uuwozFIUGX
         vlKXzUXoH5bQ4R4GO3u4M+zEAe2N6OXacYd08=
In-Reply-To: <20110116002459.GP19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jan 16, 2011 at 11:24 AM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
> On Sun, Jan 16, 2011 at 05:33:24AM +1100, Nick Piggin wrote:
>
>> Definitely agree.
>>
>> I'm on the road at the moment so would much appreciate if you can
>> cut the patch, but I could suggest something along the lines of:
>
> Easier than that, actually. =A0All it takes is (in #for-next, yet to
> be reordered in front of queue)
> =A0 =A0 =A0 =A0if (IS_ERR(dentry))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> + =A0 =A0 =A0 if (nd->flags & LOOKUP_RCU)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done2;
> =A0 =A0 =A0 =A0goto done;
> in the end of need_revalidate and
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (dentry->d_flags & DCACHE_OP_REVALI=
DATE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto need_revalidate;
> +done2:
> in LOOKUP_RCU side of if ()...
>
> need_lookup does *not* suffer the same problem; you can't get there w=
ithout
> dropping LOOKUP_RCU - the first thing it does is grabbing a mutex, fo=
r fsck
> sake... =A0And yes, you do drop RCU on all paths leading there.

Oh right it's do_revalidate, not d_revalidate, so it won't return NULL
still in rcu-walk :P
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
