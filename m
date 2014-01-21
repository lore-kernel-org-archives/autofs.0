From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: [PATCH] Extend fix for crash due to thread unsafe use of libldap
Date: Mon, 20 Jan 2014 22:26:57 -0200
Message-ID: <CAEySpB6AgCD+NJtpf-dHxC=gy2eNyg63Jeok19_3rmUDtB+Zjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e01538360e4f4a504f0701041
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kLjn/zkSDnWUCEOdciasXejmIvrt55D4yKkjWRFvGOI=;
        b=bONqvI1E/giYuhv4jH5MNRGeJEySxspPOc8vPjtzKdFgGujTcOjegrZdVCHpt3f40l
         s1i0JqbDOmAy9YDmuio3eweoNrVfQ2+tSX+SanflihWb+wAmOFXMJFsvefpTeCWNtsre
         EfIf3JSVevKo0GYzHdSoJEnG0eCddF1BXX+HmDo1YMQzzdemplA5Denr/zbYcbPXjvSW
         MfQSeFMbbXoW25x2KmHatE8RHQN0UQ7FD0zpKn5PXNoeTUSa2ODBhgom80Ob6Z7c79ea
         tmfB0rA6hvafuUoQ9aV0ROP+IgYdrXD2aWM9AFTOCng3aHpTS1I/qU5ePa7R9By6sb0t
         lQgg==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs <autofs@vger.kernel.org>

--089e01538360e4f4a504f0701041
Content-Type: text/plain; charset=ISO-8859-1

Hello Ian,

I got a similar report to the one that resulted in commit 9fc20db13.
This time automount crashed in unbind_ldap_connection():

Thread 1 (Thread 0x7f4a8ae44700 (LWP 851)):
#0  0x00007f4a8fab3729 in sk_free () from ./usr/lib64/libcrypto.so.0.9.8
#1  0x00007f4a8fd9f819 in SSL_SESSION_free () from ./usr/lib64/libssl.so.0.9.8
#2  0x00007f4a8fab3ae3 in ?? () from ./usr/lib64/libcrypto.so.0.9.8
#3  0x00007f4a8fd9f737 in SSL_CTX_flush_sessions () from
./usr/lib64/libssl.so.0.9.8
#4  0x00007f4a8fd9d772 in SSL_CTX_free () from ./usr/lib64/libssl.so.0.9.8
#5  0x00007f4a8fd9e210 in SSL_free () from ./usr/lib64/libssl.so.0.9.8
#6  0x00007f4a90efb8ea in ?? () from ./usr/lib64/libldap-2.4.so.2
#7  0x00007f4a90cc1406 in ber_sockbuf_remove_io () from
./usr/lib64/liblber-2.4.so.2
#8  0x00007f4a90cc149d in ber_int_sb_destroy () from
./usr/lib64/liblber-2.4.so.2
#9  0x00007f4a90cc151c in ber_sockbuf_free () from ./usr/lib64/liblber-2.4.so.2
#10 0x00007f4a90edffdc in ldap_ld_free () from ./usr/lib64/libldap-2.4.so.2
#11 0x00007f4a91118000 in unbind_ldap_connection () from
./usr/lib64/autofs/lookup_ldap.so
#12 0x00007f4a9111c0f9 in lookup_mount () from
./usr/lib64/autofs/lookup_ldap.so
#13 0x00007f4a9333be00 in lookup_nss_mount ()
#14 0x00007f4a93333be5 in ?? ()
#15 0x00007f4a92eee7b6 in start_thread () from ./lib64/libpthread.so.0
#16 0x00007f4a92032c5d in clone () from ./lib64/libc.so.6
#17 0x0000000000000000 in ?? ()

It's necessary to serialize calls to ldap_unbind() as well. Please consider
the patch attached for inclusion.

Thanks,
Leonardo

--089e01538360e4f4a504f0701041
Content-Type: text/x-patch; charset=US-ASCII; 
	name="autofs-5.0.8-extend-libldap-serialization.patch"
Content-Disposition: attachment; 
	filename="autofs-5.0.8-extend-libldap-serialization.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqofa8j80

