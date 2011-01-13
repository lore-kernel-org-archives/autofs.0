From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Thu, 13 Jan 2011 16:10:17 +1100
Message-ID: <AANLkTi=YygMc2ExFxvWqiFbSr-bWRVcn17toanJBdR08@mail.gmail.com>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
	<20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
	<AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pPCTlejErcGDqQD1YZJxEnsTzne4zvf3cmiYH0OaLaQ=;
        b=xnlIDrGL+lghp8aD9yywzm72tTBLncf14wfdPGLRUw4Hh9mEO5llIJh5zwqU53O42s
         iND1XmqjXXNQpiCr1DLDqiDKGLAocxOwSIUWrYjQ2WMab6YptVo0tonVhyb3B/J7X7kh
         nZdUmycVKqCINB1SCXjX4ymRJIJyo3N7dCvkQ=
In-Reply-To: <AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells@redhat.com>
Cc: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Thu, Jan 13, 2011 at 2:53 PM, Nick Piggin <npiggin@gmail.com> wrote:
> On Wed, Jan 12, 2011 at 4:48 AM, David Howells <dhowells@redhat.com> =
wrote:
>> Add a dentry op (d_automount) to handle automounting directories rat=
her than
>> abusing the follow_link() inode operation. =A0The operation is keyed=
 off a new
>> inode flag (S_AUTOMOUNT).
>>
>> This makes it easier to add an AT_ flag to suppress terminal segment=
 automount
>> during pathwalk. =A0It should also remove the need for the kludge co=
de in the
>> pathwalk algorithm to handle directories with follow_link() semantic=
s.
>>
>> A new pathwalk subroutine, follow_automount() is added to handle mou=
ntpoints.
>> It will return -EREMOTE if the S_AUTOMOUNT was set, but no d_automou=
nt() op was
>> supplied, -ELOOP if we've encountered too many symlinks or mountpoin=
ts, -EISDIR
>> if the walk point should be used without mounting and 0 if successfu=
l. =A0path
>> will be updated if an automount took place to point to the mounted f=
ilesystem.
>>
>> I've only changed __follow_mount() to handle call follow_automount()=
, but it
>> might be necessary to change follow_mount() too. =A0The latter is on=
ly called
>> from follow_dotdot(), but any automounts on ".." should be pinned wh=
ilst we're
>> using a child of it.
>>
>> I've also extracted the mount/don't-mount logic from autofs4 and inc=
luded it
>> here. =A0It makes the mount go ahead anyway if someone calls open() =
or creat(),
>> tries to traverse the directory, tries to chdir/chroot/etc. into the=
 directory,
>> or sticks a '/' on the end of the pathname. =A0If they do a stat(), =
however,
>> they'll only trigger the automount if they didn't also say O_NOFOLLO=
W.
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> Acked-by: Ian Kent <raven@themaw.net>
>
> I would still prefer to see a .follow_mount API, and not tie in this =
automount
> specific inode detail to what could be a more flexible dentry-only AP=
I.
>
> The default NULL implementation would do nothing, and follow_automoun=
t
> stuff can be in fs/libfs.c to be used by filesystem, rather than fs/n=
amei.c.

Looking further in the patchset at the d_managed "thing", that's almost=
 what
I'm getting at.

But I don't see why any of this stuff has to happen in fs/namei.c. Just=
 call the
function from path walk, and provide helpers in libfs or something if t=
here is
a lot of common code between autofs4 and others (and leave it autofs sp=
ecifc
when that is the case).

Of course, that would be the obvious and naive first approach. So reall=
y my
question is why did that not work? And can we make it work?

Second observation when adding rcu-walk/ref-walk operations. What we've
done now (which is what Linus preferred and I agree with now) is to mak=
e
functions always able to accept rcu-walk mode, and have filesystems bai=
l
out as needed.

Unless there are really fundamental reasons why rcu-walk won't work (eg=
=2E
->lookup, if it is required to do allocations and IO), or if it really
doesn't matter
(eg. a function to be called once to set up a mount, and never again).
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
