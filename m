From: Ian Kent <raven@themaw.net>
Subject: Re: embedded spaces in automounter map options field
Date: Thu, 19 Aug 2004 11:08:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0408190947590.2172@wombat.indigo.net.au>
References: <200408171008.26436.gmishkin@acs.bu.edu>
 <Pine.LNX.4.58.0408181723030.15856@wombat.indigo.net.au>
 <200408181003.05973.gmishkin@acs.bu.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="13243321-780688570-1092884883=:3740"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200408181003.05973.gmishkin@acs.bu.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
To: gmishkin@bu.edu
Cc: autofs@linux.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--13243321-780688570-1092884883=:3740
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 18 Aug 2004, Geoff Mishkin wrote:

> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > I have a situation that requires me to have embedded spaces in the
> > > options field of my automounter map.  To make things trickier, the map
> > > has to be generated with an executable map.  I am using shfs and have to
> > > use it's cmd mount option to force it to connect using a specific private
> > > key file.  This requires there to be embedded spaces in the options
> > > field, like this:
> > >
> > > - -fstype=shfs,cmd="ssh -i /usr/keys/<username> <username>@<host>"
> > >
> > > Which causes the automounter to complain bitterly.  Most of the
> > > information I've found is for having spaces in share names or mount
> > > points, but the advice given doesn't work in the options field.  I've
> > > tried all kinds of quotes, backslashing, etc.  I'd greatly appriciate
> > > help.

On second thoughts if you are willing to try a patch then do this.

From the autofs v4 directory on kernel.org obtain the patches:

autofs-4.1.3-strict.patch
autofs-4.1.3-mtab_lock.patch
autofs-4.1.3-non_block_ping.patch
autofs-4.1.3-bad_chdir.patch

and then apply the attached patch and let me know how it goes.

Ian

--13243321-780688570-1092884883=:3740
Content-Type: TEXT/PLAIN; charset=US-ASCII;
	name="autofs-4.1.3-white_space.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0408191108030.3740@wombat.indigo.net.au>
Content-Description: 
Content-Disposition: attachment; filename="autofs-4.1.3-white_space.patch"

