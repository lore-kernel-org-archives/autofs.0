From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] autofs4: fix compilation without CONFIG_COMPAT
Date: Sat, 25 Feb 2012 17:31:30 -0800
Message-ID: <CA+55aFxH4_gucG7vpdV5NJPNHoXy5bSGtr0yHqmobvYO6PmjNw@mail.gmail.com>
References: <CA+55aFzhS69QSoN1j+Z2md116u+3OfniAoE0QMo6xyBjDyjbEw@mail.gmail.com>
 <20120221.221609.218135609185671883.davem@davemloft.net> <CA+55aFwvmZGDzO_8wwYfH8HsLE=qCmLkJfeMyCe4PVvOYbDMHQ@mail.gmail.com>
 <CA+55aFzv3X3yW8WZGMZO+aKa=qWi2w8=zn2DP-Q3jRry8Ermyw@mail.gmail.com>
 <CA+55aFyh1NmBt0LwR3+iD6B-Xa8wAs-nGJ0MBouPhTzWUi8W5g@mail.gmail.com>
 <1329889428.2193.45.camel@perseus.themaw.net> <1329890027.2193.48.camel@perseus.themaw.net>
 <1329890251.2193.50.camel@perseus.themaw.net> <m2vcmuh8dg.fsf_-_@igel.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=e89a8ff1c51c39350f04b9d3f519
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=AYFjwFWwYHerVhsYrdd1gefoWfoBXYywonSMqdEjxvE=;
        b=ZyvwxtARG9Ha6X5kA71AbLWbJtixRmI2WSsuAdaQfJ9m4IyScViMeiAuPQ15cS87XP
         Caw3PVttRIQBzbfp6tyAYYkWQD/DFfiszUSvitpAkBf3+zEbz/RGlCrQnFQK/v4ldvAi
         N4mWYiYFzrC4/7Y3XWBRAE+DyBAjd+m+Kv26E=
In-Reply-To: <m2vcmuh8dg.fsf_-_@igel.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Ian Kent <raven@themaw.net>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, autofs@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, Al Viro <viro@zeniv.linux.org.uk>

--e89a8ff1c51c39350f04b9d3f519
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Feb 25, 2012 at 2:10 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> The compat_daemon stuff is only needed on x86-64, and is_compat_task is
> only defined with CONFIG_COMPAT, so disable it for all other
> configurations.

Ugh, I hate the proliferation of #ifdefs in code when they aren't
really necessary.

How about this patch instead? It's small, simple, and clean. Maybe it
would even allow a few other #ifdef's to be removed (I see one in
kernel/seccomp.c, for example, although I suspect that
'mode1_syscalls_32' might also be a compat-only thing, so who knows)

And if you worry about the size of autofs_sb_info, I think that could
be made denser by using 'char' or bitfields instead of the various
ints that hold small values or flags instead.

                         Linus

--e89a8ff1c51c39350f04b9d3f519
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gz3ekhfy0

IGluY2x1ZGUvbGludXgvY29tcGF0LmggfCAgICA0ICsrKysKIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2NvbXBhdC5oIGIvaW5jbHVk
ZS9saW51eC9jb21wYXQuaAppbmRleCA0MWM5ZjY1MTVmNDYuLjdlMDVmY2VlNzVhMSAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9jb21wYXQuaAorKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBhdC5o
CkBAIC01NjEsNSArNTYxLDkgQEAgYXNtbGlua2FnZSBzc2l6ZV90IGNvbXBhdF9zeXNfcHJvY2Vz
c192bV93cml0ZXYoY29tcGF0X3BpZF90IHBpZCwKIAkJdW5zaWduZWQgbG9uZyBsaW92Y250LCBj
b25zdCBzdHJ1Y3QgY29tcGF0X2lvdmVjIF9fdXNlciAqcnZlYywKIAkJdW5zaWduZWQgbG9uZyBy
aW92Y250LCB1bnNpZ25lZCBsb25nIGZsYWdzKTsKIAorI2Vsc2UKKworI2RlZmluZSBpc19jb21w
YXRfdGFzaygpICgwKQorCiAjZW5kaWYgLyogQ09ORklHX0NPTVBBVCAqLwogI2VuZGlmIC8qIF9M
SU5VWF9DT01QQVRfSCAqLwo=
--e89a8ff1c51c39350f04b9d3f519--
