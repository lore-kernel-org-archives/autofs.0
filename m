From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 1/7] vfs - merge path_is_mountpoint() and
 path_is_mountpoint_rcu()
Date: Mon, 05 Dec 2016 10:50:27 +0800
Message-ID: <1480906227.2816.31.camel@themaw.net>
References: <148029910861.27779.4517883721395202453.stgit@pluto.themaw.net>
         <20161203051322.GA24765@ZenIV.linux.org.uk>
         <20161203232912.GE1555@ZenIV.linux.org.uk>
         <1480817915.3157.14.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=zD+qIkeOMV1xFJa
        bjpnwCS/FNZE=; b=U58Fqr9F1/D4s0d4M37pItKKukkRtCUlmFV5WelBW2GV2at
        pT54ICV9tdrQMNO7XcTUpcGOt+ro1r90svyh/3mnSDXs88ebxnyoVoE3Kn6B9Akf
        PlIMVF4Md7qppzozGRGaUTJfbGxfnMbp8pWQDp2Ij3Qn97JdxbrNZXILmESk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        smtpout; bh=zD+qIkeOMV1xFJabjpnwCS/FNZE=; b=ifED3hMHzL4S8/FnVftn
        TZtFLO80eJnKNLrrea5BQzX70GUj5ZZ5rvirbmxJDDVEuDAH1/l2QzRgg3bU6WLL
        X504ewr0n+nHg9XNLGOMG6PNiaE04AP4OM57X70z9Yvnx/f8idI+CvBZjRyT9a/O
        ozDmBfVq1j9+xVWpJ+Klb2A=
In-Reply-To: <1480817915.3157.14.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>

On Sun, 2016-12-04 at 10:18 +0800, Ian Kent wrote:
> On Sat, 2016-12-03 at 23:29 +0000, Al Viro wrote:
> > 
> > On Sat, Dec 03, 2016 at 05:13:22AM +0000, Al Viro wrote:
> > > 
> > > 
> > > 	* path_has_submounts() is broken.  At the very least, it's
> > > AB-BA between mount_lock and rename_lock.  I would suggest trying to
> > > put read_seqlock_excl(&mount_lock) around the call of d_walk() in there,
> > > and using __lookup_mnt() in the callback (without retries on the
> > > mount_lock,
> > > of course - read_seqlock_excl done on the outside is enough).  I'm not
> > > sure
> > > if it won't cause trouble with contention, though; that needs testing.  As
> > > it is, that function is broken in #work.autofs, same as it is in -mm and
> > > -next.
> > 	Fix for path_has_submounts() (as above) force-pushed.  It does
> > need testing and profiling, obviously.
> I'll run my tests against it and re-run with oprofile if all goes well.
> 
> The submount-test I use should show contention if it's a problem but I'm not
> sure the number of mounts used will be sufficient to show up scale problems.
> 
> Basically each case of the test (there are two) runs for 100 iterations using
> 10
> processes with timing set to promote expire to mount contention, mainly to
> test
> for expire to mount races.
> 
> If I don't see contention I might need to analyse further whether the test has
> adequate coverage.

I have run my usual tests on a build of vfs.get#work.autofs.

Both tests ran without problem multiple times (even though they should be
deterministic experience had shown they sometimes aren't).

I also did a system wide oprofile run of an additional run of the submount-test.

I hadn't noticed that the submount-test runs are shorter that I have come to
expect. This might be due to changes to the behaviour of the expire and mount
timing over time.  But I always check that I'm seeing expire and mount behaviour
that should lead to contention during the test run and that looked as expected.

The run time was about 55 minutes for each of the two cases I test whereas I had
come to expect a run time of around 70 minutes each. It's been quite a while
since I've actually paid attention to this and a lot has changed in the VFS
since.

It might be due to Neil Browns' changes to satisfy path walks in rcu-walk mode
where possible rather than always dropping into ref-walk mode as I didn't
profile those changes when they were implemented because I didn't notice
unexpectedly different run times when testing the changes.

I was going to talk about why the autofs usage of path_has_submounts() should
not be problematic but that would be tedious for everyone, instead I'll just say
that, clearly it is possible to abuse path_has_submounts() by calling it on
mount points that have a large number of directories, but autofs shouldn't do
that and the profile verifies this.

I'm not sure how accurate the profile is (I don't do it very often). There were
about 400000 out of 22000000 samples missed.

And hopefully the report output is readable enough to be useful after posting
....

Anyway, a system wide opreport (such as it is) showed this:

CPU: Intel Haswell microarchitecture, speed 3700 MHz (estimated)
Counted CPU_CLK_UNHALTED events (Clock cycles when not halted) with a unit mask of 0x00 (No unit mask) count 100000
samples  %        image name               app name                 symbol name
3897186  17.6585  libc-2.22.so             operf                    __strcmp_sse2_unaligned
3125714  14.1629  libstdc++.so.6.0.21      operf                    std::_Rb_tree_increment(std::_Rb_tree_node_base const*)
1500262   6.7978  libsqlite3.so.0.8.6      evolution                /usr/lib64/libsqlite3.so.0.8.6
856262    3.8798  operf                    operf                    /usr/bin/operf
749603    3.3965  libglib-2.0.so.0.4600.2  evolution                /usr/lib64/libglib-2.0.so.0.4600.2
560812    2.5411  libdbus-1.so.3.14.8      dbus-daemon              /usr/lib64/libdbus-1.so.3.14.8
378227    1.7138  systemd                  systemd                  /usr/lib/systemd/systemd
301175    1.3647  libcamel-1.2.so.54.0.0   evolution                /usr/lib64/libcamel-1.2.so.54.0.0
223545    1.0129  dbus-daemon              dbus-daemon              /usr/bin/dbus-daemon
187783    0.8509  libc-2.22.so             dbus-daemon              __strcmp_sse2_unaligned
157564    0.7139  libc-2.22.so             evolution                __strcmp_sse2_unaligned
157218    0.7124  libc-2.22.so             evolution                _int_malloc
156089    0.7073  libgobject-2.0.so.0.4600.2 evolution                /usr/lib64/libgobject-2.0.so.0.4600.2
116277    0.5269  libc-2.22.so             evolution                _int_free
116275    0.5269  libxul.so                firefox                  /usr/lib64/firefox/libxul.so
104278    0.4725  libc-2.22.so             evolution                __GI_____strtoull_l_internal
92937     0.4211  libc-2.22.so             ps                       _IO_vfscanf
...
101      4.6e-04  vmlinux-4.9.0-rc7        opendir                  path_is_mountpoint
...
23       1.0e-04  vmlinux-4.9.0-rc7        opendir                  path_has_submounts
...

where opendir is a program the test uses to trigger a mount and do various
checks on the result.

Not sure if this is enough or is what's needed, let me know if there's something
else specific I should do.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
