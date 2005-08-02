From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] replicated mounts patch (local subnet mounts
	now get passed addr= option)
Date: Tue, 2 Aug 2005 09:10:51 -0400
Message-ID: <17135.28891.580109.903906@segfault.boston.redhat.com>
References: <1122917193.28132.22.camel@barsoom.rdu.redhat.com>
	<Pine.LNX.4.58.0508020927120.31272@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508020927120.31272@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] [PATCH] replicated mounts patch (local subnet mounts now get passed addr= option); Ian Kent <raven@themaw.net> adds:

raven> On Mon, 1 Aug 2005, Jeff Layton wrote:
>> Hi All, Below is the latest iteration of my mount_nfs.c overhaul
>> patch. This one now passes the addr= option to the mount command when
>> the NFS server is deemed to be "local" (which in my patch is different
>> than a bind mount).
>> 
>> This patch, in conjunction with the patch to mount that I sent to the
>> util-linux maintainer should give us the proper behavior when the NFS
>> server is a multihomed host and has an interface on the same subnet as
>> the client.
>> 
>> I've unfortunately still not heard back from Adrian Bunk on my mount
>> patch, however, so I have no idea if that's going to go in or not.
>> 
>> Still though, passing the addr= option shouldn't be harmful since the
>> current version of mount just ignores it. We just may not get the
>> desired behavior without that.
>> 
>> Ian, are you still planning to consider this for inclusion in 4.1.5 or
>> 5.x?

raven> My plan is fairly simple.

raven> Get a basic implementation that provides direct mounts and release
raven> as first alpha. I'm likely to label it 5.0.0 as the best way to
raven> support the needed change in the protocol between the kernel and the
raven> daemon is to bump the kernel module protocol version (to 5.00 as
raven> well).

raven> Release 4.1.5 soon after, another bug fix release to have as stable
raven> a base as possible before starting work on 4.1.6 which will include
raven> analysis and possible merge of the LDAP rework , your mount rework
raven> and the run in forground patches.

The run in the foreground patches don't actually add any functionality.
Can we push those to v5?  It seems like a pretty silly change to make in a
stable release, especially since it isn't difficult to debug autofs the way
it stands today, via logging.

When you're fixing to merge in the LDAP stuff, can we get that reposted to
the list?

raven> Following that (and probably while working on the above) I will
raven> return to working on 5.0.0. Forward porting the patches from
raven> 4.1.6. New stuff that will actually be in 5.0.0 is not final
raven> yet. There are two critical areas that still require a lot of
raven> work. First is lazy mount/umount of multi-mount mount entries. This
raven> is really difficult. Second is implementing a utility to startup and
raven> shutdown autofs to get the complexity out of the init script.

Joy!  Can I add to the list a re-write of the parser?  Yes, I'll sign up to
do the leg work.  This seems to be the most error-prone and fragile bit of
code.

raven> Another issue is the patch for mount that's heading for util-linux
raven> some time (and has been in the FC mount) which causes no less than 7
raven> ports per mount to be opened. autofs opens 2 as well giving a total
raven> of 9 per mount. Only one is needed for the actual mount. As I said
raven> on the NFS list, I'm wondering if it's possible to use the SO_LINGER
raven> option to help.

Steve Dickson fixed this.  In fact, he trimmed down the number of reserved
ports used by quite a bit.  Perhaps you should try out the latest rawhide
packages?

-Jeff
