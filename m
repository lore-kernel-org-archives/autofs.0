From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: [PATCH] Fix deadlock in init_ldap_connection()
Date: Wed, 22 Jan 2014 18:41:25 -0200
Message-ID: <CAEySpB4J=TkM=AeZC+7XzvoroHk+G_i4k5gxUc8ppedFYeJuHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e0158b2420be81d04f09526f4
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=IOrG7vtKj5suzQd3wXt0EHiCCJez25xMlNCNDSYuc8s=;
        b=v54nwTnRU8AkEWz26n2u3BbY8P0IXGQTrqT9TTsD9s+dhCq5NBGYKrbQBXXrxkVZjy
         rO/9vZs+OWAawNFaTVZesra5Ljwfb6edw+FwnDMnymSE5u/Wp2bif9RN5UnhmjIvJPiu
         iDx/Hr3Anr5ZinFjmt6mWnbnEk2ZJh94q1Frw2GcIDQ7pxvBJfrOHLH8+RydjHZP0g1Y
         BYbWisU62LXf4SkTO1pgqzyE34ViTm3lfZYVIFVO0AM1RZf2Pf33282J5wv2YHnTXZN9
         igchUmONLwwIMtKtlGnFVHXaqnHgGfidugYjnYVwv5aO6/dij786EBo287cyYx7E0VoS
         32hw==
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: autofs <autofs@vger.kernel.org>

--089e0158b2420be81d04f09526f4
Content-Type: text/plain; charset=ISO-8859-1

Hi Ian,

I submitted a patch some time ago (commit 9fc20db13) that
unfortunately introduces a regression when using LDAP with
TLS. Sorry about that. I'm attaching a patch to fix this.

Leonardo

--089e0158b2420be81d04f09526f4
Content-Type: text/x-patch; charset=US-ASCII; 
	name="autofs-5.0.8-fix-deadlock-in-init-ldap-connection.patch"
Content-Disposition: attachment; 
	filename="autofs-5.0.8-fix-deadlock-in-init-ldap-connection.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hqr2542g0

Rml4IGRlYWRsb2NrIGluIGluaXRfbGRhcF9jb25uZWN0aW9uKCkKCkNvbW1pdCA5ZmMyMGRiMTMg
KCJmaXggY3Jhc2ggZHVlIHRvIHRocmVhZCB1bnNhZmUgdXNlIG9mIGxpYmxkYXAiKQppbnRyb2R1
Y2VkIGEgZGVhZGxvY2sgaW4gaW5pdF9sZGFwX2Nvbm5lY3Rpb24oKS4gV2hlbiBUTFMgaXMgb24s
CnRoaXMgZnVuY3Rpb24gd2lsbCBjYWxsIGl0c2VsZiByZWN1cnNpdmVseSBhbmQgdHJ5IHRvIGxv
Y2sgYSBtdXRleAp0aGF0J3MgYWxyZWFkeSBvd25lZCBieSB0aGUgdGhyZWFkLiBGaXggdGhlIHBy
b2JsZW0gYnkgdXNpbmcgdGhlCmxvY2tsZXNzIHZlcnNpb24uCgpJbmRleDogYXV0b2ZzLTUuMC44
L21vZHVsZXMvbG9va3VwX2xkYXAuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBhdXRvZnMtNS4wLjgub3JpZy9t
b2R1bGVzL2xvb2t1cF9sZGFwLmMKKysrIGF1dG9mcy01LjAuOC9tb2R1bGVzL2xvb2t1cF9sZGFw
LmMKQEAgLTMwMCw3ICszMDAsNyBAQCBMREFQICpfX2luaXRfbGRhcF9jb25uZWN0aW9uKHVuc2ln
bmVkIGxvCiAJCQkJcmV0dXJuIE5VTEw7CiAJCQl9CiAJCQljdHh0LT51c2VfdGxzID0gTERBUF9U
TFNfRE9OVF9VU0U7Ci0JCQlsZGFwID0gaW5pdF9sZGFwX2Nvbm5lY3Rpb24obG9nb3B0LCB1cmks
IGN0eHQpOworCQkJbGRhcCA9IF9faW5pdF9sZGFwX2Nvbm5lY3Rpb24obG9nb3B0LCB1cmksIGN0
eHQpOwogCQkJaWYgKGxkYXApCiAJCQkJY3R4dC0+dXNlX3RscyA9IExEQVBfVExTX0lOSVQ7CiAJ
CQlyZXR1cm4gbGRhcDsKSW5kZXg6IGF1dG9mcy01LjAuOC9DSEFOR0VMT0cKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQot
LS0gYXV0b2ZzLTUuMC44Lm9yaWcvQ0hBTkdFTE9HCisrKyBhdXRvZnMtNS4wLjgvQ0hBTkdFTE9H
CkBAIC03LDYgKzcsNyBAQAogLSBmaXggV0lUSF9MSUJUSVJQQyBmdW5jdGlvbiBuYW1lLgogLSBm
aXggaXB2NiBsaWJ0aXJwYyBnZXRwb3J0LgogLSBleHRlbmQgZml4IGZvciBjcmFzaCBkdWUgdG8g
dGhyZWFkIHVuc2FmZSB1c2Ugb2YgbGlibGRhcC4KKy0gZml4IGRlYWRsb2NrIGluIGluaXRfbGRh
cF9jb25uZWN0aW9uLgogCiAxNy8xMC8yMDEzIGF1dG9mcy01LjAuOAogPT09PT09PT09PT09PT09
PT09PT09PT0K
--089e0158b2420be81d04f09526f4--
