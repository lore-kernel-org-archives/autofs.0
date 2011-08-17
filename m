From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 past 2.6.38: how to make it work?
Date: Wed, 17 Aug 2011 20:18:19 +0800
Message-ID: <1313583499.4418.33.camel@perseus.themaw.net>
References: <4E4975AB.4050201@msgid.tls.msk.ru>
 <4E497B43.4010600@msgid.tls.msk.ru>
 <1313550460.4418.5.camel@perseus.themaw.net>
 <4E4B5F4A.5060705@msgid.tls.msk.ru>
 <1313569707.4418.32.camel@perseus.themaw.net>
 <4E4B7EDF.5020205@msgid.tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
 messagingengine.com; h=subject:from:to:cc:in-reply-to:references
 :content-type:date:message-id:mime-version
 :content-transfer-encoding; s=smtpout; bh=fxqAD2Y3w7oLpsv+y2H+bB
 oBeh8=; b=aCLAY4p0wzbEgCwssCyzJ0M/3Nhc3IU0zTk0+TuQGNc4xM4EVpjCCw
 XV7AyPye8kt74jgJSkvlec2+Sf4mpve2c8NDk/Xc4pEnwwDUsZrgwR4v6KNWya1J
 FSFSRCqjKSdBT9IOyyf1VPK7589C0jWSXXX85f+D0EXP/A/qb1SyM=
In-Reply-To: <4E4B7EDF.5020205@msgid.tls.msk.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
 <mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: autofs@linux.kernel.org

T24gV2VkLCAyMDExLTA4LTE3IGF0IDEyOjQyICswNDAwLCBNaWNoYWVsIFRva2FyZXYgd3JvdGU6
Cj4gMTcuMDguMjAxMSAxMjoyOCwgSWFuIEtlbnQg0L/QuNGI0LXRgjoKPiA+IE9uIFdlZCwgMjAx
MS0wOC0xNyBhdCAxMDoyNyArMDQwMCwgTWljaGFlbCBUb2thcmV2IHdyb3RlOgo+ID4+IEluIDMu
MCwgb25seSB0d28gcmVsZXZhbnQgY29tbWl0cyBhcmUgbWlzc2luZyBhcyBmYXIKPiA+PiBhcyBJ
IGNhbiBzZWU6IHRoaXMgbmVnYXRpdmUgYXV0b2ZzIGRlbnRyaWVzIGZpeCwgYW5kCj4gPj4gTE9P
S1VQX0NPTlRJTlVFIGNoYW5nZS4gIFRoZSByZXN0IC0gYWdhaW4sIGlmYWljcyAtCj4gPj4gYXJl
IG1lcmVseSBjb3NtZXRpY3MuICBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcwo+ID4+IExPT0tVUF9D
T05USU5VRSBjaGFuZ2UsIGhvdyByZWxldmFudCBpdCBpcywgYnV0Cj4gPj4gdGhlIHR3byBjb21i
aW5lZCBkb2VzIG5vdCBsb29rIGJhZCBmb3IgLXN0YWJsZS4KPiA+PiBJIHRoaW5rLi4uIDopCj4g
PiAKPiA+IE5vdCBzdXJlIHdoYXQgdGhlIExPT0tVUF9DT05USU5VRSBjaGFuZ2UgaXMsIHdoYXQg
ZG9lcyBpdCBsb29rIGxpa2Ugb3IKPiA+IGRvIHlvdSBoYXZlIGEgZ2l0IGNvbW1pdCBudW1iZXI/
Cj4gCj4gY29tbWl0IDQ5MDg0YzNiYjIwNTVjNDAxZjM0OTNjMTNlZGFlMTRkNDkxMjhjYTAKPiBB
dXRob3I6ICBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az4KPiBEYXRlOiAgICBTYXQg
SnVuIDI1IDIxOjU5OjUyIDIwMTEgLTA0MDAKPiBTdWJqZWN0OiBraWxsIExPT0tVUF9DT05USU5V
RQoKT0ssIHRoYXQgb25lIHNob3VsZG4ndCBtYWtlIGFueSBkaWZmZXJlbmNlIHRvIGF1dG9mcy4K
CklhbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmF1
dG9mcyBtYWlsaW5nIGxpc3QKYXV0b2ZzQGxpbnV4Lmtlcm5lbC5vcmcKaHR0cDovL2xpbnV4Lmtl
cm5lbC5vcmcvbWFpbG1hbi9saXN0aW5mby9hdXRvZnMK
