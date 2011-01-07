From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
	servers
Date: Fri, 07 Jan 2011 14:12:58 +0100
Message-ID: <4D27115A.9010805@s3group.cz>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>	
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>	
	<4D2581F0.8020607@s3group.cz> <1294322864.2852.3.camel@perseus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050009090703000900030103"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1294322864.2852.3.camel@perseus>
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
To: Ian Kent <ikent@redhat.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--------------050009090703000900030103
Content-Type: multipart/alternative;
 boundary="------------010003090908000209000307"


--------------010003090908000209000307
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  On 06.01.2011 15:07, Ian Kent wrote:
> Thanks for the suggestions.
> I'm still on leave so things are still going slowly for now, but I'll
> get to it.
Hi Ian,

Please find the attached patch which fixes the problem for me.
I also changed the "dclist" structure definition from:

struct dclist {
         time_t expire;
         const char *uri;
};

into:

struct dclist {
         time_t expire;
         char **uri;
         int cnt;
};

Hope you'll find it useful :-) .
Ondrej

--------------010003090908000209000307
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body text=3D"#000066" bgcolor=3D"#ffffff">
    On 06.01.2011 15:07, Ian Kent wrote:
    <blockquote cite=3D"mid:1294322864.2852.3.camel@perseus" type=3D"cite=
">
      <pre wrap=3D"">Thanks for the suggestions.
I'm still on leave so things are still going slowly for now, but I'll
get to it.
</pre>
    </blockquote>
    Hi Ian,<br>
    <br>
    Please find the attached patch which fixes the problem for me.<br>
    I also changed the "dclist" structure definition from:<br>
    <br>
    struct dclist {<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_t expire;<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *uri;<br>
    };<br>
    <br>
    into:<br>
    <br>
    struct dclist {<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_t expire;<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char **uri;<br>
    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int cnt;<br>
    };<br>
    <br>
    Hope you'll find it useful <span class=3D"moz-smiley-s1"><span> :-) <=
/span></span>.<br>
    Ondrej<br>
  </body>
</html>

--------------010003090908000209000307--

--------------050009090703000900030103
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="patch"

