From: "NeilBrown" <neilb@suse.de>
Subject: Re: [ANNOUNCE] autofs 5.1.8 release
Date: Tue, 15 Feb 2022 09:46:44 +1100
Message-ID: <164487880421.17471.502085345359040789@noble.neil.brown.name>
References: <b54fb31652a4ba76b39db66b8ae795ee3af6f025.camel@themaw.net>,
 <164444398868.27779.4643380819577932837@noble.neil.brown.name>,
 <b042424ce0e68f576fdab268adeeff90d48da8a8.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644878809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY4+tZtVO3bfuQVQvZiqFVanwPAU0lbx3A94noQ9EDw=;
        b=PUxMIzOvsSjt2zgy0CEbtcBLkUWb4c15pX2tyJHCD/8PCeoMR0MkSnZ/KKbiKsY3STmJme
        n388QjpMfoiT5yLKIhwatD4uNF5/VBbZMwdy1Avq7eDtt8JBjAZznrdoX+9RVzvyBxxc0B
        vA51CvixV2m81vY9P41O8UzLWMlcbPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644878809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hY4+tZtVO3bfuQVQvZiqFVanwPAU0lbx3A94noQ9EDw=;
        b=acj5iz4nPJXncE+RYZg9/BSnoT8END2Vlupr8lP/gvNYG2/L58c/HgwTOAv7ooDShcTgRz
        /+LgeV8Bl+UTPGAA==
In-reply-to: <b042424ce0e68f576fdab268adeeff90d48da8a8.camel@themaw.net>
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

T24gTW9uLCAxNCBGZWIgMjAyMiwgSWFuIEtlbnQgd3JvdGU6Cj4gT24gVGh1LCAyMDIyLTAyLTEw
IGF0IDA4OjU5ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gPiBPbiBUdWUsIDE5IE9jdCAyMDIx
LCBJYW4gS2VudCB3cm90ZToKPiA+ID4gSGkgYWxsLAo+ID4gPiAKPiA+ID4gSXQncyB0aW1lIGZv
ciBhIHJlbGVhc2UsIGF1dG9mcy01LjEuOC4KPiA+ID4gCj4gPiAuLi4KPiA+ID4gLSBhbHNvIHJl
cXVpcmUgVENQX1JFUVVFU1RFRCB3aGVuIHNldHRpbmcgTkZTIHBvcnQuCj4gPiAKPiA+IFVuZm9y
dHVuYXRlbHkgdGhhdCBsYXN0IHBhdGNoIGlzIGJ1Z2d5LsKgIFRDUF9SRVFVRVNURUQgaXMgbWFz
a2VkIG91dAo+ID4gaW4KPiA+IHRoZSBjYWxsZXIuCj4gCj4gTW1tIC4uLiBzb3VuZHMgbGlrZSBJ
J3ZlIG1hZGUgYSBtaXN0YWtlIHRoZXJlLgo+IEknbGwgbmVlZCB0byBzb3J0IHRoYXQgb3V0LCB0
aGFua3MgZm9yIHBvaW50aW5nIGl0IG91dC4KPiAKPiA+IAo+ID4gTWF5YmUgdGhlIGZvbGxvd2lu
ZyBpcyBiZXN0Lgo+ID4gCj4gPiBOZWlsQnJvd24KPiA+IAo+ID4gRnJvbTogTmVpbEJyb3duIDxu
ZWlsYkBzdXNlLmRlPgo+ID4gU3ViamVjdDogW1BBVENIXSBUZXN0IFRDUCByZXF1ZXN0IGNvcnJl
Y3RseSBpbiBuZnNfZ2V0X2luZm8oKQo+ID4gCj4gPiBUaGUgVENQX1JFUVVFU1RFRCBmbGFnIGlz
IG1hc2tlZCBvdXQgYnkgdGhlIGNhbGxlciwgc28gaXQgbmV2ZXIgZ2V0cwo+ID4gdG8KPiA+IG5m
c19nZXRfaW5mbygpLgo+IAo+IFRoYXQgd2Fzbid0IG15IGludGVudCwgSSdsbCBuZWVkIHRvIGxv
b2sgYXQgaXQgYWdhaW4uCj4gVGhlIGNhc2UgSSdtIHRyeWluZyB0byBjb3ZlciBpcyBmYWlybHkg
c3BlY2lmaWMgc28gSSB3aWxsIG5lZWQgdG8KPiBsb29rIGF0IGl0IGFnYWluLgo+IAoKSSdtIGN1
cmlvdXM6IFdoYXQgd2FzIHRoZSBjYXNlIHlvdSB3ZXJlIHRyeWluZyB0byBzb2x2ZT8/ICBJIGNv
dWxkbid0Cmd1ZXNzIGFueSBqdXN0aWZpY2F0aW9uIGZvciB0aGUgY2hhbmdlLgoKVGhhbmtzLApO
ZWlsQnJvd24KCg==
