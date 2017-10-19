From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH v2] autofs-5.1.3 - fix ordering of seteuid/setegid in
 do_spawn
Date: Thu, 19 Oct 2017 10:29:54 +0800
Message-ID: <f5d94551-ef84-7a7a-539f-6caa78176104@themaw.net>
References: <150813019190.25695.13810689562896522990.stgit@pluto.themaw.net>
 <150813043348.25695.10697953082315362911.stgit@pluto.themaw.net>
 <cf4f19a9-cbf4-2077-a26a-922268c80507@suse.com>
 <12498ca2-9aae-54ab-832a-0760ba221261@suse.com>
 <19a1e4a4-063b-fb9d-eb47-9ac368d53aaf@themaw.net>
 <2712B578-9ADC-4C52-9918-D6C8621223A7@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=Ctfgo0eXcuWSmSAwk0G9cOj9iv7ol
        03p25z+EC4POjI=; b=S1JuFMpFls/jEhL7mFSuc3Q/SggzpTisrm1c/mZsPgpb5
        cW1k+b5MedrSMma1jLAokCqkhIT+oKJVgh8baSXwVwCbXKpzwzrfUIKu9jjb10S5
        4I8MB2Pl/n4rdqmIUdx7IIbCkaPzEkVwZyvJHzTgESOJRT7dbY558SgcrjIQUtZ2
        u6n5jL8wJK2yE6TfFOY10tNgTIdmx3DhlYqxG+D7fz7jvVqfmV1EK0bCFsB0cViY
        f5/2ITF95dzmIAcm4Y0Ni0CdpGeIPoU8c4J7MRP9aTM9XanIambw1ZeR63BH/9lo
        TReRLn0buGSFbBln7PUMU47jRh+Nz8Koj322QeM6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ctfgo0
        eXcuWSmSAwk0G9cOj9iv7ol03p25z+EC4POjI=; b=XkLqIyvsObTAPS0//lJrLB
        Kh1ONMWbPRaq86MlFzb635L9PY+KB62+/9+3yQzoDE4SUvHUlKOTWSsZUEPO8Fnm
        jWJQzYE1rZZwyJi6SsXw1Uks21dG2pFwM1vRUYREHpO1Kz9eqzMiqgkoOdTrcgOk
        nVyDkYSHoTuavycWU4oJAcXeNeM3ef8GD/z/prr8GH83hcAyH7nyhoA4OjlISPvc
        iHwtyapSL2Wx2VbyRJhJJDyCSAVH1s/Po83mqI7yv+RuGn7GeTI5YIb5vhDh0/Cz
        pXngqjAzqAn0a3LPwHmH482fjGxq04v3HAqBvNSE005C9gbBTlgvCWe7VL0giCgA
        ==
In-Reply-To: <2712B578-9ADC-4C52-9918-D6C8621223A7@suse.com>
Content-Language: en-US
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Jeff Mahoney <jeffm@suse.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On 19/10/17 10:20, Jeff Mahoney wrote:
> I wondered that too but decided against it since it=E2=80=99s happening w=
ith root privs anyway.

Right, it's probably not a problem, lets go with it how it is and see.

Whether to continue if seteuid() fails is a good question.
The assumption is it always succeeds but I guess it might not.

It probably shouldn't continue because if automounts in a dependent path
can't be mounted (via the open()) then the requested mount can't work
properly.

>=20
> -Jeff
>=20
> --
> Jeff Mahoney
> (apologies for the top post -- from my mobile)
>=20
>> On Oct 18, 2017, at 10:07 PM, Ian Kent <raven@themaw.net> wrote:
>>
>>> On 19/10/17 05:12, Jeff Mahoney wrote:
>>> In do_spawn, We call seteuid() prior to calling setegid() which means
>>> that, when we're using an unprivileged uid, we won't have permissions
>>> to set the effective group anymore.
>>>
>>> We also don't touch the group memberships so the permissions used to
>>> open the directory will will include all of root's supplementary groups
>>> and none of the user's.
>>>
>>> This patch reverses the ordering and uses initgroups() to reset the
>>> supplementary groups to the unprivileged user's groups.
>>>
>>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>>> ---
>>> daemon/spawn.c | 15 +++++++++++++--
>>> 1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/daemon/spawn.c b/daemon/spawn.c
>>> index c640d97..62e9f02 100644
>>> --- a/daemon/spawn.c
>>> +++ b/daemon/spawn.c
>>> @@ -20,6 +20,7 @@
>>> #include <string.h>
>>> #include <sys/types.h>
>>> #include <dirent.h>
>>> +#include <grp.h>
>>> #include <time.h>
>>> #include <poll.h>
>>> #include <sys/wait.h>
>>> @@ -195,8 +196,18 @@ static int do_spawn(unsigned logopt, unsigned int =
wait,
>>>             * program group to trigger mount
>>>             */
>>>            if (euid) {
>>> -                seteuid(euid);
>>> -                setegid(egid);
>>> +                if (initgroups(tsv->user, egid) =3D=3D -1)
>>
>> LOL, you spotted that one.
>>
>> I was wondering if the groups need to be restored after the open() ....
>> before the mount is executed.
>>
>>> +                    fprintf(stderr,
>>> +                        "warning: initgroups: %s\n",
>>> +                        strerror(errno));
>>> +                if (setegid(egid) =3D=3D -1)
>>> +                    fprintf(stderr,
>>> +                        "warning: setegid: %s\n",
>>> +                        strerror(errno));
>>> +                if (seteuid(euid) =3D=3D -1)
>>> +                    fprintf(stderr,
>>> +                        "warning: seteuid: %s\n",
>>> +                        strerror(errno));
>>>            }
>>>            setpgrp();
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe autofs" in
>>>
>>
>>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
>=20

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
