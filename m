From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 looks up wrong path element when ghosting is
	enabled
Date: Wed, 21 Sep 2005 09:25:50 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17200.23724.686149.394150@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Jeff Moyer wrote:

> Hi, Ian, list,
> 
> I have a bug filed against autofs when ghosting is enabled.  The best way
> to describe the bug is to walk through the reproducer, I guess.
> 
> Take the following maps, for example:
> 
> auto.master
> /sbox	auto.sbox
> 
> auto.sbox:
> src	segfault:/sbox/src/
> 
> Let's say that there is a file, id3_0.12.orig.tar.gz, in segfault:/sbox/src/.
> 
> To reproduce the problem, stop the nfs service on the server.
> 
> On the client, do an 'ls /sbox/src/id3_012.orig.tar.gz'.  This will fail,
> as well it should.  However, if we look in the logs, we find this:
> 
> automount[1182]: handle_packet_missing: token 1, name src 
> automount[1182]: attempting to mount entry /sbox/src
> ...
> automount[1481]: mount(nfs): calling mkdir_path /sbox/src
> automount[1481]: mount(nfs): calling mount -t nfs -s-o tcp,intr,timeo=600,rsize=8192,wsize=8192,retrans=5 segfault:/sbox/src /sbox/src
> automount[1481]: >> mount: RPC: Program not registered
> automount[1481]: mount(nfs): add_bad_host: segfault:/sbox/src
> automount[1481]: mount(nfs): nfs: mount failure segfault:/sbox/src on /sbox/src
> automount[1481]: failed to mount /sbox/src
> ...
> automount[1182]: send_fail: token=1 
> automount[1182]: handle_packet: type = 0 
> automount[1182]: handle_packet_missing: token 2, name src/id3_0.12.orig.tar.gz 
> automount[1182]: attempting to mount entry /sbox/src/id3_0.12.orig.tar.gz
> 
> Noteworthy are these last two lines!  Even though the mount failed, we are
> continuing the lookup.  The culprit is here, in cached_lookup:
> 
>     if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) { 
>             dput(dentry); 
>             dentry = NULL; 
>     } 
> 
> d_revalidate points to autofs4_revalidate, which calls try_to_fill_dentry,
> which will return a status of 0.  Since ghosting is enabled,
> d_invalidate(dentry) will return -EBUSY, and so we return the dentry to 
the
> caller, which then continues the lookup.
> 
> Ian, I'm not really sure how we can address this issue without VFS
> changes.  Any ideas?
> 

I'm aware of this problem.
I'm not sure how to deal with it yet.
The case above is probably not that difficult to solve but if the last 
component is a directory it's hard to work out it's a problem.

There's more information here than I've gathhered so far.

> Oh, also note that, once the nfs service is started up again on the server,
> the lookup of a specific file name will still fail!  In this case, the
> daemon won't even be called.

I'll have to check this out.
It could be helpful.

> 
> -Jeff
> 
