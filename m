From: Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/18] Add a dentry op to handle automounting rather than
 abusing follow_link()
Date: Fri, 14 Jan 2011 12:19:43 +1100
Message-ID: <AANLkTi=ZiOZ08WEkTt8nVWkaeSG9mnM0JQ-ov=kO2mpc@mail.gmail.com>
References: <20110111174809.2291.52242.stgit@warthog.procyon.org.uk>
	<20110111174815.2291.41967.stgit@warthog.procyon.org.uk>
	<AANLkTi=F6PSgQs78MpmG_V3q_ksmYMUwU8=xBoNOypto@mail.gmail.com>
	<AANLkTi=YygMc2ExFxvWqiFbSr-bWRVcn17toanJBdR08@mail.gmail.com>
	<16508.1294931527@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t9GZmAAp5LrcSz75cIWL07//BDnrErbeGVcQplX02Ag=;
        b=G1XsXG0Bnuvl2GntwfIj2u/r4kRLFq2KyIe5TugTACmwGyrTTT/MtjZj8cNJYHRMhl
         TdWt9ufhGTAs120w/IDoSO64TPR9MB/63nnabinmEKVpzd7wgMDjLbH2Cx8TjIYjKf5N
         hnZ0CDNG0R2y6v8mG2xTwHg6Io+XF5hWBziLI=
In-Reply-To: <16508.1294931527@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Howells <dhowells@redhat.com>
Cc: npiggin@kernel.dk, viro@zeniv.linux.org.uk, raven@themaw.net, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

On Fri, Jan 14, 2011 at 2:12 AM, David Howells <dhowells@redhat.com> wr=
ote:
> Nick Piggin <npiggin@gmail.com> wrote:
>
>> > I would still prefer to see a .follow_mount API, and not tie in th=
is
>> > automount specific inode detail to what could be a more flexible
>> > dentry-only API.
>> >
>> > The default NULL implementation would do nothing, and follow_autom=
ount
>> > stuff can be in fs/libfs.c to be used by filesystem, rather than
>> > fs/namei.c.
>>
>> Looking further in the patchset at the d_managed "thing", that's alm=
ost what
>> I'm getting at.
>>
>> But I don't see why any of this stuff has to happen in fs/namei.c. J=
ust call
>> the function from path walk, and provide helpers in libfs or somethi=
ng if
>> there is a lot of common code between autofs4 and others (and leave =
it autofs
>> specifc when that is the case).
>>
>> Of course, that would be the obvious and naive first approach. So re=
ally my
>> question is why did that not work? And can we make it work?
>
> You have a strange idea of what is 'obvious and naive'. =A0These are =
parts of
> pathwalk, and as such should be in fs/namei.c. =A0I'd rather not expo=
se
> pathwalking directly to the filesystem, though I acknowledge that som=
etimes it
> is necessary to let the filesystem influence it.

No, path walk would *not* be affected or implemented at all by the file=
system,
if you read what I wrote. The only difference is a function called at
follow_mount
time, which may decide to mount something on there.

All the autofs stuff would be constrained within auto mounting filesyst=
ems and
libraries. follow_automount belongs in automount code, not path walking=
=2E

Also, I don't like how you return a vfsmount * and use that in path wal=
king. If
you just returned success and allowed the path walk to continue looking=
 up
mounted directories, it would be cleaner code, IMO.


> You need to consider d_automount() and d_manage() separately as they =
provide
> two quite different hooks with different properties.
>
> Firstly, d_automount(). =A0The following are my points of considerati=
on.
>
> =A0(0) You're only allowed to automount on a directory.
>
> =A0(1) Automounting does not need to be done when we follow ".." to a=
n automount
> =A0 =A0 point.
>
> =A0(2) Automount points that are mounted upon within the current name=
space can
> =A0 =A0 just be skipped over. =A0This is the fast path.
>
> =A0(3) All the filesystem should need as a parameter to determine wha=
t it is
> =A0 =A0 allowed to mount is the inode and dentry of the automount poi=
nt. =A0This
> =A0 =A0 holds true for all the things that currently do automounting =
(AFS, CIFS,
> =A0 =A0 NFS, autofs).
>
> =A0(4) All the filesystem should need to do is set up a vfsmount stru=
ct and
> =A0 =A0 publish it or return an indication that there was a collision=
 and the
> =A0 =A0 transit should be retried.
>
> =A0(5) The filesystem is expected to sleep to achieve the automount, =
so
> =A0 =A0 spinlocks, RCU locks, preemption disablements or interrupt di=
sablements
> =A0 =A0 may not be held across this function.
>
> =A0(6) The filesystem is expected to need a write lock on namespace_s=
em at some
> =A0 =A0 point, so this must not be held across the call to d_automoun=
t().
>
> =A0(7) The filesystem won't necessarily be calling do_add_mount() its=
elf in
> =A0 =A0 d_automount() - in autofs's case, the construction is perform=
ed by the
> =A0 =A0 userspace daemon and then autofs4_d_automount() indicates a c=
ollision - so
> =A0 =A0 we can't move the do_add_mount() to the caller. =A0Additional=
ly, the
> =A0 =A0 filesystem may want to use an expiration list.
>
> =A0(8) There needs to be some limitation in place to prevent runaway
> =A0 =A0 automounting. =A0The ELOOP detection mechanism can be used fo=
r this.

