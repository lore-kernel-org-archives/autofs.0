From: raven@themaw.net
Subject: Re: autofs map updates not working properly for
	multi-mounts
Date: Wed, 9 Feb 2005 22:19:20 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502092116510.2140@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>


Sorry about this rant but after thinking about it you've hit on a sore 
point.

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
>        /dir/bar        server:/export/a \
>        /dir/baz        server:/export/b
>
> Given that we are running a current version of the automounter, and we are
> up to date on kernel patches, we should be able to update the "foo" entry
> to list another subdir.  After this update occurs, any attempt to access
> the newly created directory should succeed.  However, it does not because
> lookup_file.c:lookup_mount doesn't find a cache hit for
> foo/dir/<new_entry> (in this case it is foo/dir/aaa).

I've seen this ocassionally in testing but could never work out exatly 
what was causing it.

Thanks to your excelent problem description I now understand what is 
happening. The description has given me more valueable information on 
a significant outstanding problem with autofs. Thanks Jeff.

So, to the description of the way autofs handles multi-mount entries.

Multi-mount map entries must be treated as a single unit.

This is so because nested mounts are allowed within them.

Consider

foo	-rw \
 	/one/a	server:/one/a \
 	/one/b	server:/one/b \
 	/one/b/c server:/one/b/c

If this isn't handled as a single unit then it's possible for /one/b/c to 
be mounted before /one/b. This could happen due to a map update, for 
example.

So, just as with individual mount entries, it can't be updated until it's 
umounted and mounted again.

The handling of lazy mounting of multi-mounts is the second biggest 
problem that I want to solve after direct mounts and a problem that I have 
struggled with for a long time. And the one problem I have the least ideas 
on how to solve.

So what is happening.

The format of a multi-mount is

key [-options] [[/] mount-entry] [path [-options] mount-entry] and so on

where the brackets signify optional bits.

When the mount "key" is triggered all of the entries are mounted.
When all the entries have been idle at least the timeout period they are 
all umounted.

No surprises here.

In the example you are working with there is no "/" entry so lookups 
in non-mountpoint directories trigger VFS callbacks to the autofs4 kernel 
module.

It doesn't know that it's a multi-mount (it just gets called by the VFS 
to carry out VFS operations it's asked to be called for) and so uses it's 
rules to decide when to trigger a mount.

A mount is triggered if it finds an empty directory that is not 
already a mounted and then sends a mount request to the daemon.

So the key in the example below that is sent to the daemon is 
"foo/dir/aaa" when in fact the key for the map entry is "foo".

Consequently it's not found in the map.

But it gets worse. Having passed over foo in the path lookup it's already 
too late to take action. If we want things to work we must notify the 
daemon when we walk over foo not afterwards.

So this is not a simple problem but I hope to stand corrected.

The question then is can we improve the situation?

Prossibly yes, perhaps by flaging multi-mount entries so that the correct 
key is sent to the daemon at the right time would offer some improvement.

Our inability to adequately handle the nested mounts has always been a 
show stopper in this case.

Once again I have some ideas and a tiny bit of code from a false start but 
I still don't have a plan for what I consider proper solution.

So the bottom line at the moment is "multi-mount entries must be handled a 
a single mount entry". So they can't be dynamically updated until the 
next time they are mounted following the update.

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
>
> Note that I have reproduced this with 4.1.4_beta1.  Also note that I've
> only tested this with file maps.  Other lookup modules may or may not
> exhibit the same behaviour.
>
> Thanks!
>
> Jeff
>
