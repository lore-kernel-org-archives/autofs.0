From: raven@themaw.net
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port 
	usage problems
Date: Fri, 14 Jan 2005 22:35:08 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0501142225200.2519@donald.themaw.net>
References: <200501130037.j0D0bNDj012842@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1629620785-933557400-1105713308=:2519"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200501130037.j0D0bNDj012842@jetcar.spd.analog.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1629620785-933557400-1105713308=:2519
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


Hi Mike,

I have attached a patch I'd like you to try please.

I think I`ve been able to duplicate the problem here between my Gentoo 
2.4 kernel and my Debian 2.4 kernel systems. I've had trouble with NFS 
export permissions between my FC2 2.6 and the Debian 2.4 systems so I 
can't be sure about it.

I've used the patch, as an additional patch after all the others, to build 
rpms with Jefs' autofs-4.1.3-16 and autofs-4.1.3-55.1 source rpms so I 
hope it will apply OK to the rpm you are using.

On Wed, 12 Jan 2005, David Meleedy wrote:

>
> Mike,
> 	I just recompiled my kernel with your xprt-sharing.patch.
> Although this did fix the port error problems, it did not fix
> the automounter problem.  So I think your patch should be incorporated
> into Redhat Enterprise 3 (2.4 kernel) because it appears to work.
>
> I think the problem is that the automounter just cannot unmount
> the /net/aflac directory, and ends up trying to remount it instead,
> here are the log files after the port patch that Mike gave me:
> (this is during the reboot after cd'ing to /net/aflac/vol/vol2)
>
> Jan 12 19:23:36 codered automount[5396]: can't shutdown: filesystem /net still
> busy
> Jan 12 19:23:38 codered autofs: automount -USR2 succeeded
> Jan 12 19:23:41 codered automount[5396]: can't shutdown: filesystem /net still
> busy
> ... those lines keep repeating until ....
>
> Jan 12 19:24:08 codered automount[16092]: >> mount table full
> Jan 12 19:24:08 codered automount[16092]: mount(nfs): nfs: mount failure
> aflac:/vol/vol3/cad_archive on /net/aflac/vol/vol3/cad_archive
> Jan 12 19:24:08 codered automount[16092]: >> mount table full
> Jan 12 19:24:08 codered automount[16092]: mount(nfs): nfs: mount failure
> aflac:/vol/vol3/design on /net/aflac/vol/vol3/design
> ... those lines repeart for each subdirectory of the volumes ...
>
> Jan 12 19:24:09 codered autofs: automount shutdown failed
>
> As you can see, it keeps trying to unmount /net, and eventually
> fills up the mount table because it instead remounts it.  Before,
> when the port issue was a problem, it wouldn't get far enough to
> fill the mount table, but now it can (thanks Mike!)
>
> -Dave
>
> ________________________________________________________________________
> David Meleedy				Analog Devices, Inc.
> David.Meleedy@analog.com		Three Technology Way
> Phone: 781 461 3494			Norwood, MA  02062-9106  USA
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>

--1629620785-933557400-1105713308=:2519
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name="autofs-4.1.3-multi-over.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0501142235080.2519@donald.themaw.net>
Content-Description: 
Content-Disposition: attachment; filename="autofs-4.1.3-multi-over.patch"

LS0tIGF1dG9mcy00LjEuMy9tb2R1bGVzL3BhcnNlX3N1bi5jLm11bHRpLW92
ZXIJMjAwNS0wMS0xNCAxOTo0NDozOS4wMDAwMDAwMDAgKzA4MDANCisrKyBh
dXRvZnMtNC4xLjMvbW9kdWxlcy9wYXJzZV9zdW4uYwkyMDA1LTAxLTE0IDIw
OjM2OjE3LjAwMDAwMDAwMCArMDgwMA0KQEAgLTU1LDYgKzU1LDEzIEBADQog
CWludCBzbGFzaGlmeV9jb2xvbnM7CS8qIENoYW5nZSBjb2xvbnMgdG8gc2xh
c2hlcz8gKi8NCiB9Ow0KIA0KK3N0cnVjdCBtdWx0aV9tbnQgew0KKwljaGFy
ICpwYXRoOw0KKwljaGFyICpvcHRpb25zOw0KKwljaGFyICpsb2NhdGlvbjsN
CisJc3RydWN0IG11bHRpX21udCAqbmV4dDsNCit9Ow0KKw0KIHN0cnVjdCB1
dHNuYW1lIHVuOw0KIGNoYXIgcHJvY2Vzc29yWzY1XTsJCS8qIE5vdCBkZWZp
bmVkIG9uIExpbnV4LCBzbyB3ZSBtYWtlIG91ciBvd24gKi8NCiANCkBAIC02
MDksNiArNjE2LDY5IEBADQogfQ0KIA0KIC8qDQorICogQnVpbGQgbGlzdCBv
ZiBtb3VudHMgaW4gc2hvcnRlc3QgLT4gbG9uZ2VzdCBvcmRlci4NCisgKiBQ
YXNzIGluIGxpc3QgaGVhZCBhbmQgcmV0dXJuIGxpc3QgaGVhZC4NCisgKi8N
CitzdHJ1Y3QgbXVsdGlfbW50ICptdWx0aV9hZGRfbGlzdChzdHJ1Y3QgbXVs
dGlfbW50ICpsaXN0LA0KKwkJCQkgY2hhciAqcGF0aCwgY2hhciAqb3B0aW9u
cywgY2hhciAqbG9jYXRpb24pDQorew0KKwlzdHJ1Y3QgbXVsdGlfbW50ICpt
bXB0ciwgKm5ldywgKm9sZCA9IE5VTEw7DQorCWludCBwbGVuOw0KKw0KKwlp
ZiAoIXBhdGggfHwgIW9wdGlvbnMgfHwgIWxvY2F0aW9uKQ0KKwkJcmV0dXJu
IE5VTEw7DQorDQorCW5ldyA9IG1hbGxvYyhzaXplb2Yoc3RydWN0IG11bHRp
X21udCkpOw0KKwlpZiAoIW5ldykNCisJCXJldHVybiBOVUxMOw0KKw0KKwlu
ZXctPnBhdGggPSBwYXRoOw0KKwluZXctPm9wdGlvbnMgPSBvcHRpb25zOw0K
KwluZXctPmxvY2F0aW9uID0gbG9jYXRpb247DQorDQorCXBsZW4gPSBzdHJs
ZW4ocGF0aCk7DQorCW1tcHRyID0gbGlzdDsNCisJd2hpbGUgKG1tcHRyKSB7
DQorCQlpZiAocGxlbiA8PSBzdHJsZW4obW1wdHItPnBhdGgpKQ0KKwkJCWJy
ZWFrOw0KKwkJb2xkID0gbW1wdHI7DQorCQltbXB0ciA9IG1tcHRyLT5uZXh0
Ow0KKwl9DQorDQorCWlmIChvbGQpDQorCQlvbGQtPm5leHQgPSBuZXc7DQor
CW5ldy0+bmV4dCA9IG1tcHRyOw0KKw0KKwlyZXR1cm4gb2xkID8gbGlzdCA6
IG5ldzsNCit9DQorDQordm9pZCBtdWx0aV9mcmVlX2xpc3Qoc3RydWN0IG11
bHRpX21udCAqbGlzdCkNCit7DQorCXN0cnVjdCBtdWx0aV9tbnQgKm5leHQ7
DQorDQorCWlmICghbGlzdCkNCisJCXJldHVybjsNCisNCisJbmV4dCA9IGxp
c3Q7DQorCXdoaWxlIChuZXh0KSB7DQorCQlzdHJ1Y3QgbXVsdGlfbW50ICp0
aGlzID0gbmV4dDsNCisNCisJCW5leHQgPSB0aGlzLT5uZXh0Ow0KKw0KKwkJ
aWYgKHRoaXMtPnBhdGgpDQorCQkJZnJlZSh0aGlzLT5wYXRoKTsNCisNCisJ
CWlmICh0aGlzLT5vcHRpb25zKQ0KKwkJCWZyZWUodGhpcy0+b3B0aW9ucyk7
DQorDQorCQlpZiAodGhpcy0+bG9jYXRpb24pDQorCQkJZnJlZSh0aGlzLT5s
b2NhdGlvbik7DQorDQorCQlmcmVlKHRoaXMpOw0KKwl9DQorfQ0KKw0KKy8q
DQogICogc3ludGF4IGlzOg0KICAqCVstb3B0aW9uc10gbG9jYXRpb24gW2xv
Y2F0aW9uXSAuLi4NCiAgKglbLW9wdGlvbnNdIFttb3VudHBvaW50IFstb3B0
aW9uc10gbG9jYXRpb24gW2xvY2F0aW9uXSAuLi4gXS4uLg0KQEAgLTY2MSw2
ICs3MzEsNyBAQA0KIAlkZWJ1ZyhNT0RQUkVGSVggImdhdGhlcmVkIG9wdGlv
bnM6ICVzIiwgb3B0aW9ucyk7DQogDQogCWlmICgqcCA9PSAnLycpIHsNCisJ
CXN0cnVjdCBtdWx0aV9tbnQgKmxpc3QsICpoZWFkID0gTlVMTCwgKm5leHQ7
DQogCQlpbnQgbDsNCiAJCWNoYXIgKm11bHRpX3Jvb3Q7DQogDQpAQCAtNjg0
LDExICs3NTUsMTEgQEANCiAJCQlpZiAobXlvcHRpb25zID09IE5VTEwpIHsN
CiAJCQkJZXJyb3IoTU9EUFJFRklYICJtdWx0aSBzdHJkdXA6ICVtIik7DQog
CQkJCWZyZWUob3B0aW9ucyk7DQorCQkJCW11bHRpX2ZyZWVfbGlzdChoZWFk
KTsNCiAJCQkJcmV0dXJuIDE7DQogCQkJfQ0KIA0KIAkJCXBhdGggPSBkZXF1
b3RlKHAsIGwgPSBjaHVua2xlbihwLCAwKSk7DQotCQkJcGF0aGxlbiA9IHN0
cmxlbihwYXRoKTsNCiANCiAJCQlwICs9IGw7DQogCQkJcCA9IHNraXBzcGFj
ZShwKTsNCkBAIC03MDYsNiArNzc3LDcgQEANCiAJCQkJCQkgICAgIm11bHRp
IGNvbmNhdF9vcHRpb25zOiAlbSIpOw0KIAkJCQkJCWZyZWUob3B0aW9ucyk7
DQogCQkJCQkJZnJlZShwYXRoKTsNCisJCQkJCQltdWx0aV9mcmVlX2xpc3Qo
aGVhZCk7DQogCQkJCQkJcmV0dXJuIDE7DQogCQkJCQl9DQogCQkJCQlwID0g
c2tpcHNwYWNlKHApOw0KQEAgLTcyMSwyOCArNzkzLDQyIEBADQogCQkJbCA9
IHEgLSBwOw0KIA0KIAkJCWxvYyA9IGRlcXVvdGUocCwgbCk7DQotCQkJbG9j
bGVuID0gc3RybGVuKGxvYyk7DQotDQogCQkJaWYgKGxvYyA9PSBOVUxMIHx8
IHBhdGggPT0gTlVMTCkgew0KIAkJCQllcnJvcihNT0RQUkVGSVggIm91dCBv
ZiBtZW1vcnkiKTsNCiAJCQkJZnJlZShsb2MpOw0KIAkJCQlmcmVlKHBhdGgp
Ow0KIAkJCQlmcmVlKG9wdGlvbnMpOw0KKwkJCQlmcmVlKG15b3B0aW9ucyk7
DQorCQkJCW11bHRpX2ZyZWVfbGlzdChoZWFkKTsNCiAJCQkJcmV0dXJuIDE7
DQogCQkJfQ0KIA0KIAkJCXAgKz0gbDsNCiAJCQlwID0gc2tpcHNwYWNlKHAp
Ow0KIA0KKwkJCWxpc3QgPSBoZWFkOw0KKwkJCWhlYWQgPSBtdWx0aV9hZGRf
bGlzdChsaXN0LCBwYXRoLCBteW9wdGlvbnMsIGxvYyk7DQorCQkJaWYgKCFo
ZWFkKSB7DQorCQkJCWZyZWUobG9jKTsNCisJCQkJZnJlZShwYXRoKTsNCisJ
CQkJZnJlZShvcHRpb25zKTsNCisJCQkJZnJlZShteW9wdGlvbnMpOw0KKwkJ
CQltdWx0aV9mcmVlX2xpc3QoaGVhZCk7DQorCQkJCXJldHVybiAxOw0KKwkJ
CX0NCisJCX0gd2hpbGUgKCpwID09ICcvJyk7DQorDQorCQluZXh0ID0gaGVh
ZDsNCisJCXdoaWxlIChuZXh0KSB7DQogCQkJZGVidWcoTU9EUFJFRklYDQog
CQkJICAgICAgIm11bHRpbW91bnQ6ICUuKnMgb24gJS4qcyB3aXRoIG9wdGlv
bnMgJXMiLA0KLQkJCSAgICAgIGxvY2xlbiwgbG9jLCBwYXRobGVuLCBwYXRo
LCBteW9wdGlvbnMpOw0KKwkJCSAgICAgIHN0cmxlbihuZXh0LT5sb2NhdGlv
biksIG5leHQtPmxvY2F0aW9uLA0KKwkJCSAgICAgIHN0cmxlbihuZXh0LT5w
YXRoKSwgbmV4dC0+cGF0aCwgbmV4dC0+b3B0aW9ucyk7DQogDQotCQkJcnYg
PSBzdW5fbW91bnQobXVsdGlfcm9vdCwgcGF0aCwgcGF0aGxlbiwgbG9jLCBs
b2NsZW4sDQotCQkJCSAgICAgICBteW9wdGlvbnMpOw0KLQkJCWZyZWUocGF0
aCk7DQotCQkJZnJlZShsb2MpOw0KLQkJCWZyZWUobXlvcHRpb25zKTsNCisJ
CQlydiA9IHN1bl9tb3VudChtdWx0aV9yb290LA0KKwkJCQkgICAgICAgbmV4
dC0+cGF0aCwgc3RybGVuKG5leHQtPnBhdGgpLA0KKwkJCQkgICAgICAgbmV4
dC0+bG9jYXRpb24sIHN0cmxlbihuZXh0LT5sb2NhdGlvbiksDQorCQkJCSAg
ICAgICBuZXh0LT5vcHRpb25zKTsNCiANCiAJCQkvKiBDb252ZXJ0IG5vbi1z
dHJpY3QgZmFpbHVyZSBpbnRvIHN1Y2Nlc3MgKi8NCiAJCQlpZiAocnYgPCAw
KSB7DQpAQCAtNzUxLDcgKzgzNywxMCBAQA0KIAkJCX0gZWxzZSBpZiAocnYg
PiAwKQ0KIAkJCQlicmVhazsNCiANCi0JCX0gd2hpbGUgKCpwID09ICcvJyk7
DQorCQkJbmV4dCA9IG5leHQtPm5leHQ7DQorCQl9DQorDQorCQltdWx0aV9m
cmVlX2xpc3QoaGVhZCk7DQogDQogCQlmcmVlKG9wdGlvbnMpOw0KIAkJcmV0
dXJuIHJ2Ow0K

--1629620785-933557400-1105713308=:2519
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--1629620785-933557400-1105713308=:2519--

