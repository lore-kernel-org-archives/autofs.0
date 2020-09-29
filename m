From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 13c164b1a186 - regression for LSMs/SELinux?
Date: Tue, 29 Sep 2020 10:23:50 -0700
Message-ID: <CAHk-=wi3+AhZ0Q3nvGJCgdL0Vq8b_soy8rhS5_HE79VBP7Q-LQ@mail.gmail.com>
References: <CAFqZXNsoXr1eA4C8==Nvujs5ONpRnuSqaOQQ0n78R=Dbm-EFGA@mail.gmail.com>
 <20200921160922.GA23870@lst.de> <20200921163011.GZ3421308@ZenIV.linux.org.uk>
 <CAFqZXNsBqvCj0NjEd9+C0H1EPjz7Fst296AA5eOFSVx=SKjfOg@mail.gmail.com>
 <0764629d33d151aee743d0429ac87a5b0c300235.camel@themaw.net>
 <CAFqZXNsqD73hptXxBn+g98ngbFd=Sx+CghtwVqM+NC47VFZhVQ@mail.gmail.com>
 <CAEjxPJ4oZvtqUpW0bMzoZwVsi9kDvL5LtouHQZAO7gM7_qyHMg@mail.gmail.com>
 <CAFqZXNs0oZ+_RNvwE-e62H2FSS=N4wbvJ+tgk0_dSn=5mbPhcw@mail.gmail.com>
 <CAHk-=wjYB+q1=3_x97VSNo5cPTL=eHnuMDXoKhGJOJvo+pbp9g@mail.gmail.com>
 <05c18390d485ae6d84c49f707d20b49e28f210a6.camel@themaw.net> <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000d2228705b0770cbc"
Return-path: <linux-security-module-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLAA/pJeKW+cqg50Ky57VCHaGTK5qDXo2yqA2pvF+eQ=;
        b=LjUkXudSoFBbDOO0M3Aw/aA5ORisoLfOBbWS+EuHcCdJ4UVE9j8EhvhFGCA/Zca0w7
         4AaPgkaAJsBVuA6YpTFf7WTJVEp9xTmUeQvlINdGGPRg09Hegrf+uVZEXdkKqgmMKiN+
         Ebp/oOmLKEC9pbX17X2DwXblyrVa/XS3QfE+A=
In-Reply-To: <CAFqZXNt2pWwRnnzB0KfZfZy-dJuXfKkJeejpuXcHCBLq1htA8w@mail.gmail.com>
List-ID: <autofs.vger.kernel.org>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Ian Kent <raven@themaw.net>, Stephen Smalley <stephen.smalley.work@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, autofs@vger.kernel.org, Linux Security Module list <linux-security-module@vger.kernel.org>, SElinux list <selinux@vger.kernel.org>, Zdenek Pytela <zpytela@redhat.com>

--000000000000d2228705b0770cbc
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2020 at 5:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> OK, so it seems that reverting comes out as the best choice here.

Yeah.

> BTW, I'm looking at rw_verify_area() and I see this "If (ppos)" check
> and the comment above it... And then I look at autofs_write(), which
> passes &file->f_pos, while ksys_write() passes file_ppos(file)

Ok, that doesn't matter for the security_file_permission() issue, but
yes, autofs is doing the traditional thing, and it's pointless. Using
file_ppos(file) isn't an option since it's an inline to read_write.c,
but it could just pass in NULL these days and avoid that too.

So how about we just do the appended patch? Can whoever sees this
problem just verify, even though it looks trivially correct...

            Linus

--000000000000d2228705b0770cbc
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kfo8cery0>
X-Attachment-Id: f_kfo8cery0

IGZzL2F1dG9mcy93YWl0cS5jIHwgMiArLQogZnMvcmVhZF93cml0ZS5jICAgfCAxICsKIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvYXV0b2ZzL3dhaXRxLmMgYi9mcy9hdXRvZnMvd2FpdHEuYwppbmRleCA3NGM4ODZmN2M1MWMu
LjVjZWQ4NTlkYWM1MyAxMDA2NDQKLS0tIGEvZnMvYXV0b2ZzL3dhaXRxLmMKKysrIGIvZnMvYXV0
b2ZzL3dhaXRxLmMKQEAgLTUzLDcgKzUzLDcgQEAgc3RhdGljIGludCBhdXRvZnNfd3JpdGUoc3Ry
dWN0IGF1dG9mc19zYl9pbmZvICpzYmksCiAKIAltdXRleF9sb2NrKCZzYmktPnBpcGVfbXV0ZXgp
OwogCXdoaWxlIChieXRlcykgewotCQl3ciA9IGtlcm5lbF93cml0ZShmaWxlLCBkYXRhLCBieXRl
cywgJmZpbGUtPmZfcG9zKTsKKwkJd3IgPSBfX2tlcm5lbF93cml0ZShmaWxlLCBkYXRhLCBieXRl
cywgTlVMTCk7CiAJCWlmICh3ciA8PSAwKQogCQkJYnJlYWs7CiAJCWRhdGEgKz0gd3I7CmRpZmYg
LS1naXQgYS9mcy9yZWFkX3dyaXRlLmMgYi9mcy9yZWFkX3dyaXRlLmMKaW5kZXggNWRiNThiOGM3
OGQwLi4yZmMzMTk0ZTRkMzAgMTAwNjQ0Ci0tLSBhL2ZzL3JlYWRfd3JpdGUuYworKysgYi9mcy9y
ZWFkX3dyaXRlLmMKQEAgLTUzOCw2ICs1MzgsNyBAQCBzc2l6ZV90IF9fa2VybmVsX3dyaXRlKHN0
cnVjdCBmaWxlICpmaWxlLCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90CiAJ
aW5jX3N5c2N3KGN1cnJlbnQpOwogCXJldHVybiByZXQ7CiB9CitFWFBPUlRfU1lNQk9MX0dQTChf
X2tlcm5lbF93cml0ZSk7CiAKIHNzaXplX3Qga2VybmVsX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxl
LCBjb25zdCB2b2lkICpidWYsIHNpemVfdCBjb3VudCwKIAkJCSAgICBsb2ZmX3QgKnBvcykK
--000000000000d2228705b0770cbc--
