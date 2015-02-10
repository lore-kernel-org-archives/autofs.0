From: Pete Beardmore <pete.beardmore@msn.com>
Subject: [PATCH] fix map option parsing for 'strictatime'
Date: Tue, 10 Feb 2015 17:04:57 +0000
Message-ID: <DUB122-W513EB1C3223DD0FD66F71A8A240@phx.gbl>
References: <DUB122-W3438A418D6CC75FC3C903D8A240@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_0f76e13f-9a7c-4661-ae3c-7b7f6e941691_"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <DUB122-W3438A418D6CC75FC3C903D8A240@phx.gbl>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

--_0f76e13f-9a7c-4661-ae3c-7b7f6e941691_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=0A=
=0A=
=0A=
Hi=2C=0A=
=0A=
I tried adding the 'strictatime' fs option in a map today to no avail. It l=
ooks like the current logic for the automount 'strict' option is erroneousl=
y consuming that option. Trivial patch attached.=0A=
=0A=
Cheers=2C=0A=
Pete.=0A=
=0A=
=0A=
 		 	   		  =0A=
 		 	   		  =

--_0f76e13f-9a7c-4661-ae3c-7b7f6e941691_
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fix.map.option.parsing.for.'strictatime'.diff"

RnJvbSBmOWU3Njg1ODQ0ZDgxZjM2MzY3ZDBiYTIyMmM2Y2Y5YjU1MGYwMjViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQZXRlIEJlYXJkbW9yZSA8cGV0ZS5iZWFyZG1vcmVAbXNuLmNv
bT4KRGF0ZTogVHVlLCAxMCBGZWIgMjAxNSAxNTozNzoxMCArMDAwMApTdWJqZWN0OiBmaXggbWFw
IG9wdGlvbiBwYXJzaW5nIGZvciAnc3RyaWN0YXRpbWUnCgpBZGRlZCBhIHRyaXZpYWwgdG9rZW4g
bGVuZ3RoIGNoZWNrIHRvIGVuc3VyZSB0aGUgJ3N0cmljdGF0aW1lJwptb3VudCBvcHRpb24gaXMg
bm90IGNvbnN1bWVkIGJ5IHN0cmluZyBsb2dpYyBmb3IgdGhlICdzdHJpY3QnCmF1dG9tb3VudCBv
cHRpb24uCgpQcmUtcGF0Y2gsIGFkZGluZyB0aGUgJ3N0cmljdGF0aW1lJyB0byBhIG1hcCBlZmZl
Y3RpdmVseSBzd2l0Y2hlZApzdHJpY3QgbW9kZSAoZm9yIG11bHRpLW1vdW50IGhhbmRsaW5nKSBv
biwgYW5kIGZhaWxlZCB0byBwYXNzIHRoZQonc3RyaWN0YXRpbWUnIG9wdGlvbiB0aHJvdWdoIHRv
ICdtb3VudCcuCgpUaGlzIHdpbGwgaGF2ZSBiZWVuIGFuIGlzc3VlIHNpbmNlICdzdHJpY3RhdGlt
ZScgd2FzIGludHJvZHVjZWQKZm9yIHRoZSAyLjYuMzAga2VybmVsLgotLS0KIG1vZHVsZXMvcGFy
c2Vfc3VuLmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL21vZHVsZXMvcGFyc2Vfc3VuLmMgYi9tb2R1bGVzL3BhcnNl
X3N1bi5jCmluZGV4IGI4ODFlZTkuLjg2ZWUyNzkgMTAwNjQ0Ci0tLSBhL21vZHVsZXMvcGFyc2Vf
c3VuLmMKKysrIGIvbW9kdWxlcy9wYXJzZV9zdW4uYwpAQCAtNTA5LDcgKzUwOSw4IEBAIHN0YXRp
YyBpbnQgc3VuX21vdW50KHN0cnVjdCBhdXRvZnNfcG9pbnQgKmFwLCBjb25zdCBjaGFyICpyb290
LAogCQkJCWZzdHlwZVt0eXBlbGVuXSA9ICdcMCc7CiAJCQl9IGVsc2UgaWYgKF9zdHJuY21wKCJu
b25zdHJpY3QiLCBjcCwgOSkgPT0gMCkgewogCQkJCW5vbnN0cmljdCA9IDE7Ci0JCQl9IGVsc2Ug
aWYgKF9zdHJuY21wKCJzdHJpY3QiLCBjcCwgNikgPT0gMCkgeworCQkJfSBlbHNlIGlmIChfc3Ry
bmNtcCgic3RyaWN0IiwgY3AsIDYpID09IDAgJiYKKwkJCQkgICBjb21tYSAtIGNwID09IDYpIHsK
IAkJCQlub25zdHJpY3QgPSAwOwogCQkJfSBlbHNlIGlmIChfc3RybmNtcCgibm9icm93c2UiLCBj
cCwgOCkgPT0gMCB8fAogCQkJCSAgIF9zdHJuY21wKCJicm93c2UiLCBjcCwgNikgPT0gMCB8fAot
LSAKMS44LjQKCg==

--_0f76e13f-9a7c-4661-ae3c-7b7f6e941691_--
