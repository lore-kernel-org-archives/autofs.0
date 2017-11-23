From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Thu, 23 Nov 2017 11:47:13 +1100
Message-ID: <8760a1254e.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net> <874lpo2y9e.fsf@notabene.neil.brown.name> <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Al Viro <viro@ZenIV.linux.org.uk>
Cc: Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22 2017, Ian Kent wrote:

> On 21/11/17 09:53, NeilBrown wrote:
>> On Wed, May 10 2017, Ian Kent wrote:
>>=20
>>> The fstatat(2) and statx() calls can pass the flag AT_NO_AUTOMOUNT
>>> which is meant to clear the LOOKUP_AUTOMOUNT flag and prevent triggering
>>> of an automount by the call. But this flag is unconditionally cleared
>>> for all stat family system calls except statx().
>>>
>>> stat family system calls have always triggered mount requests for the
>>> negative dentry case in follow_automount() which is intended but preven=
ts
>>> the fstatat(2) and statx() AT_NO_AUTOMOUNT case from being handled.
>>>
>>> In order to handle the AT_NO_AUTOMOUNT for both system calls the
>>> negative dentry case in follow_automount() needs to be changed to
>>> return ENOENT when the LOOKUP_AUTOMOUNT flag is clear (and the other
>>> required flags are clear).
>>>
>>> AFAICT this change doesn't have any noticable side effects and may,
>>> in some use cases (although I didn't see it in testing) prevent
>>> unnecessary callbacks to the automount daemon.
>>=20
>> Actually, this patch does have a noticeable side effect.
>
> That's right.
>
>>=20
>> Previously, if /home were an indirect mount point so that /home/neilb
>> would mount my home directory, "ls -l /home/neilb" would always work.
>> Now it doesn't.
>
> An this is correct too.
>
> The previous policy was that a ->lookup() would always cause a mount to
> occur. It's that policy that prevents the AT_NO_AUTOMOUNT flag from being
> able to work consistently.

Just to be clear, the previous policy was:
 kernel - a lookup would cause a message to be sent to the automount daemon
 daemon - the receipt of a message would cause a mount to occur.

Either part of this policy could be changed to allow AT_NO_AUTOMOUNT to
work reliably.  You chose to change the first.  At the time I thought
this was a good idea.  I no longer think so.

Specifically, I think the second part of the policy should be revised a lit=
tle.

>
> If you set the indirect mount "browse" option that will cause the mount
> point directories for each of the map keys to be pre-created. So a
> directory listing will show the mount points and an attempt to access
> anything within the mount point directory will cause it to be mounted.
>
> There is still the problem of not knowing map keys when the wildcard
> map entry is used.
>
> Still, stat family systems calls have always had similar problems that
> prevent consistent behavior.

Yes, I understand all this.  stat family sys-call have some odd
behaviours at times like "stat(); open(); fstat()" will result in
different sets of status info.  This is known.
The point is that these odd behaviours have changed in a noticeably way
(contrary to the change log comment) and it isn't clear these changes
are good.

>
>>=20
>> This happens because "ls" calls 'lstat' on the path and when that fails
>> with "ENOENT", it doesn't bother trying to open.
>
> I know, I believe the ENOENT is appropriate because there is no mount
> and no directory at the time this happens.

Two distinct statements here.  "no mount" and "no directory".
If AT_NO_AUTOMOUNT is given (or implicit) the "no mount" is significant
and shouldn't be changed.   It isn't clear that "no directory" is
significant.
If you think of the list of names stored in the autofs filesystem as a
cache of recently used names from the map, then the directory *does*
exist (in the map), it is just that the (in-kernel) cache hasn't been
populated yet.
Should "AT_NO_AUTOMOUNT" prevent the cache from being populated?

>
>>=20
>> An alternate approach to the problem that this patch addresses is to
>> *not* change follow_automount() but instead change the automount daemon
>> and possibly autofs.
>
> Perhaps, but the daemon probably doesn't have enough information to
> make decisions about this so there would need to be something coming
> from the kernel too.

I don't think so.
The daemon already has a promise that upcalls for a given name are
serialized, and it has the ability to test if a name is already in the
cache.  This is enough.
I applied the following patch:

diff --git a/modules/mount_nfs.c b/modules/mount_nfs.c
index c558a7381054..7ddfe9c61038 100644
=2D-- a/modules/mount_nfs.c
+++ b/modules/mount_nfs.c
@@ -269,6 +269,11 @@ dont_probe:
 		free_host_list(&hosts);
 		return 1;
 	}
+	if (!status) {
+		debug(ap->logopt, MODPREFIX "created dir, that'll do for now");
+		free_host_list(&hosts);
+		return 0;
+	}
=20
 	if (!status)
 		existed =3D 0;