I don't know why the dentry d_automount routine has to depend on inodes
at all. That should all be stuffed into the filesystem.


> Taking these considerations, it shows that a small amount of code can=
 be
> inserted into pathwalk and used for everything. =A0However, having wo=
rked with
> Ian to try and get autofs4 to work with this, we came up with d_manag=
e() to add
> in a missing piece.
>
> Note that autofs4 also uses d_automount() to build directory structur=
es behind
> the mountpoint rather than mounting on the mountpoint. =A0In this cas=
e, it clears
> the AUTOMOUNT flag when construction is complete.

And all of this can be done in autofs4 private flags.


> I've allowed d_automount() to return -EISDIR to follow_automount() to=
 indicate
> that no mount should be attempted here, and the directory should be g=
iven back
> to pathwalk to treat as a directory. =A0This allows autofs's daemon a=
ccess to the
> directory.
>
> Having follow_automount() update the path it has been given with the =
new
> vfsmount and root dentry is purely an optimisation; we could instead =
simply
> return and __follow_mount() will do lookup_mnt() again as it would if=
 a
> collision is reported.
>
> In answer to why I haven't made __follow_mount_rcu() handle automount=
 points, I
> thought previously I saw a reason why it was unnecessary, but now I'm=
 not so
> sure. =A0It may be that if there are child objects of this dentry the=
n it will
> walk onto those rather than automounting - but for some reason it see=
ms still
> to automount rather than doing that.
>
>
> Secondly, d_manage(). =A0The following are the points of consideratio=
n:
>
> =A0(1) A filesystem may want to hold up client processes that want to=
 transit
> =A0 =A0 from directories in its control during pathwalk - such as whe=
n autofs is
> =A0 =A0 letting its userspace daemon tear down the stuff mounted on o=
r created
> =A0 =A0 behind a directory.
>
> =A0(2) A transit may be from a directory to a directory mounted over =
it, or from
> =A0 =A0 a directory to an object (file, dir, etc.) pointed to by an e=
ntry in that
> =A0 =A0 directoy.
>
> =A0(3) The management of dentries in this fashion is a transient affa=
ir.
>
> =A0(4) The mode in which the filesystem is normally entered for this =
purpose
> =A0 =A0 should be disabled as soon as possible, though it may be reen=
abled later
> =A0 =A0 if needed.
>
> =A0(5) When the filesystem is ready it should let the held processes =
proceed or
> =A0 =A0 it may reject them.
>
> =A0(6) The filesystem is expected to sleep to achieve this, so spinlo=
cks, RCU
> =A0 =A0 locks, preemption disablements or interrupt disablements may =
not be held
> =A0 =A0 across this function.
>
> =A0(7) The filesystem must be able to let some processes through whil=
st holding
> =A0 =A0 up others. =A0This allows autofs to let its daemon pass to co=
nstruct or
> =A0 =A0 destroy stuff.

So if you change .d_automount as I suggested above to just return succe=
ss
and do "something", then it would seem to handle all these cases just a=
s well.



> =A0(8) Because do_add_mount() and do_move_mount() transit through pil=
es of
> =A0 =A0 mounted directories, the filesystem may have to contend with =
being called
> =A0 =A0 with namespace_sem held. =A0This means initiating (un)mountin=
g, even
> =A0 =A0 indirectly via userspace, is not permitted from this function=
=2E

With this little detail still to take care of. So as far as I can see,
they're not
completely different but very similar in that the filesystem wants a ho=
ok
before mounts are followed (better name might be .d_follow_mount).


> Taking the above into consideration, we determined that we couldn't u=
se one
> entry point for both automounting and holding up. =A0Autofs had the p=
ossibility
> to deadlock against itself because of (8).

I'm not against 2 entry points, or a parameter to distinguish the cases=
=2E That
seems like a trivial detail compared with the main issues.


>> Unless there are really fundamental reasons why rcu-walk won't work =
(eg.
>> ->lookup, if it is required to do allocations and IO), or if it real=
ly
>> doesn't matter (eg. a function to be called once to set up a mount, =
and never
>> again).
>
> d_automount() is expected to sleep, so there's no point not cancellin=
g rcu-walk
> mode before entering it. =A0Granted there will be rare occasions when=
 the
> cancellation proves unnecessary because there was a mount collision, =
but even
> then it's very likely we'll be calling alloc_vfsmnt() - which may sle=
ep - and
> doing I/O - which may also sleep - before we realise we've got a coll=
ision.
>
> Besides, d_automount() is skipped without cancelling rcu-walk mode if=
 the
> directory is mounted over. =A0That is the fast path, and I'd rather n=
ot route
> that through the filesystem.

=46air enough. If it becomes a more general .d_follow(), then allowing =
rcu-walk is
probably a good idea.


> So after automounting has happened, all subsequent transits of that m=
ountpoint
> will maintain rcu-walk mode, assuming they don't meet DCACHE_MANAGE_T=
RANSIT.
>
>
> I grant that I could extend RCU pathwalk through d_manage(). =A0The a=
utofs daemon
> might benefit from that, but I contend that the benefit would be mino=
r overall,
> and any processes that do get held up will have to abandon RCU pathwa=
lk so that
> they can sleep.

We'll see. Relatively minor detail to change the API for that case
after we agree
on the larger form of the API.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
