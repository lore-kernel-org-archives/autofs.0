From: raven@themaw.net
Subject: Re: fast mounting problems
Date: Sat, 4 Sep 2004 14:11:19 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409041404480.8861@donald.themaw.net>
References: <E1C2Bv4-0002u8-7T@www.linux.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="2277544-239841120-1094278279=:8861"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1C2Bv4-0002u8-7T@www.linux.org.uk>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: Bryce as root <root@www.linux.org.uk>
Cc: autofs mailing list <autofs@linux.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--2277544-239841120-1094278279=:8861
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 31 Aug 2004, Bryce as root wrote:

> Relating to Autofs 4.1
> 
> This relates to a bug I've filed with RHAT
> ( https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128966 )
> 
> In our testing enviroment we use autofs a lot and have been experiancing
> problems of being unable to mount directories every now and again
> 
> To this end I build a test script to exercise the autofs daemon which
> nicely exposes the problem (again covered in the bugzilla report)
> 
> What appears to be happening is that autofs is spawning forked copies of
> itself to help facilitate loading FS's
> however, initially when debugging it seemed like the first batch of NFS
> directories were mounted before the second forked process times out
> trying to rpc_ping the server because the initial process never bothered to
> close the socket.
> 
> Now Jeff Moyer at RedHat spotted that and gave me a patch for rpc_stubs.c
> which alleviates the problem slightly, however, while the parent and then
> the first child process play nice, any further forked processes also run
> into this rpc_ping port being held open and consequently fail to mount and
> you'd see something like this in the system messages log
> 
> Aug 18 18:59:12 localhost automount[8746]: attempting to mount entry/test/947
> Aug 18 18:59:12 localhost automount[9050]: >> nfs bindresvport: Address already in use
> Aug 18 18:59:12 localhost automount[9050]: mount(nfs): nfs: mount failure 192.168.1.100:/compile/nfs/947 on /test/947
> 
> soooooo,.... ideas on how to make the other children processes play nice?

I've read the bugzilla report.

Thanks for you huge effort in profiling this problem Phil.

After investigating it looks like Jeffs' original patch was not 
quite right. Can you try the attached patch and let me know how it goes 
please. It assumes that Jeffs' original sock leak fix patch has been 
applied.

Ian

--2277544-239841120-1094278279=:8861
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name="autofs-4.1.3-auto_close.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0409041411190.8861@donald.themaw.net>
Content-Description: sock leak fix fix
Content-Disposition: attachment; filename="autofs-4.1.3-auto_close.patch"

