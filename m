From: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Subject: fix undefined authtype_requires_creds error
Date: Thu, 24 Oct 2013 11:34:28 +0800
Message-ID: <CAF1ZMEc84Ep6cpEbnmYw4YJpuQJwrOVketBtNcgNZZTGTBHz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3127ea85e2d04e9744fdc
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=a5ZjDxhvMlU7vmXzfACB6DukMkK6+q2ZX5PV/d+WE1k=;
        b=dIuMx0rUHwLBhtWsft1XtX6Lhqh3VDtaU3pPXBeBUteBDA9m1UXwssc/WJVwtVzuHM
         5pAd5EW7UfPvX4Beh+kSZk9bao5BVb94OTWqZxalAguuTB9UVYrBYvC1v45kJwtKgN92
         aWD+BthssElB2mvwJyoUCNKaXyw9ka7Wzq7Phf+Wsc9DW4mp2TJ/BJeuTa4+RKpIJVCe
         4HUj0UQIObgNkCXilWsMZOocHuYpo+tGnDswxgbyvlibdiFZEDsKwv8QcgD4YIR9dYPJ
         iSQiCkFPY+61ySZYxpfKugJ8ygUgPMuYNIiWCJtnuDdzZsTSj5l8z3Idj4ERMDyt2IIO
         Dhgw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs mailing list <autofs@vger.kernel.org>

--001a11c3127ea85e2d04e9744fdc
Content-Type: text/plain; charset=UTF-8

HI Ian:
  here is simple patch for fixing undefined authtype_requires_creds
error while LDAP enabled but without SASL.

  sorry for using attached file, since I have problem to use "git
send-email" in my office.

  also the downstream bug here, https://bugs.gentoo.org/show_bug.cgi?id=489128

Lan Yixun (dlan)

--001a11c3127ea85e2d04e9744fdc
Content-Type: application/octet-stream; 
	name="0001-fix-undefined-authtype_requires_creds-err-if-ldap-en.patch"
Content-Disposition: attachment; 
	filename="0001-fix-undefined-authtype_requires_creds-err-if-ldap-en.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hn5fshrl0

RnJvbSBkZDkxNGU1M2E0ODQ4MTdlMjU2NzE1NGFhZjdkZDNjZWQyZDg1MDhhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiTGFuIFlpeHVuIChkbGFuKSIgPGRlbm5pcy55eHVuQGdtYWls
LmNvbT4KRGF0ZTogVGh1LCAyNCBPY3QgMjAxMyAxMDoxNToxMCArMDgwMApTdWJqZWN0OiBbUEFU
Q0hdIGZpeCB1bmRlZmluZWQgYXV0aHR5cGVfcmVxdWlyZXNfY3JlZHMgZXJyIGlmIGxkYXAgZW5h
YmxlZCBidXQKIHdpdGhvdXQgc2FzbAoKdGhpcyBwYXRjaCBpcyBtb3ZpbmcgIldJVEhfU0FTTCIg
aW50byBhdXRodHlwZV9yZXF1aXJlc19jcmVkcyBmdW5jdGlvbgptYWtlIGl0IHJldHVybiAwIGlm
IHNhc2wgbm90IGVuYWJsZWQsIHdoaWNoIG1lYW4gYXV0aHR5cGVfcmVxdWlyZXNfY3JlZHMgaXMg
bm90IGVuYWJsZWQKCmh0dHBzOi8vYnVncy5nZW50b28ub3JnL3Nob3dfYnVnLmNnaT9pZD00ODkx
MjgKCi0tLQpvcGVuX2xvb2t1cDo5MDogY2Fubm90IG9wZW4gbG9va3VwIG1vZHVsZSBsZGFwICgv
dXNyL2xpYjY0L2F1dG9mcy9sb29rdXBfbGRhcC5zbzogdW5kZWZpbmVkIHN5bWJvbDoKYXV0aHR5
cGVfcmVxdWlyZXNfY3JlZHMpCmxvb2t1cChmaWxlKTogZmFpbGVkIHRvIHJlYWQgaW5jbHVkZWQg
bWFzdGVyIG1hcCBhdXRvLm1hc3RlcgpubyBtb3VudHMgaW4gdGFibGUKClNpZ25lZC1vZmYtYnk6
IExhbiBZaXh1biAoZGxhbikgPGRlbm5pcy55eHVuQGdtYWlsLmNvbT4KLS0tCiBtb2R1bGVzL2xv
b2t1cF9sZGFwLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW9kdWxlcy9sb29rdXBfbGRhcC5jIGIvbW9kdWxl
cy9sb29rdXBfbGRhcC5jCmluZGV4IDJhYjFlOGMuLjA0YjFkYTcgMTAwNjQ0Ci0tLSBhL21vZHVs
ZXMvbG9va3VwX2xkYXAuYworKysgYi9tb2R1bGVzL2xvb2t1cF9sZGFwLmMKQEAgLTg0NiwyMCAr
ODQ2LDIwIEBAIGludCBnZXRfcHJvcGVydHkodW5zaWduZWQgbG9nb3B0LCB4bWxOb2RlUHRyIG5v
ZGUsIGNvbnN0IGNoYXIgKnByb3AsIGNoYXIgKip2YWx1CiAJcmV0dXJuIDA7CiB9CiAKLSNpZmRl
ZiBXSVRIX1NBU0wKIC8qCiAgKiAgRm9yIHBsYWluIHRleHQsIGxvZ2luIGFuZCBkaWdlc3QtbWQ1
IGF1dGhlbnRpY2F0aW9uIHR5cGVzLCB3ZSBuZWVkCiAgKiAgdXNlciBhbmQgcGFzc3dvcmQgY3Jl
ZGVudGlhbHMuCiAgKi8KIGludCBhdXRodHlwZV9yZXF1aXJlc19jcmVkcyhjb25zdCBjaGFyICph
dXRodHlwZSkKIHsKKyNpZmRlZiBXSVRIX1NBU0wKIAlpZiAoIXN0cm5jbXAoYXV0aHR5cGUsICJQ
TEFJTiIsIHN0cmxlbigiUExBSU4iKSkgfHwKIAkgICAgIXN0cm5jbXAoYXV0aHR5cGUsICJESUdF
U1QtTUQ1Iiwgc3RybGVuKCJESUdFU1QtTUQ1IikpIHx8CiAJICAgICFzdHJuY21wKGF1dGh0eXBl
LCAiTE9HSU4iLCBzdHJsZW4oIkxPR0lOIikpKQogCQlyZXR1cm4gMTsKKyNlbmRpZgogCXJldHVy
biAwOwogfQotI2VuZGlmCiAKIC8qCiAgKiAgUmV0dXJuczoKLS0gCjEuOC4zLjIKCg==
--001a11c3127ea85e2d04e9744fdc--
