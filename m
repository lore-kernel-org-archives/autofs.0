From: Ian Kent <raven@themaw.net>
Subject: Re: "rmdir_path: lstat of <path> failed" issues, despite updated
 autofs RPM
Date: Tue, 10 Nov 2015 13:48:56 +0800
Message-ID: <1447134536.3010.21.camel@themaw.net>
References: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG>
	 <1446964411.2974.7.camel@themaw.net>
	 <8C7EFEF6-C73F-43F2-AC63-5CB5ED2B806B@isolar.DynDNS.ORG>
	 <1447026421.2990.11.camel@themaw.net>
	 <80BF6988-2849-49A0-AEC5-4079AB9B8CFF@isolar.DynDNS.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=93e4zp0n2zuRmPQQ3RpQHCPutmQ=; b=unbJO9
	NCDDXuRZUIQCN2TJ+nsjVPdzzExkFp6CeaBpyOzt1/gUZbntYMvKoiu3HShtUZsL
	KOtMveJQp9uUXnGFleQ4a0AO+r/7ddq+sN0asfSgD0PCNBodKTnPyrit2ce+avvV
	uot8AD/X4R9h1e+s93OhSPVskqSN4GlexjNE0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=93e4zp0n2zuRmPQ
	Q3RpQHCPutmQ=; b=LuelGopCq6I58B2ALIFlfk6YdOOqgW/uVhdPcsH2pD2sDmV
	Jen8uTRmkvL5Toi2lB/aOoZeCttKihH7vdA8a5ERNltYWJTeraFsInmlWs1pciHb
	0Lr1O9pwvENyYG/8lySPJUZ+5Ig3P5wchbBWixy0mHuS4xiqkvoaT5RMKhgo=
In-Reply-To: <80BF6988-2849-49A0-AEC5-4079AB9B8CFF@isolar.DynDNS.ORG>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

On Mon, 2015-11-09 at 12:42 -0800, Greg Earle wrote:
> > On Nov 8, 2015, at 3:47 PM, Ian Kent <raven@themaw.net> wrote:
> > 
> > > The keys were never in a map.  That is what is so weird.  I went
> > > to
> > > our
> > > Solaris NIS master and there is no reference to "objects" or
> > > "refs"
> > > in
> > > /etc/auto_home or /etc/auto_*.  I can't imagine what could be
> > > running
> > > that is trying to access those two phantom "/home" paths.
> > 
> > Yeah, that function is called from a few places.
> > 
> > At map read time, at autofs fs mount time and on HUP signal or if a
> > lookup makes autofs think the map has been modified and at expire
> > when
> > attempting to remove a path on failed mount attempts for some fs
> > types,
> > notably NFS.
> 
> I checked and of course it was still doing it:
> 
> Nov  9 12:30:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects \
> failed
> 
> So I SIGHUP'ed the daemon and immediately got another one:
> 
> Nov  9 12:35:36 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects \
> failed

So it sounds like it's occurring in the map entry cache prune function.

The puzzle is why the lstat() failing since that directory does exist
according to what we have above.

There's also the question of why it continues to occur.

I looked briefly at the RHEL code (actually rev 184 was 5.11) for the
prune function, which is driven by what's in the map entry cache, and
it looks like the map entry cache entry is removed just before the
rmdir_path() call. So it shouldn't keep coming back if there are no
further accesses.

I probably didn't look closely enough though.

> 
> I can't stop & restart the autofs service because it's a production
> server
> for a flight project.

Even though you should be able to perform a restart without disrupting
autofs users it's not something I'd recommend on a production machine.

There is a small window of time when autofs won't respond to requests
and if requests arrive within that window they could hang forever. Not
sure how to mitigate against that either.

But that probably wouldn't be enough anyway.

If there are directories that are possibly broken in some way then to
clear them up the autofs managed mount point must be umounted.

But if any mounts are busy at shutdown they are left mounted, and the
autofs mount itself obviously must be left mounted too, then autofs re
-connects to the mounts when it starts again.

That complexity is the reason I usually just recommend a re-boot be
scheduled, plus if there is some sort of brokenness within the mounted
autofs file system there's no knowing if there were side effects when
it happened.

Sorry, I'm not really much help with this.
Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
