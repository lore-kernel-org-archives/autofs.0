From: Daniel Mueller <danm@gmx.li>
Subject: Autofs init script
Date: Sat, 29 Nov 2003 20:43:18 +0100
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031129204318.2bf74c10.danm@gmx.li>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__29_Nov_2003_20_43_18_+0100_2lAs+RSSn5M5rmGa"
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sat__29_Nov_2003_20_43_18_+0100_2lAs+RSSn5M5rmGa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello,

this patch is a proposal for a 'generic' system. 

BTW, I had some problems to compile autofs-4.1.0-beta3 without openldap.
The following command helped me to get rid of this:

$ cd autofs-4.1.0-beta3
$ sed -i  -e 's|^all:.*|all: rc.autofs|g' \
 -e 's|.*install -c autofs-ldap-auto-master.*||g' \
 samples/Makefile
$

If you already know this, I'm sorry.

bye,

Daniel

-- 
Daniel Mueller			mailto:danm@gmx.li
Berlin, Germany		(OpenPGP:  1024D/F7E7C01F)

--Multipart=_Sat__29_Nov_2003_20_43_18_+0100_2lAs+RSSn5M5rmGa
Content-Type: application/octet-stream;
 name="autofs-4.1.0-beta3.patch"
Content-Disposition: attachment;
 filename="autofs-4.1.0-beta3.patch"
Content-Transfer-Encoding: base64

