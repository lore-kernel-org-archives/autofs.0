From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Fri, 14 Jan 2011 12:04:52 +1100
Message-ID: <AANLkTimcjg-JaVr1w=sCNQHTWFxquPvpL=YJZNGTN3cY@mail.gmail.com>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
	<20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
	<AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
	<14657.1294921241@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d7sd90j8NizCgTqRFkw1boC1CGZW12sw1YymH8ud3SM=;
        b=ba0IDU0E47c1gh1ySb6GqyKCM65FFhYkntAfc00qbTAfGuHtNL4fSB+kEAX1s9+yJT
         8E3KYG8sifNEre5tSYr7DaGkObf4vOVYHon7908EbGc3xNOdueq7PhMLZiH++xKjQBCK
         f+CxJCoKu7ChU4lmR6AuuJPBUqBlH94g572Ko=
In-Reply-To: <14657.1294921241@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells@redhat.com>
Cc: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2011 at 11:20 PM, David Howells <dhowells@redhat.com> w=
rote:
> Nick Piggin <npiggin@gmail.com> wrote:
>
>> So something has gone wrong here. You have documented .d_automount
>> can be called in rcu-walk mode, but it doesn't seem to be the case.
>
> Ah. =A0You removed a column and installed a new one, and I didn't not=
ice.

You still have to notice that it is .d_automount in rcu-walk mode, and =
bail
out if it is. I can't see where you do that.


> Neither d_automount() and d_manage() should be entered in rcu-walk mo=
de since
> they're both expected to sleep.
>
> Btw, should you add a fifth column for d_seq?

rcu-walk means that rcu_read_lock is held, d_seq is open, vfsmount_lock=
 is
held for read. So it's redundant.

> I should also add a column for namespace_sem as d_manage() may be cal=
led with
> that held (and d_automount() must not be called with that held).

More documentation the merrier.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