ZGlmZiAtTnVyIGF1dG9mcy00LjEuMy5vcmlnL21vZHVsZXMvbW91bnRfbmZz
LmMgYXV0b2ZzLTQuMS4zL21vZHVsZXMvbW91bnRfbmZzLmMNCi0tLSBhdXRv
ZnMtNC4xLjMub3JpZy9tb2R1bGVzL21vdW50X25mcy5jCTIwMDQtMDYtMDUg
MTM6NDk6MzMuMDAwMDAwMDAwICswODAwDQorKysgYXV0b2ZzLTQuMS4zL21v
ZHVsZXMvbW91bnRfbmZzLmMJMjAwNC0wNi0wNSAxNDoxNzo1OS4wMDAwMDAw
MDAgKzA4MDANCkBAIC0zNDcsNyArMzQ3LDcgQEANCiAJaW50IGxvY2FsLCBl
cnI7DQogCWludCBub3N5bWxpbmsgPSAwOw0KIA0KLQlkZWJ1ZyhNT0RQUkVG
SVggIiByb290PSVzIG5hbWU9JXMgd2hhdD0lcywgZnN0eXBlPSVzLCBvcHRp
b25zPSVzIiwNCisJZGVidWcoTU9EUFJFRklYICJyb290PSVzIG5hbWU9JXMg
d2hhdD0lcywgZnN0eXBlPSVzLCBvcHRpb25zPSVzIiwNCiAJICAgICAgcm9v
dCwgbmFtZSwgd2hhdCwgZnN0eXBlLCBvcHRpb25zKTsNCiANCiAJd2hhdHN0
ciA9IGFsbG9jYShzdHJsZW4od2hhdCkgKyAxKTsNCmRpZmYgLU51ciBhdXRv
ZnMtNC4xLjMub3JpZy9tb2R1bGVzL3BhcnNlX3N1bi5jIGF1dG9mcy00LjEu
My9tb2R1bGVzL3BhcnNlX3N1bi5jDQotLS0gYXV0b2ZzLTQuMS4zLm9yaWcv
bW9kdWxlcy9wYXJzZV9zdW4uYwkyMDA0LTA2LTA1IDEzOjQ5OjMzLjAwMDAw
MDAwMCArMDgwMA0KKysrIGF1dG9mcy00LjEuMy9tb2R1bGVzL3BhcnNlX3N1
bi5jCTIwMDQtMDYtMDUgMTQ6MTc6NTkuMDAwMDAwMDAwICswODAwDQpAQCAt
NjE4LDcgKzYxOCw3IEBADQogew0KIAlzdHJ1Y3QgcGFyc2VfY29udGV4dCAq
Y3R4dCA9IChzdHJ1Y3QgcGFyc2VfY29udGV4dCAqKSBjb250ZXh0Ow0KIAlj
aGFyICpwbWFwZW50LCAqb3B0aW9uczsNCi0JY29uc3QgY2hhciAqcCwgKnE7
DQorCWNvbnN0IGNoYXIgKnA7DQogCWludCBtYXBlbnRfbGVuLCBydjsNCiAJ
aW50IG9wdGxlbjsNCiANCkBAIC02ODgsNiArNjg4LDEyIEBADQogCQkJfQ0K
IA0KIAkJCXBhdGggPSBkZXF1b3RlKHAsIGwgPSBjaHVua2xlbihwLCAwKSk7
DQorCQkJaWYgKCFwYXRoKSB7DQorCQkJCWVycm9yKE1PRFBSRUZJWCAib3V0
IG9mIG1lbW9yeSIpOw0KKwkJCQlmcmVlKG15b3B0aW9ucyk7DQorCQkJCWZy
ZWUob3B0aW9ucyk7DQorCQkJCXJldHVybiAxOw0KKwkJCX0NCiAJCQlwYXRo
bGVuID0gc3RybGVuKHBhdGgpOw0KIA0KIAkJCXAgKz0gbDsNCkBAIC03MTIs
MjEgKzcxOCwxMSBAQA0KIAkJCQl9IHdoaWxlICgqcCA9PSAnLScpOw0KIAkJ
CX0NCiANCi0JCQlxID0gcDsNCi0JCQl3aGlsZSAoKnEgJiYgKnEgIT0gJy8n
KSB7DQotCQkJCWwgPSBjaHVua2xlbihxLCAxKTsNCi0JCQkJcSArPSBsOw0K
LQkJCQlxID0gc2tpcHNwYWNlKHEpOw0KLQkJCX0NCi0JCQlsID0gcSAtIHA7
DQotDQotCQkJbG9jID0gZGVxdW90ZShwLCBsKTsNCi0JCQlsb2NsZW4gPSBz
dHJsZW4obG9jKTsNCi0NCi0JCQlpZiAobG9jID09IE5VTEwgfHwgcGF0aCA9
PSBOVUxMKSB7DQorCQkJbG9jID0gZGVxdW90ZShwLCBsID0gY2h1bmtsZW4o
cCwgMSkpOw0KKwkJCWlmICghbG9jKSB7DQogCQkJCWVycm9yKE1PRFBSRUZJ
WCAib3V0IG9mIG1lbW9yeSIpOw0KLQkJCQlmcmVlKGxvYyk7DQogCQkJCWZy
ZWUocGF0aCk7DQorCQkJCWZyZWUobXlvcHRpb25zKTsNCiAJCQkJZnJlZShv
cHRpb25zKTsNCiAJCQkJcmV0dXJuIDE7DQogCQkJfQ0KQEAgLTczNCw2ICs3
MzAsMzkgQEANCiAJCQlwICs9IGw7DQogCQkJcCA9IHNraXBzcGFjZShwKTsN
CiANCisJCQl3aGlsZSAoKnAgJiYgKnAgIT0gJy8nKSB7DQorCQkJCWNoYXIg
KmVudDsNCisNCisJCQkJZW50ID0gZGVxdW90ZShwLCBsID0gY2h1bmtsZW4o
cCwgMSkpOw0KKwkJCQlpZiAoIWVudCkgew0KKwkJCQkJZXJyb3IoTU9EUFJF
RklYICJvdXQgb2YgbWVtb3J5Iik7DQorCQkJCQlmcmVlKHBhdGgpOw0KKwkJ
CQkJZnJlZShteW9wdGlvbnMpOw0KKwkJCQkJZnJlZShvcHRpb25zKTsNCisJ
CQkJCXJldHVybiAxOw0KKwkJCQl9DQorDQorCQkJCWxvYyA9IHJlYWxsb2Mo
bG9jLCBzdHJsZW4obG9jKSArIGwgKyAyKTsNCisJCQkJaWYgKCFsb2MpIHsN
CisJCQkJCWVycm9yKE1PRFBSRUZJWCAib3V0IG9mIG1lbW9yeSIpOw0KKwkJ
CQkJZnJlZShlbnQpOw0KKwkJCQkJZnJlZShwYXRoKTsNCisJCQkJCWZyZWUo
bXlvcHRpb25zKTsNCisJCQkJCWZyZWUob3B0aW9ucyk7DQorCQkJCQlyZXR1
cm4gMTsNCisJCQkJfQ0KKw0KKwkJCQlzdHJjYXQobG9jLCAiICIpOw0KKwkJ
CQlzdHJjYXQobG9jLCBlbnQpOw0KKw0KKwkJCQlmcmVlKGVudCk7DQorDQor
CQkJCXAgKz0gbDsNCisJCQkJcCA9IHNraXBzcGFjZShwKTsNCisJCQl9DQor
DQorCQkJbG9jbGVuID0gc3RybGVuKGxvYyk7DQorDQogCQkJZGVidWcoTU9E
UFJFRklYDQogCQkJICAgICAgIm11bHRpbW91bnQ6ICUuKnMgb24gJS4qcyB3
aXRoIG9wdGlvbnMgJXMiLA0KIAkJCSAgICAgIGxvY2xlbiwgbG9jLCBwYXRo
bGVuLCBwYXRoLCBteW9wdGlvbnMpOw0KQEAgLTc2MywxNSArNzkyLDcgQEAN
CiAJCWlmICgqcCA9PSAnOicpDQogCQkJcCsrOwkvKiBTdW4gZXNjYXBlIGZv
ciBlbnRyaWVzIHN0YXJ0aW5nIHdpdGggLyAqLw0KIA0KLQkJcSA9IHA7DQot
CQl3aGlsZSAoKnEpIHsNCi0JCQlsID0gY2h1bmtsZW4ocSwgMSk7DQotCQkJ
cSArPSBsOw0KLQkJCXEgPSBza2lwc3BhY2UocSk7DQotCQl9DQotCQlsID0g
cSAtIHA7DQotDQotCQlsb2MgPSBkZXF1b3RlKHAsIGwpOw0KKwkJbG9jID0g
ZGVxdW90ZShwLCBjaHVua2xlbihwLCAxKSk7DQogCQlsb2NsZW4gPSBzdHJs
ZW4obG9jKTsNCiANCiAJCWlmIChsb2MgPT0gTlVMTCkgew0K

--13243321-780688570-1092884883=:3740
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--13243321-780688570-1092884883=:3740--