LS0tIGF1dG9mcwkyMDAzLTExLTI3IDIzOjIyOjE4LjAwMDAwMDAwMCArMDEwMAorKysgYXV0b2Zz
Lm5ldwkyMDAzLTExLTI5IDE5OjU4OjE5LjAwMDAwMDAwMCArMDEwMApAQCAtMzYsMTQgKzM2LDE2
IEBACiAjCiAjIERldGVybWluZSB3aGljaCBraW5kIG9mIGNvbmZpZ3VyYXRpb24gd2UncmUgdXNp
bmcKICMKKyMgVHJ5ICdnZW5lcmljJyBpZiB5b3UgaGF2ZSBhbiB1bnN1cHBvcnRlZCBzeXN0ZW0u
Cisjc3lzdGVtPWdlbmVyaWMKKwogc3lzdGVtPXVua25vd24KIGlmIFsgLWYgL2V0Yy9kZWJpYW5f
dmVyc2lvbiBdOyB0aGVuCiAgICAgc3lzdGVtPWRlYmlhbgogZWxpZiBbIC1mIC9ldGMvcmVkaGF0
LXJlbGVhc2UgXTsgdGhlbgogICAgIHN5c3RlbT1yZWRoYXQKLWVsc2UKK2VsaWYgWyAiJHN5c3Rl
bSIgPSAidW5rbm93biIgXTsgdGhlbgogICAgIGVjaG8gIiQwOiBVbmtub3duIHN5c3RlbSwgcGxl
YXNlIHBvcnQgYW5kIGNvbnRhY3QgYXV0b2ZzQGxpbnV4Lmtlcm5lbC5vcmciIDE+JjIKLSAgICBl
eGl0IDEKIGZpCiAKIGlmIFsgJHN5c3RlbSA9IHJlZGhhdCBdOyB0aGVuCkBAIC0xMzksNiArMTQx
LDE0IEBACiAgICAgICAgICAgICAgICAgOzsKICAgICAgICAgZXNhYwogICAgIGRvbmUKKyAgICBp
ZiBbIC16ICJgZ2V0c2NoZW1lc2AiIF07IHRoZW4KKyAgICAgICAgIyBhdXRvbW91bnQgZW50cnkg
aW4gL2V0Yy9uc3N3aXRjaC5jb25mIG5vdCBmb3VuZAorCWlmIFsgLXogIiRmaWxlc2NoZW1lIiBd
IDsgdGhlbgorCQlnZXRmaWxlbW91bnRzCisJCWZpbGVzY2hlbWU9MQorCQlleHBvcnQgZmlsZXNj
aGVtZQorCWZpCisgICAgZmkKIH0KIAogCkBAIC00MDEsMTEgKzQxMSw1OSBAQAogZXNhYwogfQog
CisKKyMKKyMgR2VuZXJpYyBzdGFydC9zdG9wIGZ1bmN0aW9uLgorIworZnVuY3Rpb24gZ2VuZXJp
YygpCit7CisKK2Nhc2UgIiQxIiBpbgorICBzdGFydCkKKyAgICAgICAgIyBNYWtlIHN1cmUgdGhl
IGF1dG9mcyBmaWxlc3lzdGVtIHR5cGUgaXMgYXZhaWxhYmxlLgorICAgICAgICAoZ3JlcCAtcSBh
dXRvZnMgL3Byb2MvZmlsZXN5c3RlbXMgfHwgL3NiaW4vbW9kcHJvYmUgLWsgYXV0b2ZzNCB8fCAv
c2Jpbi9tb2Rwcm9iZSAtayBhdXRvZnMpIDI+IC9kZXYvbnVsbAorICAgICAgICBUTVA9YG1rdGVt
cCAvdG1wL2F1dG9mcy5YWFhYWFhgIHx8IHsgZWNobyAkImNvdWxkIG5vdCBtYWtlIHRlbXAgZmls
ZSIgPiYgMjsgZXhpdCAxOyB9CisgICAgICAgIGdldG1vdW50cyB8IHRlZSAkVE1QIHwgc2gKKyAg
ICAgICAgUkVUVkFMPSQ/CisJaWYgWyAtcyAkVE1QIF0gOyB0aGVuCisJICAgIFsgJFJFVFZBTCA9
IDAgXSB8fCBlY2hvICJTdGFydGluZyBhdXRvbW91bnRlciBmYWlsZWQiCisJZWxzZQorCSAgICBl
Y2hvICJObyBNb3VudHBvaW50cyBEZWZpbmVkIgorCWZpCisJcm0gLWYgJFRNUAorCWVjaG8KKwk7
OworICBzdG9wKQorCWtpbGxhbGwgLVVTUjIgJERBRU1PTiAyPiAvZGV2L251bGwKKwljb3VudD0w
CisJd2hpbGUgWyAtbiAiYHBpZG9mICREQUVNT05gIiAtYSAkY291bnQgLWx0IDEwIF0gOyBkbwor
CSAgIGtpbGxhbGwgLVVTUjIgJERBRU1PTiAyPiAvZGV2L251bGwKKwkgICBSRVRWQUw9JD8KKwkg
ICBbICRSRVRWQUwgPSAwIC1hIC16ICJgcGlkb2YgJERBRU1PTmAiIF0gfHwgc2xlZXAgMworCSAg
IGNvdW50PWBleHByICRjb3VudCArIDFgCisJZG9uZQorCXVtb3VudCAtYSAtZiAtdCBhdXRvZnMK
KwllY2hvCisJOzsKKyAgcmVzdGFydCkKKwlnZW5lcmljIHN0b3AKKwlnZW5lcmljIHN0YXJ0CisJ
OzsKKyAgc3RhdHVzKQorCXN0YXR1cworCTs7CisgICopCisJZWNobyAkIlVzYWdlOiAkMCB7c3Rh
cnR8c3RvcHxyZXN0YXJ0fHN0YXR1c30iCitlc2FjCit9CisKIFJFVFZBTD0wCiBpZiBbICRzeXN0
ZW0gPSBkZWJpYW4gXTsgdGhlbgogCWRlYmlhbiAiJEAiCiBlbGlmIFsgJHN5c3RlbSA9IHJlZGhh
dCBdOyB0aGVuCiAJcmVkaGF0ICIkQCIKK2VsaWYgWyAkc3lzdGVtID0gZ2VuZXJpYyBdOyB0aGVu
CisJZ2VuZXJpYyAiJEAiCiBmaQogCiBleGl0ICRSRVRWQUwK

--Multipart=_Sat__29_Nov_2003_20_43_18_+0100_2lAs+RSSn5M5rmGa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Multipart=_Sat__29_Nov_2003_20_43_18_+0100_2lAs+RSSn5M5rmGa--

