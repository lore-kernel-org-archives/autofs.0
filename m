From: Ian Kent <raven@themaw.net>
Subject: Re: autofs map updates not working properly for
	multi-mounts
Date: Wed, 9 Feb 2005 09:55:39 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502090948440.14821@wombat.indigo.net.au>
References: <16905.15217.105499.777724@segfault.boston.redhat.com>
Mime-Version: 1.0
In-Reply-To: <16905.15217.105499.777724@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Tue, 8 Feb 2005, Jeff Moyer wrote:

> Hi, Ian, list,
> 
> I've been doing some testing of the map update code, and found that the
> following configuration does not work as it should:
> 
> auto.master contains:
> 
> /testing    /etc/auto.testing
> 
> /etc/auto.testing contains:
> 
> foo     -ro,hard,intr \
>         /dir/bar        server:/export/a \
>         /dir/baz        server:/export/b
> 
> Given that we are running a current version of the automounter, and we are
> up to date on kernel patches, we should be able to update the "foo" entry
> to list another subdir.  After this update occurs, any attempt to access
> the newly created directory should succeed.  However, it does not because
> lookup_file.c:lookup_mount doesn't find a cache hit for
> foo/dir/<new_entry> (in this case it is foo/dir/aaa).
> 
> Here is the output from a debug log:
> 
> kernel: pid 2492: autofs4_root_lookup: name = aaa
> kernel: pid 2492: autofs4_root_lookup: pid = 2492, pgrp = 2492, catatonic =
> 0, oz_mode = 0
> kernel: pid 2492: autofs4_revalidate: dentry=c1b2d700 aaa flags=0
> kernel: pid 2492: try_to_fill_entry: dentry=c1b2d700 aaa ino=00000000
> kernel: pid 2492: try_to_fill_entry: waiting for mount name=aaa
> kernel: pid 2492: autofs4_wait: new wait id = 0x00000002, name =
> foo/dir/aaa, nfy=1
> kernel: pid 2492: autofs4_notify: wait id = 0x00000002, name = foo/dir/aaa,
> type=0
> automount[2095]: handle_packet: type = 0
> automount[2095]: handle_packet_missing: token 2, name foo/dir/aaa
> automount[2095]: attempting to mount entry /testing/foo/dir/aaa
> automount[2493]: ret = 8
> kernel: pid 2095: autofs4_revalidate: dentry=c1daef00 foo flags=4
> automount[2095]: sig 1 switching from 1 to 4
> kernel: pid 2095: autofs4_revalidate: dentry=c1daee80 dir flags=4
> automount[2493]: failed to mount /testing/foo/dir/aaa
> 
> Ian, I'll continue to look into this, but figured I'd report the issue here
> in case you had any suggestions.

I'll try and get to the bottom of this as well.

This shouldn't happen. The mount should occur as soon as the path walk 
hits foo and all mounts from the multi-mount should be mounted then?

> 
> Note that I have reproduced this with 4.1.4_beta1.  Also note that I've
> only tested this with file maps.  Other lookup modules may or may not
> exhibit the same behaviour.

It's probably like it in all.

Ian