to automount and now it behaves (for NFS mounts) how I would like (though
there is room for improvement).

>
>>=20
>> When a notification of access for an indirect mount point is received,
>> it would firstly just create the directory - not triggering a mount.
>> If another notification is then received (after the directory has been
>> created), it then triggers the mount.
>
> Not sure, perhaps.
>
> But I don't think that will work, I've had many problems with this type
> behavior due to bugs and I think the the same sort of problems would be
> encountered.
>
> The indirect mount "browse" option which behaves very much like what your
> suggesting is the internal program default, and has been since the initial
> v5 release. Historically it is disabled on install to maintain backward
> compatibility with the original Linux autofs (which is also the reason for
> always triggering an automount on ->lookup()).
>
> Perhaps now is the time for that to change.

Enabling browse mode does resolve this problem when the map is
enumerable (as you say, wildcards can't be supported).
But browse mode isn't always wanted.  If you have a very large map, then
caching all 10,000 entries in the kernel may be a pointless waste of
time and space.

>
>>=20
>> I suspect this might need changes to autofs to avoid races when two
>> threads call lstat() on the same path at the same time.  We would need
>> to ensure that automount didn't see this as two requests.... though
>> maybe it already has enough locking.
>>=20
>> Does that seem reasonable?  Should we revert this patch (as a
>> regression) and do something in automount instead?
>
> Can you check out the "browse" option behavior before we talk further
> about this please.

Done that.

>
> The problem in user space now is that there is no way to control
> whether an indirect mount that uses the "nobrowse" option is triggered
> or not (using fstatat() or statx()) regardless of the flags used and it's
> essential the AT_NO_AUTOMOUNT flag work as expected to have user space
> take more care in not triggering automounts.

I think that user-space has all the control that it needs.
There are two cases:
1/ daemon receives "missing indirect" message and the directory
   doesn't currently exist (mkdir() by the daemon succeeds).
   This could be an AT_NO_AUTOMOUNT lookup, or it could be a full
   open() or similar.  In either case the directory gets created if
   the map suggests that the name should exist.  The daemon needs to
   be careful not to block for long if it goes off-host to check for
   validity of the name.

2/ daemon received "missing indirect" message and the directory
   *does* exist (mkdir() by daemon fails with -EEXIST).
   This cannot be an AT_NO_AUTOMOUNT lookup, it must be a lookup
   intended to trigger automounts.  In this case, we trigger the
   mount.

This does lead to an odd behaviour with wildcards.
If /misc is a map with a wildcard entry, then
  ls -d /misc/IDoNotExist
will create IDoNotExist and report its existence.
  ls -l /misc/IDoNotExist
will report that it doesn't exist, but it will still have
been created.

Removing the directory after a mount-attempt fails is probably only
a few more lines of code to my patch, and would fix the worst of this.
Have a very short timeout on directories that don't immediately get
mounted on (e.g. 2 seconds??) would further improve the situation.
That timeout would have to be completely managed in the daemon
as the kernel doesn't expire empty directories.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloWGpIACgkQOeye3VZi
gbnLwA/9ECG2fYWN0T5yX4LEOMFAp+vrVQ45j4yxHpF5ua73+kmwaJxuRZyqfdqm
i7P9TO6Ifunh04zPEpZitRNl78nhH3Tfj1V+W5FEowfKZ/i/9EQTcg21fSpt1a6v
3gzZ9JthQJ3TqzhtSzyiqb2+uiRq0PiMbAqsPtqQPoiGq02nyKMhjkVcRaPybcsn
8xhFlpiNQBk5X9ESECUda7trq0zI6b+qsrPPyJdMzW5fhgi96HjuCJyjSG9zNAev
NmmdagFuuvnzWVlr9viNQJfMwgXqDc5ELqZ3Awfsugh+5V+IcckyGSzujWJXXh5X
RHu9e0fYhXAsamzWbsJV2ypcVHvH/bl/5IFKp0q/qjsPipMLgYTNQZdSQ2hfC8f4
UcmWUs9hdmWXxy+v6+6h8EzjzjNeTErEUnfYxhDKlLZLv1APA0ipDT3AGH4878SV
jJkji1YDNMp2vJI7Jpwcuq2ZafU7sB9DXeVHaRTfXI0oku2/ErsAEDhBI8zywinC
HDkVXH5GyzXKvL53gaW6SCkKn31N/pgx4R+81UlqFptCI88aCLX/7qGB/7lxkHa7
uAX0I/g1wHI/zt7TEGfpJDLPx87oQ8je6hjUycmlNUDtRCoQYI6Zd3yWy4zW1M2H
pDCIXAxj+6Uzxf2qD+pMRDdMGLseW6mMiVcvomXjFifKzckTCSI=
=HWbU
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
