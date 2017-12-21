From: NeilBrown <neilb@suse.com>
Subject: Re: [ANNOUNCE] autofs 5.1.2 release
Date: Thu, 21 Dec 2017 12:09:28 +1100
Message-ID: <87po78khtj.fsf@notabene.neil.brown.name>
References: <1465960537.3164.1.camel@themaw.net> <876092krew.fsf@notabene.neil.brown.name> <5aee2303-d1c3-49fd-0ef9-362fb0256fd5@themaw.net> <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <be60384c-8d76-b384-3fdd-5f9f2f21a8e2@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, autofs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20 2017, Ian Kent wrote:

> On 20/12/17 13:52, Ian Kent wrote:
>> On 20/12/17 11:29, NeilBrown wrote:
>>>
>>> Hi Ian,
>>>  I've been looking at:
>>>
>>>> - add configuration option to use fqdn in mounts.
>>>
>>> (commit 9aeef772604) because using this new option causes a regression.
>>> If you are using the "replicated server" functionality, then
>>>   use_hostname_for_mounts =3D yes
>>> completely disables it.
>>=20
>> Yes, that's not quite right.
>>=20
>> It disables the probe and proximity check for each distinct host
>> name used.
>>=20
>> Each of the entries in the list of hosts should still be
>> attempted and given that NFS ping is also now used in the NFS
>> mount module what's lost is the preferred ordering of the hosts
>> list.
>>=20
>>>
>>> This is caused by:
>>>
>>> diff --git a/modules/replicated.c b/modules/replicated.c
>>> index 32860d5fe245..8437f5f3d5b2 100644
>>> --- a/modules/replicated.c
>>> +++ b/modules/replicated.c
>>> @@ -667,6 +667,12 @@ int prune_host_list(unsigned logopt, struct host *=
*list,
>>>         if (!*list)
>>>                 return 0;
>>>=20=20
>>> +       /* If we're using the host name then there's no point probing
>>> +        * avialability and respose time.
>>> +        */
>>> +       if (defaults_use_hostname_for_mounts())
>>> +               return 1;
>>> +
>>>         /* Use closest hosts to choose NFS version */
>>>
>>> My question is: why what this particular change made.
>>=20
>> It was a while ago but there were complains about using the IP
>> address for mounts. It was requested to provide a way to prevent
>> that and force the use of the host name in mounts.
>>=20
>>> Why can't prune_host_list() be allowed to do it's thing
>>> when use_hostname_for_mounts is set.
>>=20
>> We could if each host name resolved to a single IP address.
>>=20
>> I'd need to check that use_hostname_for_mounts doesn't get
>> in the road but the host struct should have ->rr set to true
>> if it has multiple addresses so changing it to work the way
>> your recommending shouldn't be hard. I think there's a couple
>> of places that would need to be checked.
>>=20
>> If the host does resolve to multiple addresses the situation
>> is different. There's no way to stop the actual mount from
>> trying an IP address that's not responding and proximity
>> doesn't make sense either again because every time a lookup
>> is done on the host name (eg. at mount time) the next address
>> in its list will be returned which can and usually is different
>> from what would have been checked.
>>=20
>>> I understand that it would be pointless choosing between
>>> the different interfaces of a multi-homed host, but there is still value
>>> in choosing between multiple distinct hosts.
>>>
>>> What, if anything, might go wrong if I simply reverse this chunk of the
>>> patch?
>>=20
>> You'll get IP addresses in the logs in certain cases but that
>> should be all.
>>=20
>> It would probably be better to ensure that the checks are done
>> if the host name resolves to a single IP address.
>
> I think that should be "if the host names in the list each resolve
> to a single IP address", otherwise the round robin behavior would
> probably still get in the road.

I cannot see why the round-robin behavior would get in the road.
It might be pointless to probe each IP address on a multi-homed host if
we are just going to mount by host name, but I don't see how it hurts.

So this is what I'm thinking.  Some simple testing suggests that
it does the right things.

If a host has addresses with different proximity they will still be
probed separately, but this won't affect the final choice.

Thanks,
NeilBrown

=2D-------8<---------------
Subject: use_hostname_for_mounts shouldn't prevent selection among replica

If several replicas have been specified for a mount point, and
use_hostname_for_mount is set to "yes", the selection between
these replicas is currently disabled and the last in the list is always
chosen.

There is little point selecting between different interfaces on the one
host in this case, but it is still worth selecting between different
hosts, particularly if different weights have been specified.

This patch restores the "prune_host_list()" functionality when
use_hostname_for_mount is set, and modifies it slightly so that once
an IP address with a given proximity has been successfully probed,
other IP address for the same host(weight):/path and proximity are ignored.

Signed-off-by: NeilBrown <neilb@suse.com>

diff --git a/modules/replicated.c b/modules/replicated.c
index 3ac4c70f4062..16cf873513ff 100644
=2D-- a/modules/replicated.c
+++ b/modules/replicated.c
@@ -714,7 +714,7 @@ done:
 int prune_host_list(unsigned logopt, struct host **list,
 		    unsigned int vers, int port)
 {
=2D	struct host *this, *last, *first;
+	struct host *this, *last, *first, *prev;
 	struct host *new =3D NULL;
 	unsigned int proximity, selected_version =3D 0;
 	unsigned int v2_tcp_count, v3_tcp_count, v4_tcp_count;
@@ -726,12 +726,6 @@ int prune_host_list(unsigned logopt, struct host **lis=
t,
 	if (!*list)
 		return 0;
=20
=2D	/* If we're using the host name then there's no point probing
=2D	 * avialability and respose time.
=2D	 */
=2D	if (defaults_use_hostname_for_mounts())
=2D		return 1;
=2D
 	/* Use closest hosts to choose NFS version */
=20
 	first =3D *list;
@@ -877,11 +871,18 @@ int prune_host_list(unsigned logopt, struct host **li=
st,
=20
 	first =3D last;
 	this =3D first;
+	prev =3D NULL;
 	while (this) {
 		struct host *next =3D this->next;
 		if (!this->name) {
 			remove_host(list, this);
 			add_host(&new, this);
+		} else if (defaults_use_hostname_for_mounts() && prev &&
+			   prev->proximity =3D=3D this->proximity &&
+			   strcmp(prev->name, this->name) =3D=3D 0 &&
+			   strcmp(prev->path, this->path) =3D=3D 0 &&
+			   prev->weight =3D=3D this->weight) {
+			/* No need to probe same host(weight):/path again */
 		} else {
 			status =3D get_supported_ver_and_cost(logopt, this,
 						selected_version, port);
@@ -889,6 +890,7 @@ int prune_host_list(unsigned logopt, struct host **list,
 				this->version =3D selected_version;
 				remove_host(list, this);
 				add_host(&new, this);
+				prev =3D this;
 			}
 		}
 		this =3D next;

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlo7CckACgkQOeye3VZi
gbl67g/+Oy+dnA4Wxyq4tHnNUtgWcjcwt95Trpr5JxXIU3qZeyOJKUG3ThY2gbHf
Dcj7+tZH8PniEwsGDqxYMqZICPbunPrr2hsUBo89u7m2InhWLUpMN4Xi+Hwcge5y
9eHg1pl7vMBHpLiMFCWSgRCh07y6ybCXFMHEuBiIglIGo+O4z24PnVbLmDe8Kbxd
GhVYyXbUfuwxt3qIWzKYb3xgNFhy/odkbFmd3IYbqR+vdX4gIF85rEKSGcBJ3QZZ
FmA0qi0bTEYuv2G/+W4UJ0N0trtId5arftbGHH/DfO5q6FMO+Vz1MkONn/RJcfYW
Yv7YwiSNEMEj9rpUcbvcJ8n40YYLtjekEL+KE8lxn/1gbeKBm38FY8MCoanCysDd
z7MSVDwd7Z0DT8EXQkWJD2GJOo6lipeAo4suO9AXg/L5iQ2tSpRifWxKWcR0lrTt
dKnSG2vFFh2/t6QUNMf2wSHa9iun8Pr2VY7isXwVqvuyDiEMuIF8AEsmXMqF+JwZ
G4aKFY3pq9QqH/K2e4khtg+3IpM9WF+d4OJhPdR1aPL+82UXSXgvZSIbpzL4S+SN
7Fa/ueQJnf+NdxrtjLF19uHfYs8+y+UOC09o1f6VkbaNVtdWtBZnCAoaEzMt9Gce
KjrLJtX3MJtXjm/hIcQxQLtHSAwS3rCWmNqi8w5MfAObfQQ5mBc=
=1fMG
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