SW5kZXg6IGF1dG9mcy01LjAuOC9DSEFOR0VMT0cKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gYXV0b2ZzLTUuMC44
Lm9yaWcvQ0hBTkdFTE9HCisrKyBhdXRvZnMtNS4wLjgvQ0hBTkdFTE9HCkBAIC02LDYgKzYsNyBA
QAogLSBhbGxvdyAtLXdpdGgtc3lzdGVtZCB0byB0YWtlIGEgcGF0aCBhcmcuCiAtIGZpeCBXSVRI
X0xJQlRJUlBDIGZ1bmN0aW9uIG5hbWUuCiAtIGZpeCBpcHY2IGxpYnRpcnBjIGdldHBvcnQuCist
IGV4dGVuZCBmaXggZm9yIGNyYXNoIGR1ZSB0byB0aHJlYWQgdW5zYWZlIHVzZSBvZiBsaWJsZGFw
LgogCiAxNy8xMC8yMDEzIGF1dG9mcy01LjAuOAogPT09PT09PT09PT09PT09PT09PT09PT0KSW5k
ZXg6IGF1dG9mcy01LjAuOC9tb2R1bGVzL2xvb2t1cF9sZGFwLmMKPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gYXV0
b2ZzLTUuMC44Lm9yaWcvbW9kdWxlcy9sb29rdXBfbGRhcC5jCisrKyBhdXRvZnMtNS4wLjgvbW9k
dWxlcy9sb29rdXBfbGRhcC5jCkBAIC01Myw4ICs1Myw5IEBAIHN0YXRpYyBzdHJ1Y3QgbGRhcF9z
Y2hlbWEgY29tbW9uX3NjaGVtYVsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgY29tbW9uX3NjaGVtYV9j
b3VudCA9IHNpemVvZihjb21tb25fc2NoZW1hKS9zaXplb2Yoc3RydWN0IGxkYXBfc2NoZW1hKTsK
IAogLyoKLSAqIEluaXRpYWxpemF0aW9uIG9mIExEQVAgYW5kIE9wZW5TU0wgbXVzdCBiZSBhbHdh
eXMgc2VyaWFsaXplZCB0bwotICogYXZvaWQgY29ycnVwdGlvbiBvZiBjb250ZXh0IHN0cnVjdHVy
ZXMgaW5zaWRlIHRoZXNlIGxpYnJhcmllcy4KKyAqIEluaXRpYWxpemF0aW9uIGFuZCBkZS1pbml0
aWFsaXphdGlvbiBvZiBMREFQIGFuZCBPcGVuU1NMIG11c3QgYmUKKyAqIGFsd2F5cyBzZXJpYWxp
emVkIHRvIGF2b2lkIGNvcnJ1cHRpb24gb2YgY29udGV4dCBzdHJ1Y3R1cmVzIGluc2lkZQorICog
dGhlc2UgbGlicmFyaWVzLgogICovCiBwdGhyZWFkX211dGV4X3QgbGRhcGluaXRfbXV0ZXggPSBQ
VEhSRUFEX01VVEVYX0lOSVRJQUxJWkVSOwogCkBAIC0yMDMsNyArMjA0LDcgQEAgaW50IGJpbmRf
bGRhcF9zaW1wbGUodW5zaWduZWQgbG9nb3B0LCBMRAogCXJldHVybiAwOwogfQogCi1pbnQgdW5i
aW5kX2xkYXBfY29ubmVjdGlvbih1bnNpZ25lZCBsb2dvcHQsIExEQVAgKmxkYXAsIHN0cnVjdCBs
b29rdXBfY29udGV4dCAqY3R4dCkKK2ludCBfX3VuYmluZF9sZGFwX2Nvbm5lY3Rpb24odW5zaWdu
ZWQgbG9nb3B0LCBMREFQICpsZGFwLCBzdHJ1Y3QgbG9va3VwX2NvbnRleHQgKmN0eHQpCiB7CiAJ
aW50IHJ2OwogCkBAIC0yMjAsNiArMjIxLDE3IEBAIGludCB1bmJpbmRfbGRhcF9jb25uZWN0aW9u
KHVuc2lnbmVkIGxvZ28KIAlyZXR1cm4gcnY7CiB9CiAKK2ludCB1bmJpbmRfbGRhcF9jb25uZWN0
aW9uKHVuc2lnbmVkIGxvZ29wdCwgTERBUCAqbGRhcCwgc3RydWN0IGxvb2t1cF9jb250ZXh0ICpj
dHh0KQoreworCWludCBydjsKKworCWxkYXBpbml0X211dGV4X2xvY2soKTsKKwlydiA9IF9fdW5i
aW5kX2xkYXBfY29ubmVjdGlvbihsb2dvcHQsIGxkYXAsIGN0eHQpOworCWxkYXBpbml0X211dGV4
X3VubG9jaygpOworCisJcmV0dXJuIHJ2OworfQorCiBMREFQICpfX2luaXRfbGRhcF9jb25uZWN0
aW9uKHVuc2lnbmVkIGxvZ29wdCwgY29uc3QgY2hhciAqdXJpLCBzdHJ1Y3QgbG9va3VwX2NvbnRl
eHQgKmN0eHQpCiB7CiAJTERBUCAqbGRhcCA9IE5VTEw7CkBAIC0yODAsNyArMjkyLDcgQEAgTERB
UCAqX19pbml0X2xkYXBfY29ubmVjdGlvbih1bnNpZ25lZCBsbwogCiAJCXJ2ID0gbGRhcF9zdGFy
dF90bHNfcyhsZGFwLCBOVUxMLCBOVUxMKTsKIAkJaWYgKHJ2ICE9IExEQVBfU1VDQ0VTUykgewot
CQkJdW5iaW5kX2xkYXBfY29ubmVjdGlvbihsb2dvcHQsIGxkYXAsIGN0eHQpOworCQkJX191bmJp
bmRfbGRhcF9jb25uZWN0aW9uKGxvZ29wdCwgbGRhcCwgY3R4dCk7CiAJCQlpZiAoY3R4dC0+dGxz
X3JlcXVpcmVkKSB7CiAJCQkJZXJyb3IobG9nb3B0LCBNT0RQUkVGSVgKIAkJCQkgICAgICAiVExT
IHJlcXVpcmVkIGJ1dCBTVEFSVF9UTFMgZmFpbGVkOiAlcyIsCg==
--089e01538360e4f4a504f0701041--