ZGlmZiAtdSBtb2R1bGVzLm9sZC9kY2xpc3QuYyBtb2R1bGVzL2RjbGlzdC5jCi0tLSBtb2R1
bGVzLm9sZC9kY2xpc3QuYwkyMDEwLTA3LTE1IDEwOjQwOjQ5LjAwMDAwMDAwMCArMDIwMAor
KysgbW9kdWxlcy9kY2xpc3QuYwkyMDExLTAxLTA3IDEyOjMzOjUwLjAwMDAwMDAwMCArMDEw
MApAQCAtNTQ1LDggKzU0NSwxMiBAQAogCiB2b2lkIGZyZWVfZGNsaXN0KHN0cnVjdCBkY2xp
c3QgKmRjbGlzdCkKIHsKLQlpZiAoZGNsaXN0LT51cmkpCi0JCWZyZWUoKHZvaWQgKikgZGNs
aXN0LT51cmkpOworCWlmIChkY2xpc3QtPnVyaSl7CisJICAgIGZvcig7IGRjbGlzdC0+Y250
ID4gMDsgZGNsaXN0LT5jbnQtLSl7CisJCWZyZWUoZGNsaXN0LT51cmlbZGNsaXN0LT5jbnQt
MV0pOworCSAgICB9CisJfQorCWZyZWUoZGNsaXN0LT51cmkpOwogCWZyZWUoZGNsaXN0KTsK
IH0KIApAQCAtNTk5LDggKzYwMyw4IEBACiAJY2hhciBidWZbTUFYX0VSUl9CVUZdOwogCWNo
YXIgKmRuX3VyaSwgKmVzY191cmk7CiAJY2hhciAqZG9tYWluOwotCWNoYXIgKmxpc3Q7Ci0J
aW50IG51bWRjczsKKwljaGFyICoqbGlzdDsKKwlpbnQgdG90X251bWRjcyA9IDA7CiAJaW50
IHJldDsKIAogCWlmIChzdHJjbXAodXJpLCAibGRhcDovLy8iKSAmJiBzdHJjbXAodXJpLCAi
bGRhcHM6Ly8vIikpIHsKQEAgLTY3OSwxMCArNjgzLDExIEBACiAJbGlzdCA9IE5VTEw7CiAJ
Zm9yIChsdWRwID0gJmx1ZGxpc3Q7ICpsdWRwICE9IE5VTEw7KSB7CiAJCUxEQVBVUkxEZXNj
ICpsdWQgPSAqbHVkcDsKLQkJc2l6ZV90IHJlcV9sZW4sIGxlbjsKKwkJc2l6ZV90IHJlcV9s
ZW47CiAJCWNoYXIgKnJlcXVlc3QgPSBOVUxMOwotCQljaGFyICp0bXA7Ci0JCWludCBpOwor
CQljaGFyICoqdG1wbGlzdDsKKwkJaW50IHN0YXJ0LGk7CisJCWludCBudW1kY3M7CiAKIAkJ
aWYgKCFsdWQtPmx1ZF9kbiAmJiAhbHVkLT5sdWRfZG5bMF0gJiYKIAkJICAgKCFsdWQtPmx1
ZF9ob3N0IHx8ICFsdWQtPmx1ZF9ob3N0WzBdKSkgewpAQCAtNzI2LDM2ICs3MzEsNDggQEAK
IAkJZGNsaXN0X211dGV4X3VubG9jaygpOwogCQlmcmVlKHJlcXVlc3QpOwogCi0JCWxlbiA9
IHN0cmxlbihsdWQtPmx1ZF9zY2hlbWUpOwotCQlsZW4gKz0gc2l6ZW9mKCI6Ly8iKTsKLQkJ
bGVuICo9IG51bWRjczsKKy8vCQlsZW4gKj0gbnVtZGNzOworCQlzdGFydCA9IHRvdF9udW1k
Y3M7CisJCXRvdF9udW1kY3MgKz0gbnVtZGNzOwogCiAJCWZvciAoaSA9IDA7IGkgPCBudW1k
Y3M7IGkrKykgewogCQkJaWYgKGRjc1tpXS50dGwgPiAwICYmIGRjc1tpXS50dGwgPCBtaW5f
dHRsKQogCQkJCW1pbl90dGwgPSBkY3NbaV0udHRsOwotCQkJbGVuICs9IHN0cmxlbihkY3Nb
aV0uaG9zdG5hbWUpOwotCQkJaWYgKGRjc1tpXS5wb3J0ID4gMCkKLQkJCQlsZW4gKz0gc2l6
ZW9mKCI6NjU1MzUiKTsKIAkJfQogCi0JCXRtcCA9IHJlYWxsb2MobGlzdCwgbGVuKTsKLQkJ
aWYgKCF0bXApIHsKKwkJdG1wbGlzdCA9IHJlYWxsb2MobGlzdCwgc2l6ZW9mKGNoYXIgKikq
dG90X251bWRjcysxKTsKKwkJaWYgKCF0bXBsaXN0KSB7CiAJCQljaGFyICplc3RyID0gc3Ry
ZXJyb3JfcihlcnJubywgYnVmLCBNQVhfRVJSX0JVRik7CiAJCQllcnJvcihsb2dvcHQsICJy
ZWFsbG9jOiAlcyIsIGVzdHIpOwogCQkJZ290byBvdXRfZXJyb3I7CiAJCX0KKwkJbGlzdCA9
IHRtcGxpc3Q7CiAKLQkJaWYgKCFsaXN0KQotCQkJbWVtc2V0KHRtcCwgMCwgbGVuKTsKLQkJ
ZWxzZQotCQkJc3RyY2F0KHRtcCwgIiAiKTsKKy8vCQlpZiAoIWxpc3QpCisvLwkJCW1lbXNl
dCh0bXAsIDAsIGxlbik7CisvLwkJZWxzZQorLy8JCQlzdHJjYXQodG1wLCAiICIpOwogCiAJ
CWZvciAoaSA9IDA7IGkgPCBudW1kY3M7IGkrKykgewotCQkJaWYgKGkgPiAwKQotCQkJCXN0
cmNhdCh0bXAsICIgIik7Ci0JCQlzdHJjYXQodG1wLCBsdWQtPmx1ZF9zY2hlbWUpOworCQkJ
Y2hhciAqdG1wOworCQkJc2l6ZV90IGxlbjsKKwkJCQorCQkJbGVuID0gc3RybGVuKGx1ZC0+
bHVkX3NjaGVtZSk7CisJCQlsZW4gKz0gc2l6ZW9mKCI6Ly8iKTsKKwkJCWxlbiArPSBzdHJs
ZW4oZGNzW2ldLmhvc3RuYW1lKTsKKwkJCWlmIChkY3NbaV0ucG9ydCA+IDApCisJCQkJbGVu
ICs9IHNpemVvZigiOjY1NTM1Iik7CisJCQl0bXAgPSBtYWxsb2Moc2l6ZW9mKGNoYXIpKmxl
bisxKTsKKwkJCWlmKCAhdG1wICl7CisJCQkgICAgY2hhciAqZXN0ciA9IHN0cmVycm9yX3Io
ZXJybm8sIGJ1ZiwgTUFYX0VSUl9CVUYpOworCQkJICAgIGVycm9yKGxvZ29wdCwgIm1hbGxv
YzogJXMiLCBlc3RyKTsKKwkJCSAgICBnb3RvIG91dF9lcnJvcjsKKwkJCX0KKwkJCXN0cmNw
eSh0bXAsIGx1ZC0+bHVkX3NjaGVtZSk7CiAJCQlzdHJjYXQodG1wLCAiOi8vIik7CiAJCQlz
dHJjYXQodG1wLCBkY3NbaV0uaG9zdG5hbWUpOworCQkJbGlzdFtzdGFydCsrXSA9IHRtcDsK
KwkJCWxpc3Rbc3RhcnRdID0gMDsKIAkJCWlmIChkY3NbaV0ucG9ydCA+IDApIHsKIAkJCQlj
aGFyIHBvcnRbN107CiAJCQkJcmV0ID0gc25wcmludGYocG9ydCwgNywgIjolZCIsIGRjc1tp
XS5wb3J0KTsKQEAgLTc2Nyw3ICs3ODQsNiBAQAogCQkJCXN0cmNhdCh0bXAsIHBvcnQpOwog
CQkJfQogCQl9Ci0JCWxpc3QgPSB0bXA7CiAKIAkJKmx1ZHAgPSBsdWQtPmx1ZF9uZXh0Owog
CQliZXJfbWVtZnJlZShkb21haW4pOwpAQCAtNzc3LDEyICs3OTMsMTggQEAKIAogCWRjbGlz
dC0+ZXhwaXJlID0gdGltZShOVUxMKSArIG1pbl90dGw7CiAJZGNsaXN0LT51cmkgPSBsaXN0
OworCWRjbGlzdC0+Y250ID0gdG90X251bWRjczsKIAogCXJldHVybiBkY2xpc3Q7CiAKIG91
dF9lcnJvcjoKLQlpZiAobGlzdCkKLQkJZnJlZShsaXN0KTsKKwlpZiAobGlzdCl7CisJICAg
IGNoYXIgKnRtcCA9IGxpc3RbMF07CisJICAgIHdoaWxlICh0bXApeworCQlmcmVlKHRtcCk7
CisJICAgIH0KKwkgICAgZnJlZShsaXN0KTsKKwl9ICAgIAkKIAlpZiAoZG9tYWluKQogCQli
ZXJfbWVtZnJlZShkb21haW4pOwogCWxkYXBfZnJlZV91cmxkZXNjKGx1ZGxpc3QpOwpkaWZm
IC11IG1vZHVsZXMub2xkL2xvb2t1cF9sZGFwLmMgbW9kdWxlcy9sb29rdXBfbGRhcC5jCi0t
LSBtb2R1bGVzLm9sZC9sb29rdXBfbGRhcC5jCTIwMTAtMDctMTUgMTA6NDA6NDkuMDAwMDAw
MDAwICswMjAwCisrKyBtb2R1bGVzL2xvb2t1cF9sZGFwLmMJMjAxMS0wMS0wNyAxMjo0MDox
MS4wMDAwMDAwMDAgKzAxMDAKQEAgLTU3MSw5ICs1NzEsOCBAQAogCQlpZiAoIXN0cnN0cih0
aGlzLT51cmksICI6Ly8vIikpCiAJCQl1cmkgPSBzdHJkdXAodGhpcy0+dXJpKTsKIAkJZWxz
ZSB7Ci0JCQlpZiAoZGNsaXN0KQotCQkJCXVyaSA9IHN0cmR1cChkY2xpc3QtPnVyaSk7Ci0J
CQllbHNlIHsKKwkJCWludCBpID0gMDsKKwkJCWlmICghZGNsaXN0KXsKIAkJCQlzdHJ1Y3Qg
ZGNsaXN0ICp0bXA7CiAJCQkJdG1wID0gZ2V0X2RjX2xpc3QobG9nb3B0LCB0aGlzLT51cmkp
OwogCQkJCWlmICghdG1wKSB7CkBAIC01ODEsOCArNTgwLDE3IEBACiAJCQkJCWNvbnRpbnVl
OwogCQkJCX0KIAkJCQlkY2xpc3QgPSB0bXA7Ci0JCQkJdXJpID0gc3RyZHVwKGRjbGlzdC0+
dXJpKTsKIAkJCX0KKwkJCXdoaWxlKGRjbGlzdC0+dXJpW2ldICE9IE5VTEwpeworCQkJICAg
IHVyaSA9IGRjbGlzdC0+dXJpW2krK107CisJCQkgICAgZGVidWcobG9nb3B0LCAidHJ5aW5n
IHNlcnZlciB1cmkgJXMiLCB1cmkpOworCQkJICAgIGxkYXAgPSBjb25uZWN0X3RvX3NlcnZl
cihsb2dvcHQsIHVyaSwgY3R4dCk7CisJCQkgICAgaWYgKGxkYXApIHsKKwkJCQlpbmZvKGxv
Z29wdCwgImNvbm5lY3RlZCB0byB1cmkgJXMiLCB1cmkpOworCQkJCWJyZWFrOworCQkJICAg
IH0KKwkJCX0KKwkJCWlmKGxkYXApIGJyZWFrOyAgICAKIAkJfQogCQlpZiAoIXVyaSkgewog
CQkJaWYgKGRjbGlzdCkgewpAQCAtNjQ0LDkgKzY1MiwxMiBAQAogCX0KIAogCXVyaXNfbXV0
ZXhfbG9jayhjdHh0KTsKLQlpZiAoY3R4dC0+ZGNsaXN0KQotCQl1cmkgPSBzdHJkdXAoY3R4
dC0+ZGNsaXN0LT51cmkpOwotCWVsc2UgaWYgKGN0eHQtPnVyaSkKKwlpZiAoY3R4dC0+ZGNs
aXN0KXsKKy8qIHRoaXMgaXMgcHJvYmFibHkgd3JvbmcgLSBub3Qgd2hhdCB3ZSB3YW50ICov
CisvLwkJdXJpID0gc3RyZHVwKGN0eHQtPmRjbGlzdC0+dXJpKTsKKwkJdXJpc19tdXRleF91
bmxvY2soY3R4dCk7CisJCWdvdG8gZmluZF9zZXJ2ZXI7CisJfSBlbHNlIGlmIChjdHh0LT51
cmkpCiAJCXVyaSA9IHN0cmR1cChjdHh0LT51cmktPnVyaSk7CiAJZWxzZSB7CiAJCXVyaXNf
bXV0ZXhfdW5sb2NrKGN0eHQpOwo=
--------------050009090703000900030103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------050009090703000900030103--

