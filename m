From: Paul Smith <psmith@netezza.com>
Subject: autofs won't cross-compile
Date: Tue, 07 Nov 2006 14:36:48 -0500
Message-ID: <1162928208.26623.15.camel@localhost>
Reply-To: psmith@netezza.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-jYEx0fd8eAMuxvbcwyYQ"
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


--=-jYEx0fd8eAMuxvbcwyYQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all; autofs's configure.in is not properly set up to allow for
cross-compiling.  It fails trying to detect -fPIE, because configure.in
runs AC_RUN_IFELSE to run a program (which of course can't work during
cross-compilation) and does not provide a cross-compilation result.

I'm not sure why this test for PIE exists or if it's really needed, but
if you want to keep it please add an argument for cross-compilation.
Patch is attached, against 4.1.4 (but I checked 5.00beta1 and it had the
same issue).  As recommended by the autoconf manual, this patch is
pessimistic and assumes no PIE support for all cross-compilation
environments.

I've split the patch into two: one for configure.in and one for
configure itself (I'm not sure if you source code control the configure
script: some projects do and some don't).

Cheers!

-- 
-----------------------------------------------------------------------------
 Paul D. Smith <psmith@netezza.com>                       http://netezza.com
 "Please remain calm--I may be mad, but I am a professional."--Mad Scientist
-----------------------------------------------------------------------------
      These are my opinions--Netezza takes no responsibility for them.

--=-jYEx0fd8eAMuxvbcwyYQ
Content-Disposition: attachment; filename=autofs-1.patch
Content-Type: text/x-patch; name=autofs-1.patch; charset=us-ascii
Content-Transfer-Encoding: base64

LS0tIGF1dG9mcy00LjEuNC1vbGQvY29uZmlndXJlLmluCTIwMDUtMDQtMDYgMTE6MjQ6MzcuMDAw
MDAwMDAwIC0wNDAwDQorKysgYXV0b2ZzLTQuMS40L2NvbmZpZ3VyZS5pbgkyMDA2LTExLTA3IDEz
OjU5OjQyLjg5NTY4MDU4MyAtMDUwMA0KQEAgLTE0MCw3ICsxNDAsOCBAQA0KIERBRU1PTl9MREZM
QUdTPQ0KIEFDX01TR19DSEVDS0lORyhbd2hldGhlciBnY2MgLWZQSUUgd29ya3NdKQ0KIEFDX1JV
Tl9JRkVMU0UoW0FDX0xBTkdfUFJPR1JBTShbW11dLCBbW2ludCBtYWluKHZvaWQpIHtyZXR1cm4g
MDt9XV0pXSwNCi0JICAgICAgW2djY19zdXBwb3J0c19waWU9eWVzXSwgW2djY19zdXBwb3J0c19w
aWU9bm9dKQ0KKwkgICAgICBbZ2NjX3N1cHBvcnRzX3BpZT15ZXNdLCBbZ2NjX3N1cHBvcnRzX3Bp
ZT1ub10sDQorICAgICAgICAgICAgICBbZ2NjX3N1cHBvcnRzX3BpZT1ub10pDQogQUNfTVNHX1JF
U1VMVChbJGdjY19zdXBwb3J0c19waWVdKQ0KIGlmIHRlc3QgJGdjY19zdXBwb3J0c19waWUgPSB5
ZXMgOyB0aGVuDQogCURBRU1PTl9DRkxBR1M9Ii1mUElFIg0K


--=-jYEx0fd8eAMuxvbcwyYQ
Content-Disposition: attachment; filename=autofs-2.patch
Content-Type: text/x-patch; name=autofs-2.patch; charset=us-ascii
Content-Transfer-Encoding: base64

LS0tIGF1dG9mcy00LjEuNC1vbGQvY29uZmlndXJlCTIwMDUtMDQtMDYgMTE6MjQ6MzcuMDAwMDAw
MDAwIC0wNDAwDQorKysgYXV0b2ZzLTQuMS40L2NvbmZpZ3VyZQkyMDA2LTExLTA3IDE0OjA3OjM3
Ljg5NjExMzYwMSAtMDUwMA0KQEAgLTQyMTksMTEgKzQyMTksNyBAQA0KIGVjaG8gIiRhc19tZTok
TElORU5POiBjaGVja2luZyB3aGV0aGVyIGdjYyAtZlBJRSB3b3JrcyIgPiY1DQogZWNobyAkRUNI
T19OICJjaGVja2luZyB3aGV0aGVyIGdjYyAtZlBJRSB3b3Jrcy4uLiAkRUNIT19DIiA+JjYNCiBp
ZiB0ZXN0ICIkY3Jvc3NfY29tcGlsaW5nIiA9IHllczsgdGhlbg0KLSAgeyB7IGVjaG8gIiRhc19t
ZTokTElORU5POiBlcnJvcjogY2Fubm90IHJ1biB0ZXN0IHByb2dyYW0gd2hpbGUgY3Jvc3MgY29t
cGlsaW5nDQotU2VlIFxgY29uZmlnLmxvZycgZm9yIG1vcmUgZGV0YWlscy4iID4mNQ0KLWVjaG8g
IiRhc19tZTogZXJyb3I6IGNhbm5vdCBydW4gdGVzdCBwcm9ncmFtIHdoaWxlIGNyb3NzIGNvbXBp
bGluZw0KLVNlZSBcYGNvbmZpZy5sb2cnIGZvciBtb3JlIGRldGFpbHMuIiA+JjI7fQ0KLSAgIHsg
KGV4aXQgMSk7IGV4aXQgMTsgfTsgfQ0KKyAgZ2NjX3N1cHBvcnRzX3BpZT1ubw0KIGVsc2UNCiAg
IGNhdCA+Y29uZnRlc3QuJGFjX2V4dCA8PF9BQ0VPRg0KIC8qIGNvbmZkZWZzLmguICAqLw0K


--=-jYEx0fd8eAMuxvbcwyYQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--=-jYEx0fd8eAMuxvbcwyYQ--

