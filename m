From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 19/18] Unexport do_add_mount() and add in
 follow_automount(), not ->d_automount()
Date: Sun, 16 Jan 2011 05:33:24 +1100
Message-ID: <AANLkTinG5yUjKns5nAzgtW526kKOBHT-eG1YyKR83wh5@mail.gmail.com>
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
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BQCbINxn1OvmxwFE/Yhz8RIFvZMm2qS1ITzQpj2zxAY=;
        b=N/yGrzRhBa3ngFnTi0oTgiKZVaMaH2ajaUwBdiV9tHYgjdRFj1nFmXxhZUDa4cDggu
         B6dY0bdl+06ORljM+UrOWisWNBuTpnCdAP+69nowihRRncKHcJK+A5UCOX5Z0osKTmz0
         vEn4xcRB6hgrAKZ2IGoXf5SlojS06P8Mec2Q0=
In-Reply-To: <20110115133029.GN19804@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, raven@themaw.net, npiggin@kernel.dk, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sun, Jan 16, 2011 at 12:30 AM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
>
>> > AFAICS, it keeps your write-free objectives and gets much saner AP=
I.
>> > Shout if you have problems with that...
>>
>> No that sounds good, I don't have a problem with it, although I don'=
t
>> exactly understand what you're getting at in the second paragraph.
>
> OK, I have a hopefully sane implementation in tip of #untested.
>
> There's a fun problem with what you do in do_lookup(), BTW. =A0Look:
> we enter do_lookup() with LOOKUP_RCU. =A0We find dentry in dcache,
> everything's beautiful. =A0The sucker has ->d_revalidate(). =A0We go
> to need_revalidate. =A0There we call do_revalidate(). =A0It calls
> d_revalidate(), which calls ->d_revalidate() and instead of spitting
> into your eye and returning -ECHILD it happily returns 1. =A0So
> do d_revalidate() and then do_revalidate(), without any further
> actions. =A0do_revalidate() has returned our dentry, which is neither
> NULL nor ERR_PTR(), so back in do_lookup() we go to done.
>
> There we set path->mnt and path->dentry and call __follow_mount().
> And damn, it *is* a mountpoint. =A0So we
> =A0 =A0 =A0 =A0* do dput() on dentry we'd never grabbed a reference t=
o
> =A0 =A0 =A0 =A0* grab a reference to a different dentry (and remain i=
n happy
> belief that we are in LOOKUP_RCU mode, and thus don't need to drop it=
)
> =A0 =A0 =A0 =A0* grab a reference to vfsmount (via lookup_mnt()). =A0=
Ditto (and
> I haven't checked if grabbing vfsmount_lock twice shared isn't a reci=
pe
> for a deadlocky race with something grabbing it exclusive between the=
se
> nested shared grabs).
> =A0 =A0 =A0 =A0* if we are really unlucky and that mountpoint is, in =
turn,
> overmounted, we'll hit mntput(). =A0While under vfsmount_lock.
>
> AFAICS, it's badly b0rken. =A0And autofs really steps into that mess.

Ah, I think you're right there, good catch.


> As minimum, we'd need to split need_revalidate: and done: in RCU and =
non-RCU
> variants. =A0I'm about to fall down right now after an all-nighter (a=
nd then
> some); if you put something together before I get up, please throw it
> my way.

It also has a problem with jumping back to need_lookup case there too.
I think separating out those two cases is reasonable.

>
> Note that the problem exists both in mainline and in mainline+automou=
nt
> patches; in the latter it's a bit nastier, but in principle the situa=
tion
> is the same, so I'd rather see a fix for that in front of automount q=
ueue.

Definitely agree.

I'm on the road at the moment so would much appreciate if you can
cut the patch, but I could suggest something along the lines of:

	if (nd->flags & LOOKUP_RCU) {
		unsigned seq;

		*inode =3D nd->inode;
		dentry =3D __d_lookup_rcu(parent, name, &seq, inode);
		if (!dentry)
			goto need_lookup_rcu;
		/* Memory barrier in read_seqcount_begin of child is enough */
		if (__read_seqcount_retry(&parent->d_seq, nd->seq))
			return -ECHILD;

		nd->seq =3D seq;
		if (dentry->d_flags & DCACHE_OP_REVALIDATE) {
                        	dentry =3D do_revalidate(dentry, nd);
                                if (!dentry)
		                       goto need_lookup_rcu;
                                if (IS_ERR(dentry))
		                       goto fail;
                }
		path->mnt =3D mnt;
		path->dentry =3D dentry;
		__follow_mount_rcu(nd, path, inode);
	} else {
		dentry =3D __d_lookup(parent, name);
		if (!dentry)
			goto need_lookup;
found:
		if (dentry->d_flags & DCACHE_OP_REVALIDATE) {
                        	dentry =3D do_revalidate(dentry, nd);
                                if (!dentry)
		                       goto need_lookup;
                                if (IS_ERR(dentry))
		                       goto fail;
                }
		path->mnt =3D mnt;
		path->dentry =3D dentry;
		__follow_mount(path);
		*inode =3D path->dentry->d_inode;
	}
        return 0;

need_lookup_rcu:
        if (nameidata_drop_rcu(nd))
                return -ECHILD;
need_lookup:
       ...
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
