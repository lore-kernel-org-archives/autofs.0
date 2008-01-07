From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Re: Problem with autofs_home map
Date: Mon, 7 Jan 2008 15:10:56 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F051929B9@permls05.wde.woodside.com.au>
References: <1195195539.3131.43.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C850F4.10F30DBE"
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <1195195539.3131.43.camel@raven.themaw.net>
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
To: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C850F4.10F30DBE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Ian and apologies for the delay on this.

I now know why the debug log was empty.  --verbose !=3D --debug.

The attached file called debug is the syslog output.  I'm sending a file
called autofs_debug.log to your email address only which contains the
requested info on Jeff's home page.  It has some possibly ensitive info.

Note that /etc/auto.master looks like
/-      autofs.global --debug --ghost
nfsvers=3D3,tcp,rsize=3D32768,wsize=3D32768
/rhome  autofs.home   --debug --ghost
nfsvers=3D3,tcp,rsize=3D32768,wsize=3D32768

And the auto_home map looks like

wgvp1 srv1:/local/vphome
dsvn1 srv2:/local/vn1-home
dsvi1 srv2:/local/vi1-home
dsvc1 srv2:/local/vc1-home
dsne4 srv2:/local/home
ds006 srv2:/local/data/ep-common-farmout-home
exo4 srv1:/local/home-exo4
exo3 srv1:/local/home-exo3
exo2 srv1:/local/home-exo2
exo1 srv1:/local/home-exo1

When I start (or restart) autofs I don't get a /rhome, only a /home.  I
really want a /rhome.

Any ideas?

CC

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net]=20
Sent: Friday, 16 November 2007 2:46 PM
To: Coe, Colin C. (Unix Engineer)
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Problem with autofs_home map

On Fri, 2007-11-16 at 15:21 +0900, Ian Kent wrote:
> That's bad.
>=20
> How about having a look at this I put together a while ago for
testing.
> Obviously most of this you've already done but will prove to be a good
> check and then there's the gdb instructions as well.

It also looks like you don't have any debuginfo packages installed.
We'll probably need to get some, at the least the autofs-debuginfo.

Ian


NOTICE: This email and any attachments are confidential.=20
They may contain legally privileged information or=20
copyright material. You must not read, copy, use or=20
disclose them without authorisation. If you are not an=20
intended recipient, please contact us at once by return=20
email and then delete both messages and all attachments.

------_=_NextPart_001_01C850F4.10F30DBE
Content-Type: application/octet-stream;
	name="debug"
Content-Transfer-Encoding: base64
Content-Description: debug
Content-Disposition: attachment;
	filename="debug"

SmFuICA3IDE0OjE2OjAzIGx3czA3NSBudHBkWzE5OTk2XToga2VybmVsIHRpbWUgc3luYyBlbmFi
bGVkIDAwMDEKSmFuICA3IDE0OjE2OjM5IGx3czA3NSBhdXRvbW91bnRbMjQzMjJdOiBtb3VudF9h
dXRvZnM6IGFscmVhZHkgbW91bnRlZApKYW4gIDcgMTQ6MTY6MzkgbHdzMDc1IGF1dG9tb3VudFsy
NDMyMl06IC9ob21lOiBtb3VudCBmYWlsZWQhCkphbiAgNyAxNDoxNzoyOCBsd3MwNzUgc3lzbG9n
ZCAxLjQuMTogcmVzdGFydC4KSmFuICA3IDE0OjE3OjI4IGx3czA3NSBzeXNsb2c6IHN5c2xvZ2Qg
c3RhcnR1cCBzdWNjZWVkZWQKSmFuICA3IDE0OjE3OjI4IGx3czA3NSBrZXJuZWw6IGtsb2dkIDEu
NC4xLCBsb2cgc291cmNlID0gL3Byb2Mva21zZyBzdGFydGVkLgpKYW4gIDcgMTQ6MTc6MjggbHdz
MDc1IHN5c2xvZzoga2xvZ2Qgc3RhcnR1cCBzdWNjZWVkZWQKSmFuICA3IDE0OjE3OjI4IGx3czA3
NSBzeXNsb2c6IHN5c2xvZ2Qgc2h1dGRvd24gc3VjY2VlZGVkIApKYW4gIDcgMTQ6MTc6MzkgbHdz
MDc1IG5zc3dpdGNoOiBuc3N3aXRjaDogY291bGRuJ3QgZmluZCBtYXAgYXV0b2ZzLmdsb2JhbApK
YW4gIDcgMTQ6MTc6MzkgbHdzMDc1IG5zc3dpdGNoOiBuc3N3aXRjaDogY291bGRuJ3QgZmluZCBt
YXAgYXV0b2ZzLmhvbWUKSmFuICA3IDE0OjE4OjEzIGx3czA3NSBhdXRvZnM6IGF1dG9tb3VudCBz
aHV0ZG93biBmYWlsZWQKSmFuICA3IDE0OjE4OjEzIGx3czA3NSBhdXRvbW91bnRbMjYwNDFdOiBt
b3VudF9hdXRvZnM6IGFscmVhZHkgbW91bnRlZApKYW4gIDcgMTQ6MTg6MTMgbHdzMDc1IGF1dG9t
b3VudFsyNjA0MV06IC9ob21lOiBtb3VudCBmYWlsZWQhCkphbiAgNyAxNDoxODoxMyBsd3MwNzUg
c3NoZFsyNjE0Nl06IENvbm5lY3Rpb24gY2xvc2VkIGJ5IDo6ZmZmZjoxNTguODkuMTAyLjQwCkph
biAgNyAxNDoxODoxMyBsd3MwNzUgbnNzd2l0Y2g6IG5zc3dpdGNoOiBjb3VsZG4ndCBmaW5kIG1h
cCBhdXRvZnMuZ2xvYmFsCkphbiAgNyAxNDoxODoxMyBsd3MwNzUgbnNzd2l0Y2g6IG5zc3dpdGNo
OiBjb3VsZG4ndCBmaW5kIG1hcCBhdXRvZnMuaG9tZQpKYW4gIDcgMTQ6MTg6MTQgbHdzMDc1IGF1
dG9mczogYXV0b21vdW50IHN0YXJ0dXAgc3VjY2VlZGVkCg==

------_=_NextPart_001_01C850F4.10F30DBE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

------_=_NextPart_001_01C850F4.10F30DBE--

