From: Ian Kent <raven@themaw.net>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Wed, 30 Sep 2020 18:39:37 +0800
Message-ID: <c1f38075cde1b51caa2e2e040c294d25bb650f85.camel@themaw.net>
References: <20200921163011.GZ3421308@ZenIV.linux.org.uk>
         <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
         <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
         <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
         <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
         <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
         <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
         <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net>
         <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
         <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
         <20200929180037.GA12447@lst.de>
         <689756d7d7d73a8eb86d020b0dfeb976e28cc9b4.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        71CghTCBpxVTFJhIlLR4Ey6zPfCV9SPHg/HlojHYo18=; b=S3xEqFU44nJpjBYH
        VyMtFWE2g7K2lw7uX+XZRshAfbFFg5MQfN32J/SQRQDUqDmfVfrK4q7glrUVjbQo
        3Z6SUfL8vFjXGCN6ntfUWa0/spVmsZw7kDF5TmcJR3ivg7MUsRqLOZfkIp+eV7+7
        qbWb6NXNj0j4W6TVyNHxJDFmBHrHKMFSI88W9mBhIdzDfwbqAbbDc8YXomjlTcPT
        ReQzsTQsdG4FHjGwrHY5o4Yo7QyA0YzVr7ewuVDH9U42Ylouzqq/uUouoASDEErn
        tvBuOsDtZ+humRlllG2E/NGhQ/akBspSumF2h4gpnz/TAONJ5+dUspfJVL/ASmST
        BH1jJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=71CghTCBpxVTFJhIlLR4Ey6zPfCV9SPHg/HlojHYo
        18=; b=k79MqM+CJkHDsTYj7aK7OFrfiEoPv2h/fJCNG4NDiA3O9li+IG/cfTjpe
        t9F9lL4hAyjxuBa0jDlqlI1RzycP7RrP6e3BbUtZCGHnn/QbMQenJkigjV51DHF8
        Y0NsBnkA8nqvYVwsr56mlArFdzssJO3+sTmMFFSLy34GJcQCGUAmkd42n9YxQIIS
        JaUOL5jhdW/2t9H9d1mjExG+89z7spqh6unhB26RFDeYlLuUAmjQ+N8i/H+WNFWt
        xynnwbNVwfiE71PHV8CVHgKKfK5CXN1OKWy5ZH68HEv27JgdCW2KB+lazMnYVEqA
        1P6SQa+F7T5KUn0+Y2hMCPeqO2bpQ==
In-Reply-To: <689756d7d7d73a8eb86d020b0dfeb976e28cc9b4.camel@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

On Wed, 2020-09-30 at 13:50 +0800, Ian Kent wrote:
> On Tue, 2020-09-29 at 20:00 +0200, Christoph Hellwig wrote:
> > On Tue, Sep 29, 2020 at 10:23:50AM -0700, Linus Torvalds wrote:
> > > On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <
> > > omosnace@redhat.com> wrote:
> > > > OK, so it seems that reverting comes out as the best choice
> > > > here.
> > > 
> > > Yeah.
> > > 
> > > > BTW, I'm looking at rw_verify_area() and I see this "If (ppos)"
> > > > check
> > > > and the comment above it... And then I look at autofs_write(),
> > > > which
> > > > passes &file->f_pos, while ksys_write() passes file_ppos(file)
> > > 
> > > Ok, that doesn't matter for the security_file_permission() issue,
> > > but
> > > yes, autofs is doing the traditional thing, and it's pointless.
> > > Using
> > > file_ppos(file) isn't an option since it's an inline to
> > > read_write.c,
> > > but it could just pass in NULL these days and avoid that too.
> > > 
> > > So how about we just do the appended patch? Can whoever sees this
> > > problem just verify, even though it looks trivially correct...
> > 
> > This looks sensible to me.  I'd throw in a
> > 
> > /* only for autofs, don't use in new code */
> > 
> > near the export, but users of these kind of functions tend to be
> > blind copy and paste code anyway, so the comment probably isn't
> > even read by the relevant parties..
> 
> I'll build a patched kernel and give it a whirl.

Duplicated the problem first then built a patched kernel and tested.

The patch makes the problem go away, communication to the daemon
is occurring fine so the use of NULL as the file position is ok.

It looks like the error returns should be as before which is good
but there may be another problem I need to fix in there that became
apparent because this problem drew attention to it. That's something
else entirely though.

> 
> Ian

