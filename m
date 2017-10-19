From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH v2] autofs-5.1.3 - fix ordering of seteuid/setegid in do_spawn
Date: Wed, 18 Oct 2017 22:20:08 -0400
Message-ID: <2712B578-9ADC-4C52-9918-D6C8621223A7@suse.com>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net> <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net> <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com> <12498ca2-9aae-54ab-832a-0760ba221261@suse.com> <19a1e4a4-063b-fb9d-eb47-9ac368d53aaf@themaw.net>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <19a1e4a4-063b-fb9d-eb47-9ac368d53aaf@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>

I wondered that too but decided against it since it=E2=80=99s happening wit=
h root privs anyway.

-Jeff

--
Jeff Mahoney
(apologies for the top post -- from my mobile)

> On Oct 18, 2017, at 10:07 PM, Ian Kent <raven@themaw.net> wrote:
>=20
>> On 19/10/17 05:12, Jeff Mahoney wrote:
>> In do_spawn, We call seteuid() prior to calling setegid() which means
>> that, when we're using an unprivileged uid, we won't have permissions
>> to set the effective group anymore.
>>=20
>> We also don't touch the group memberships so the permissions used to
>> open the directory will will include all of root's supplementary groups
>> and none of the user's.
>>=20
>> This patch reverses the ordering and uses initgroups() to reset the
>> supplementary groups to the unprivileged user's groups.
>>=20
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>> ---
>> daemon/spawn.c | 15 +++++++++++++--
>> 1 file changed, 13 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/daemon/spawn.c b/daemon/spawn.c
>> index c640d97..62e9f02 100644
>> --- a/daemon/spawn.c
>> +++ b/daemon/spawn.c
>> @@ -20,6 +20,7 @@
>> #include <string.h>
>> #include <sys/types.h>
>> #include <dirent.h>
>> +#include <grp.h>
>> #include <time.h>
>> #include <poll.h>
>> #include <sys/wait.h>
>> @@ -195,8 +196,18 @@ static int do_spawn(unsigned logopt, unsigned int w=
ait,
>>             * program group to trigger mount
>>             */
>>            if (euid) {
>> -                seteuid(euid);
>> -                setegid(egid);
>> +                if (initgroups(tsv->user, egid) =3D=3D -1)
>=20
> LOL, you spotted that one.
>=20
> I was wondering if the groups need to be restored after the open() ....
> before the mount is executed.
>=20
>> +                    fprintf(stderr,
>> +                        "warning: initgroups: %s\n",
>> +                        strerror(errno));
>> +                if (setegid(egid) =3D=3D -1)
>> +                    fprintf(stderr,
>> +                        "warning: setegid: %s\n",
>> +                        strerror(errno));
>> +                if (seteuid(euid) =3D=3D -1)
>> +                    fprintf(stderr,
>> +                        "warning: seteuid: %s\n",
>> +                        strerror(errno));
>>            }
>>            setpgrp();
>>=20
>>=20
>>=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>>=20
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
