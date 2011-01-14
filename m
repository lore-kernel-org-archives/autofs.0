From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Sat, 15 Jan 2011 09:07:19 +1100
Message-ID: <AANLkTimMVF7HSOqJGWphY2fbaXDbegppe+Vug8e5V1HN@mail.gmail.com>
References: <20110114154652.GD19804@ZenIV.linux.org.uk>
	<20110114070224.GB19804@ZenIV.linux.org.uk>
	<20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	<2443.1295005428@redhat.com>
	<6672.1295025969@redhat.com>
	<20110114174340.GG19804@ZenIV.linux.org.uk>
	<20110114175648.GH19804@ZenIV.linux.org.uk>
	<20110114180625.GI19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=N3i2O+dHF5ZQEZFboVTFp/dw/4NhUSssXY3WFCT8Lno=;
        b=uMaZSU1qGlUEvouYHmD2p88sVVAPxRDMafS4WRUNVKY9/ExuWWounsLwRAFX1jdMXW
         nRFEHDFVOngVJh21hH+sp/XnchsdMOBDMyxIkE8hQavquzCyJg0ZgO0jLT7eNtVzRQem
         Ar9UJtbu+CRY4g3C53HZS5ySdZLbx43TcoR2c=
In-Reply-To: <20110114180625.GI19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jan 15, 2011 at 5:06 AM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Fri, Jan 14, 2011 at 05:56:48PM +0000, Al Viro wrote:
>> =A0 =A0 =A0 BTW, speaking of mntput_long(): I really hate that API. =
=A0It's
>> asking for subtle leaks - use mntget_long() in pair with mntput() an=
d
>> you are fucked. =A0Worse, these suckers are created with long refere=
nce
>> now, so any code that used to use mntput() to kill a cloned/freshly
>> created vfsmount got silently b0rken. =A0A quick look already caught
>> one such case - fs/nfsctl.c do_open() uses mntput() in pair with
>> do_kern_mount(), which leads to longrefs left at 1.

Hmm ok. I agree it's not the nicest scheme.

>>
>> =A0 =A0 =A0 Rationale for that mess, please...
>
> FWIW, what I intend to do is to keep these longrefs _only_ for
> cwd/root/attached or possibly hashed and set them alongside the
> normal ref. =A0I.e. require the callers of mntput_long() (not exporte=
d,
> local to core VFS) to keep the normal reference.

OK that sounds better... I didn't have a good rationale beyond
those cases.


> That way it would turn into hint for mntput() - "we have persistent
> refs, just decrement count on this CPU and piss off", with mntput_lon=
g()
> never going into the whole "and now we are dropping the last ref" par=
t.

I don't see the point of that, though. That's what it essentially
already is, but the check is done by mntput rather than the caller
passing it in as a hint.


> AFAICS, it keeps your write-free objectives and gets much saner API.
> Shout if you have problems with that...

No that sounds good, I don't have a problem with it, although I don't
exactly understand what you're getting at in the second paragraph.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
