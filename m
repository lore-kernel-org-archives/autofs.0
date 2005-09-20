From: Jeff Moyer <jmoyer@redhat.com>
Subject: autofs4 looks up wrong path element when ghosting is enabled
Date: Tue, 20 Sep 2005 15:02:04 -0400
Message-ID: <17200.23724.686149.394150@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965079AbVITTCW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: raven@themaw.net
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

Hi, Ian, list,

I have a bug filed against autofs when ghosting is enabled.  The best way
to describe the bug is to walk through the reproducer, I guess.

Take the following maps, for example:

auto.master
/sbox	auto.sbox

auto.sbox:
src	segfault:/sbox/src/

Let's say that there is a file, id3_0.12.orig.tar.gz, in segfault:/sbox/src/.

To reproduce the problem, stop the nfs service on the server.

On the client, do an 'ls /sbox/src/id3_012.orig.tar.gz'.  This will fail,
as well it should.  However, if we look in the logs, we find this:

automount[1182]: handle_packet_missing: token 1, name src 
automount[1182]: attempting to mount entry /sbox/src
...
automount[1481]: mount(nfs): calling mkdir_path /sbox/src
automount[1481]: mount(nfs): calling mount -t nfs -s-o tcp,intr,timeo=600,rsize=8192,wsize=8192,retrans=5 segfault:/sbox/src /sbox/src
automount[1481]: >> mount: RPC: Program not registered
automount[1481]: mount(nfs): add_bad_host: segfault:/sbox/src
automount[1481]: mount(nfs): nfs: mount failure segfault:/sbox/src on /sbox/src
automount[1481]: failed to mount /sbox/src
...
automount[1182]: send_fail: token=1 
automount[1182]: handle_packet: type = 0 
automount[1182]: handle_packet_missing: token 2, name src/id3_0.12.orig.tar.gz 
automount[1182]: attempting to mount entry /sbox/src/id3_0.12.orig.tar.gz

Noteworthy are these last two lines!  Even though the mount failed, we are
continuing the lookup.  The culprit is here, in cached_lookup:

    if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) { 
            dput(dentry); 
            dentry = NULL; 
    } 

d_revalidate points to autofs4_revalidate, which calls try_to_fill_dentry,
which will return a status of 0.  Since ghosting is enabled,
d_invalidate(dentry) will return -EBUSY, and so we return the dentry to the
caller, which then continues the lookup.

Ian, I'm not really sure how we can address this issue without VFS
changes.  Any ideas?

Oh, also note that, once the nfs service is started up again on the server,
the lookup of a specific file name will still fail!  In this case, the
daemon won't even be called.

-Jeff