LS0tIGF1dG9mcy00LjEuMy9saWIvcnBjX3N1YnMuYy5hdXRvX2Nsb3NlCTIw
MDQtMDktMDQgMTM6MjE6MzkuMDAwMDAwMDAwICswODAwDQorKysgYXV0b2Zz
LTQuMS4zL2xpYi9ycGNfc3Vicy5jCTIwMDQtMDktMDQgMTM6NTk6NDguMDAw
MDAwMDAwICswODAwDQpAQCAtMzIsOSArMzIsMjcgQEANCiAjZGVmaW5lIFBN
QVBfVE9VVF9VRFAJMg0KICNkZWZpbmUgUE1BUF9UT1VUX1RDUAkzDQogDQor
LyoNCisgKiBUQ1AgUlBDIHByaXZhdGUgZGF0YSBzdHJ1Y3QgLSBmcm9tIHN1
bnJwYy9jbG50X3RjcC5jLg0KKyAqIEhvcGVmdWxseSBpdCB3b24ndCBiZSBj
aGFuZ2luZyBhbnkgdGltZSBzb29uLg0KKyAqLw0KKw0KKyNkZWZpbmUgTUNB
TExfTVNHX1NJWkUgMjQNCisNCitzdHJ1Y3QgY3RfZGF0YSB7DQorCWludCBj
dF9zb2NrOw0KKwlib29sX3QgY3RfY2xvc2VpdDsNCisJc3RydWN0IHRpbWV2
YWwgY3Rfd2FpdDsNCisJYm9vbF90IGN0X3dhaXRzZXQ7DQorCXN0cnVjdCBz
b2NrYWRkcl9pbiBjdF9hZGRyOw0KKwlzdHJ1Y3QgcnBjX2VyciBjdF9lcnJv
cjsNCisJY2hhciBjdF9tY2FsbFtNQ0FMTF9NU0dfU0laRV07DQorCXVfaW50
IGN0X21wb3M7DQorCVhEUiBjdF94ZHJzOw0KK307DQorDQogc3RydWN0IGNv
bm5faW5mbyB7DQogCWNvbnN0IGNoYXIgKmhvc3Q7DQotCWludCBmZDsNCiAJ
dW5zaWduZWQgc2hvcnQgcG9ydDsNCiAJdW5zaWduZWQgbG9uZyBwcm9ncmFt
Ow0KIAl1bnNpZ25lZCBsb25nIHZlcnNpb247DQpAQCAtNDksNiArNjcsNyBA
QA0KICAqLw0KIHN0YXRpYyBDTElFTlQqIGNyZWF0ZV91ZHBfY2xpZW50KHN0
cnVjdCBjb25uX2luZm8gKmluZm8pDQogew0KKwlpbnQgZmQgPSBSUENfQU5Z
U09DSzsNCiAJQ0xJRU5UICpjbGllbnQ7DQogCXN0cnVjdCBzb2NrYWRkcl9p
biBhZGRyOw0KIAlzdHJ1Y3QgaG9zdGVudCAqaHA7DQpAQCAtNjIsMTQgKzgx
LDEzIEBADQogCWlmICghaHApDQogCQlyZXR1cm4gTlVMTDsNCiANCi0JaW5m
by0+ZmQgPSBSUENfQU5ZU09DSzsNCiAJYWRkci5zaW5fZmFtaWx5ID0gQUZf
SU5FVDsNCiAJYWRkci5zaW5fcG9ydCA9IGh0b25zKGluZm8tPnBvcnQpOw0K
IAltZW1jcHkoJmFkZHIuc2luX2FkZHIuc19hZGRyLCBocC0+aF9hZGRyLCBo
cC0+aF9sZW5ndGgpOw0KIA0KIAljbGllbnQgPSBjbG50dWRwX2J1ZmNyZWF0
ZSgmYWRkciwNCiAJCQkJICAgaW5mby0+cHJvZ3JhbSwgaW5mby0+dmVyc2lv
biwNCi0JCQkJICAgaW5mby0+dGltZW91dCwgJmluZm8tPmZkLA0KKwkJCQkg
ICBpbmZvLT50aW1lb3V0LCAmZmQsDQogCQkJCSAgIGluZm8tPnNlbmRfc3os
IGluZm8tPnJlY3Zfc3opOw0KIA0KIAlyZXR1cm4gY2xpZW50Ow0KQEAgLTE0
OSw2ICsxNjcsNyBAQA0KIHsNCiAJaW50IGZkOw0KIAlDTElFTlQgKmNsaWVu
dDsNCisJc3RydWN0IGN0X2RhdGEgKmN0Ow0KIAlzdHJ1Y3Qgc29ja2FkZHJf
aW4gYWRkcjsNCiAJc3RydWN0IGhvc3RlbnQgKmhwOw0KIAlpbnQgcmV0Ow0K
QEAgLTE4MCw3ICsxOTksOSBAQA0KIAlpZiAoIWNsaWVudCkNCiAJCWdvdG8g
b3V0X2Nsb3NlOw0KIA0KLQlpbmZvLT5mZCA9IGZkOw0KKwljdCA9IChzdHJ1
Y3QgY3RfZGF0YSAqKSBjbGllbnQtPmNsX3ByaXZhdGU7DQorCWN0LT5jdF9j
bG9zZWl0ID0gMTsNCisNCiAJcmV0dXJuIGNsaWVudDsNCiANCiBvdXRfY2xv
c2U6DQpAQCAtMjI2LDcgKzI0Nyw2IEBADQogCQkJIHBtYXBfaW5mby50aW1l
b3V0KTsNCiANCiAJY2xudF9kZXN0cm95KGNsaWVudCk7DQotCWNsb3NlKHBt
YXBfaW5mby5mZCk7DQogDQogCWlmIChzdGF0ICE9IFJQQ19TVUNDRVNTKQ0K
IAkJcmV0dXJuIDA7DQo=

--2277544-239841120-1094278279=:8861
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--2277544-239841120-1094278279=:8861--

