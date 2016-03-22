From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve scalability
Date: Mon, 21 Mar 2016 23:50:51 -0400
Message-ID: <56F0C11B.9000005@suse.com>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
 <1458606264.3014.20.camel@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KAiCQA6gcvGvEtHNPMubhRJnFxRobNQIo"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1458606264.3014.20.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KAiCQA6gcvGvEtHNPMubhRJnFxRobNQIo
Content-Type: multipart/mixed; boundary="IDGlrOUdujKc8LEl1s0wdLk2GQ65MN8mw"
From: Jeff Mahoney <jeffm@suse.com>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Message-ID: <56F0C11B.9000005@suse.com>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve scalability
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
 <1458606264.3014.20.camel@themaw.net>
In-Reply-To: <1458606264.3014.20.camel@themaw.net>

--IDGlrOUdujKc8LEl1s0wdLk2GQ65MN8mw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/21/16 8:24 PM, Ian Kent wrote:
> On Mon, 2016-03-21 at 18:08 -0400, Jeff Mahoney wrote:
>> On 3/20/16 11:44 PM, Ian Kent wrote:
>>> On Fri, 2016-03-18 at 17:25 -0400, Jeff Mahoney wrote:
>>>> Commit d3ce65e05d1 (autofs-5.0.3 - allow directory create on NFS
>>>> root),
>>>> introduced a bug where contained_in_local_fs would *always* return
>>>> true.=20
>>>>
>>>> Since the goal of contained_in_local_fs is only to determine if
>>>> the
>>>> path would be created on a local file system, it's enough to check
>>>> a
>>>> few things directly without parsing the mount table at all.
>>>>
>>>> We can check via stat calls:
>>>> 1) If parent is the root directory
>>>> 2) If the parent is located on the root file system
>>>> 3) If the parent is located within a file system mounted
>>>>    via a block device
>>>>
>>>> Large numbers of direct mounts when using /proc/self/mounts
>>>> instead
>>>> of /etc/mtab result in very slow startup time.  In testing, we
>>>> observed
>>>> ~8k mounts taking over 6 hours to complete.
>>>
>>> When this was originally done the mtab was (usually) an actual file
>>> so
>>> the autofs mounts weren't present. So mostly it was fairly small.
>>>
>>> But now, with the symlinking of the mtab to a proc filesystem, this
>>> is a
>>> big problem.=20
>>>
>>>>
>>>> This is due to reading /proc/self/mounts for every path component
>>>> of
>>>> every mount.  For my test case, that turns out to be about 119k
>>>> times
>>>> for a total of just under 400 GB read.  If it were a flat file, it
>>>> would be also be slow, but /proc/self/mounts is dynamically
>>>> generated
>>>> every time it's read.
>>>>
>>>> By avoiding reading /proc/self/mounts many times, startup time
>>>> with 8k
>>>> direct mounts drops from ~6 hours to about 25 seconds.
>>>
>>> Yeah, I get that.
>>>
>>> In some tests done before the symlinking became the norm I saw
>>> direct
>>> mount tables of over 20k entries taking between 20-30 seconds or a
>>> bit
>>> more (can't quite remember now, it was a long time ago) but nothing
>>> like
>>> this.
>>
>> Yep, I figured you'd remember what was up since it's in the README,
>> but
>> the context is mostly for a complete commit log entry.
>>
>>> I thought that was bad so this really needs to be fixed.
>>>
>>> I am puzzled why I haven't seen other bug reports.
>>
>> Yeah, I usually see all of the autofs bugs reported against our
>> products
>> and it's the first time I've seen it too.
>>
>>>>
>>>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>>>> ---
>>>>  daemon/automount.c |   47
>>>> ++++++++++++++++++++++++++++++++++++++++++++---
>>>>  include/mounts.h   |    1 -
>>>>  lib/mounts.c       |   45 ---------------------------------------
>>>> ----
>>>> --
>>>>  3 files changed, 44 insertions(+), 49 deletions(-)
>>>>
>>>> --- a/daemon/automount.c
>>>> +++ b/daemon/automount.c
>>>> @@ -98,6 +98,46 @@ static int umount_all(struct autofs_poin
>>>> =20
>>>>  extern struct master *master_list;
>>>> =20
>>>> +#define SYSFS_PATTERN "/sys/dev/block/%d:%d"
>>>> +static int contained_in_local_fs(const char *parent)
>>>> +{
>>>> +	char buf[128];
>>>> +	struct stat st, root;
>>>> +	int ret;
>>>> +
>>>> +	/* The root directory is always considered local, even if
>>>> it's not. */
>>>> +	if (!*parent)
>>>> +		return 1;
>>>> +
>>>> +	ret =3D stat("/", &root);
>>>> +	if (ret !=3D 0) {
>>>> +		logerr("error: stat failed on /: %s",
>>>> strerror(errno));
>>>> +		return 0;
>>>> +	}
>>>> +
>>>> +	ret =3D stat(parent, &st);
>>>> +	if (ret)
>>>> +		return 0;
>>>> +	/*
>>>> +	 * If the parent is on the root file system, it's local.
>>>> +	 */
>>>> +	if (root.st_dev =3D=3D st.st_dev)
>>>> +		return 1;
>>>
>>> I'm struggling to remember now.
>>>
>>> I think the problem was only when the root itself was an NFS file
>>> system
>>> and automount was trying to create a directory.
>>
>> That sounds like the problem that the patch that caused it to always
>> return true was supposed to solve.
>>
>> Git tells me that contained_in_local_fs matches up with:
>> commit 8293b030944eb402893a008a7d2ed1f8969ebee8
>> Author: Ian Kent <raven@raven.themaw.net>
>> Date:   Wed Oct 25 15:51:13 2006 +0800
>>
>>     - deal with changed semantics of mkdir in 2.6.19.
>>
>> Does that ring a bell?  Google associates it with a patch called
>> "don't
>> create remote dirs" which makes sense on its own but I can't find
>> anything in the kernel changelog between v2.6.18 and v2.6.19 that
>> stands
>> out as changed mkdir semantics that would necessitate the work being
>> done here.
>=20
> There was a log going on at that time, it was around the initial v5
> development.
>=20
> I had started cataloguing the patches for each release at that time but=

> by the look of the path order there's nothing else related that went in=

> with it. Not only that, at that time, my change log entries were either=

> non-existent or less than stellar.
>=20
> You can see the patch series for each release at:
> https://www.kernel.org/pub/linux/daemons/autofs/v5/
>=20
> I think this all arose from a discussion on the NFS mailing list due to=

> problems when trying to create mount point directories that resulted in=

> something like "automount shouldn't be creating directories on NFS file=

> systems". So the changed semantics were probably wrt. NFS and not the
> VFS.
>=20
> But the same logic extends to remote file systems in general.
>=20
>>
>> At the point where that commit was added, the test for an autofs
>> parent
>> wasn't in the caller.  That searched through the mount table to see if=

>> there was a match and if it was autofs.  The statfs call was
>> originally
>> in the loop and was rightly moved out of it since statfs() doesn't
>> actually require that its path argument be a mountpoint.  So that just=

>> makes the loop test whether it's a block device.  Sort of, since it
>> uses
>> /[^/] as a pattern to mean block device.  Later that was extended to
>> include UUID/LABEL and also with the patch that was intended to match
>> NFS roots.
>=20
> There's not really enough context, we'll just need to resolve it based
> on what's sensible.
>=20
>>
>> So, I suppose the question is this: if that patch was accepted based
>> on
>> its intent, it should be ok to write to a remote file system if it's
>> the
>> root file system, right?  The root file system should be assumed to be=

>> private, but once we follow a path off of the root file system we
>> shouldn't write anymore.
>=20
> The mount table scan has to go, whatever we come up with is going to ge=
t
> committed with the next bunch of patches.
>=20
>>
>>>> +
>>>> +	/*
>>>> +	 * If the sysfs node for the block device exists, it's
>>>> local.
>>>> +	 */
>>>> +	ret =3D snprintf(buf, sizeof(buf), SYSFS_PATTERN,
>>>> +		       major(st.st_dev), minor(st.st_dev));
>>>> +	if (ret !=3D 0) {
>>>> +		logerr("error: not enough space for sysfs path");
>>>> +		return 0;
>>>> +	}
>>>
>>> This is the only bit that concerns me.
>>>
>>> Not because I think it's wrong, on the contrary, it looks ok.
>>>
>>> I just can't think of cases where it might not cover what's needed.
>>
>> I realized shortly after posting the patch that anything using
>> anonymous
>> device nodes would fail the lookup test since they don't register a
>> node
>> in /sys/dev/block (nor should they.)  This includes btrfs since it
>> uses
>> anonymous devices to account for the fact that virtualizes the file
>> system across multiple devices and also needs separate namespace for
>> inode numbers between snapshots.  Ubifs also uses an anonymous device,=

>> but I've never actually seen an ubifs file system in the wild.
>=20
> Or perhaps pass down the statfs buffer and check for remote fs magic
> numbers. That's got to be a smaller list and should be much less likely=

> to change.
>=20
>> Overlayfs will use an anonymous device for directories since they're
>> also virtualized.  That's a separate issue, though, since it reports
>> the
>> device as 'none' in the mount table so direct mounts don't work on
>> overlayfs yet anyway.
>>
>>> After all, it's already been checked if the parent is an autofs
>>> filesystem which should take care of the bulk of cases except for
>>> longer
>>> direct mount paths, but will often not be the case for offset
>>> mounts.
>>>
>>> For example a mount entry with offset mounts like:
>>>
>>> <direct or indirect key>     /      server:/path \
>>>                              /other server:/otherpath \
>>>                              ...
>>>
>>> But the intermediate path components of a direct mount path (and
>>> offset
>>> mount path) must already exist if within a remote mount. So the
>>> existenc
>>> e case, checked before this, should cover these cases.
>>>
>>> Let me think about it a little longer.
>>
>> Sure.  It seems like the solution, whatever it ends up being, will
>> simplify this code a lot.  It seems like it boils down to "don't
>> create
>> directories on a remote file system unless it's the root file system."=

>>
>> As noted above, my patch is incomplete.  I think a complete solution
>> would look like this:
>>
>> 1/ Test whether the parent is autofs.
>> 2/ Test whether the parent resides on a type of file system known to
>> be
>> local.  This is mostly because we'll need to at least test for btrfs,
>> and if we're already testing file system type, we might as well test
>> for
>> the common local file systems as well.
>> 3/ Test whether the parent resides on the root file system.
>> 4/ Test whether the file system is mounted on a block device using the=

>> /sys/dev/block lookup.  This is mostly a fallback for the test in (2)
>> being imperfect WRT new file systems.
>>
>> Is this missing any other cases?
>=20
> The only bit that looks tricky is the test for a block device, the rest=

> covers many of the cases.
>=20
> And the point is to prohibit mount point directory creation on remote
> file systems, so if we get that far then just checking the magic number=

> of of the statfs struct we already have for known remote file systems
> should be enough and be a fairly short list.

Ok, that's an easy enough change to code up.  I'll post an updated patch.=


-Jeff

--=20
Jeff Mahoney
SUSE Labs


--IDGlrOUdujKc8LEl1s0wdLk2GQ65MN8mw--

--KAiCQA6gcvGvEtHNPMubhRJnFxRobNQIo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2

iQIcBAEBCAAGBQJW8MEfAAoJEB57S2MheeWyVO8P/Awhg7RhLdEz7M8jTK8OEHmj
hooLe2pstgPdVt8fwDqC2xHFaU/3VC0LsjBbHsVGpeVmiO/lgxmzLyDl/K+wxNzK
Y6NA+8SLot9H0aPWxiKZzygvFjNgecL8Ek8Rx/9OukNL6w46fnnT/fuVWPsde1yK
wC+VT1yg0TtEcaksjupnlXC/ngBWTgHsSXwXV+imZakFidfW+I8wuprWW5zeGSWi
CPErB+hDURLXCbimwJp5TG9xoRnBaPvnOxcvSOgBxjJ5wn4s4Gdp3JilfNOkQjdO
r2s4X5C29kPl9ALAxtIUgWZ1dkmBbt/iC/WO/fffgR+IwThRXVrYSgNhHU0ajQ36
8rxqUe5WeXq5WVfO9IIyXa4fLEcFPGnLc6FhgUyfr1H6Qf45opKevOOubRbgyWtu
cRCgAJ3zOnHdY7GcZ5w57Xh+uIu8Vy3xDorse8YAiaCiWlZYKi2faw8t+zRkmbEb
7VwRH3qn1uzW/38H3aBcJvIjbbrLoK5Kg0De5sJkCN3stgs522CIigkz4mmaiPMC
vFu2Nk502w6flr3jLkp7hPYB5y8zUZ5dGjMS+MSq2GmDIzoli8HXMLhy4r7FRL1k
7iNRWySkCu+pEpSB5VJFCa508pMRSj4KNezMhukKkJZjl5UMEOidEQX4rnl2+FVH
aLpjI+Q/j1zuc5+Fd6+H
=7Q9O
-----END PGP SIGNATURE-----

--KAiCQA6gcvGvEtHNPMubhRJnFxRobNQIo--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
