From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Sun, 16 Jan 2011 05:46:57 +1100
Message-ID: <AANLkTimNxYf50pmr3j0OLicFj57rJ7TzcXF3aMQM7JPE@mail.gmail.com>
References: <20110114154652.GD19804@ZenIV.linux.org.uk>
	<20110114070224.GB19804@ZenIV.linux.org.uk>
	<20110113215359.19406.37232.stgit@warthog.procyon.org.uk>
	<2443.1295005428@redhat.com>
	<6672.1295025969@redhat.com>
	<20110114174340.GG19804@ZenIV.linux.org.uk>
	<20110114175648.GH19804@ZenIV.linux.org.uk>
	<20110114180625.GI19804@ZenIV.linux.org.uk>
	<AANLkTimMVF7HSOqJGWphY2fbaXDbegppe+Vug8e5V1HN@mail.gmail.com>
	<20110115133029.GN19804@ZenIV.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hdvTV2t2Tgec8pwWlkl6lUwleJZStsOv/cdQVgvOz84=;
        b=ZffLp7P9e0qDGhVj0gyHJuvtil0aFCKRwcwoTI4Yi6otBU646NcI0gpQUr0poq4HTr
         2IGtm4YBGZ65dnhNhtgpSXybeUs6RScxIsBS2M0upuJJTSZm5At7ZHSyqfuIDIe4Uxop
         uljSlrDPbMS7jJTUHaqCfoE6eewKsecDTedGE=
In-Reply-To: <20110115133029.GN19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jan 16, 2011 at 12:30 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>> > AFAICS, it keeps your write-free objectives and gets much saner API.
>> > Shout if you have problems with that...
>>
>> No that sounds good, I don't have a problem with it, although I don't
>> exactly understand what you're getting at in the second paragraph.
>
> OK, I have a hopefully sane implementation in tip of #untested.

This looks fine to me. Care to add a little comment above
mnt_make_longterm that it requires switching to a short term
mount before mntput()?

Thanks,
Nick
