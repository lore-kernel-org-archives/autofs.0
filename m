From: raven@themaw.net
Subject: [RFC] direct mount support re-work for autofs v4
Date: Wed, 23 Feb 2005 22:15:52 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502232157130.8193@donald.themaw.net>
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, autofs mailing list <autofs@linux.kernel.org>


Direct mount support re-work for autofs version 4
-------------------------------------------------

I'm planning on reworking the direct mount functionality of autofs
version 4 to add missing functionality.

The aim here is to outline my chosen implementation and to get input
from other interested people to help avoid problems and add value.

While I'm open to suggestions of how it may be done differently I
have thought about it for a long time and will need a strong case
to make wholesale changes to my plan.

The proposed implementation does not take account of multiple
namespaces. autofsng seeks to deal with this in its implementation.

What is a direct mount in autofs?
---------------------------------

Direct mount map entries are of the form:

<full path> [-options] <mount entry>

They are simple in the sense that each <full path> must be distinct
and must not be nested within another terminal entry in the map.

For example:

/nfs/test/data1		server:/local/dat1
/nfs/test/data1/test	server:/local/test

is not permitted.

How will we do this in autofs?
------------------------------

As far as I can think of there are two ways this can be done.

One way is to enhance the autofs4 kernel module to behave like a
stackable file system module and implement semantics similar to
indirect mounts.

For example the map entry:

/usr/local/man	sever:/shared/${ARCH}/man

would be mounted on /usr and the underlying filesystem made
viewable using stacked filesystem methods implemented in the
kernel module. In this case paths in the direct map such as 
local/man in the above example, act as the key to trigger a
mount operation.

autofs currently works this way but without the stacking so it
is only useful for direct maps that don't share a filesystem.
It uses a minimum of anonymous devices and so works well with
2.4 kernels that have a limit of 255 of them. Another problem
with this is that single level direct mounts aren't possible.

I don't want to talk further about the stacked filesystem approach
as I found a couple of compelling reasons not to use this approach
during feasibility.

1) Overmounting "/" is way bad for obvious reasons and is required
    to implement single level direct mounts.
2) The complexity of adding stackable filesystem code to the
    kernel module is significant. I believe the problem may be
    solved much more simply.
3) The breaking up of the direct map key into a base and a set
    of sub-key paths adds complexity to the user space daemon
    that really shouldn't need to be there.

The other way is to use an approach similar to that outlined in
Mike Waychisons' "Towards a Modern AutoFS" (contact Mike at 
Michael.Waychison@sun.com if you'd like to get a copy) adapted
for the existing autofs code.

Using this approach each direct mount entry in the map is a
distinct automount point. Different from indirect maps, they
are all handled by a single instance of the automount daemon.

As far as the daemon goes the changes needed to do this are
fairly straight forward and reduce overall complexity. They
amount to identifying the direct map in the master map by its
key ("/-"), adding an additional mount option "direct" to
each mount, adding an enumeration function to each map lookup
module and to the map cache module used by autofs v4.
Together they will be used to perform mounts, expire runs and
umounts.

Since a single daemon will handle multiple autofs mounts, we
need a way to distinguish one from another. This can be done
by adding two additional kernel message handlers to the daemon
for "missing" and "expire" events. The new messages will include
the ioctl fd that autofs uses to communicate with the mount
point. The lookup key path is not needed in these messages
as the lookup information can be obtained from the ioctl fd
found in the event message. In particular, the st_dev together
with the st_ino from the stat struct should be sufficient for
distinct key lookups.

At startup the enumeration function will traverse the map of
direct mount entries mounting each one. Similarly, each expire
run will use the enumeration function to send an expire request
(using the usual ioctl method) to each direct mount point to see
if an expire event is needed. For an expire event the existing
umount logic can be used without much change. Finally, at shutdown
the enumeration function will be used to umount all the mount
points. A requirement of at least util-linux version 2.10m and
kernel 2.4.11 will be imposed in order to use lazy umounting
during forceful shutdowns and umounts.

The kernel module changes alluded to above seem fairly straight
forward as well.

We need to add the mount option "direct" and two new message
types for "missing" and "expire" events for direct mounts
which contain at least the communication ioctl fd. Since we
don't need to send the key path in the messages their's plenty
of room in the packet. Of course the actual packet size must
remain the same for backward compatibility.

For mount events, since the needed mount is immediately atop
the autofs mount point, we must be able to detect a path walk
after the final follow_down following the lookup. An opportunity
to do this is to use the follow_link inode file operation. This
can be added to autofs4s' root inode file operations which is
assigned during super block setup. Since this is always a
directory inode it can't otherwise use this method.

For expire checking of direct mounts we need only check the
mount point itself for business and update the timeout 
if it's busy or send an "expire" event to the daemon
if it has been idle for at least timeout time. The timeout
here is inaccurate in that the usage doesn't get updated
when the path is walked "over" as with indirect mounts.
I expect this will be adequate for the implementation. I
can't think of a way to do this without patching the kernel
proper. If it was decided to do this a check and possible
timeout update in the follow_down routine would be sufficient.

Another problem with this method is that changes to direct
mount maps can't be seen until the map is re-loaded (HUP
signal). This is because autofs doesn't get a chance to
make decisions during the mount event as the automount
point is the mount point and is either already there or
it's not.

One final difficulty is deciding how to do directory
cleanup within the host filesystem at exit.

So that's the idea. Comments and suggestions?

Ian


