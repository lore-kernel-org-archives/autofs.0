From: Guillaume Apostoly <guillaume.apostoly@gmail.com>
Subject: Re: stat -L triggering mount (behavior change starting with 2.6.38-rc1)
Date: Wed, 27 Mar 2013 01:13:06 +0100
Message-ID: <F786405B-C474-404B-9A9D-63DEC8A2B0B9@gmail.com>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com> <loom.20130326T135119-763@post.gmane.org> <CAEySpB7frBeNDFAZM8+magDZqSNwf4XEQqzUK652hrak9H5tXA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:references:mime-version:in-reply-to:content-type
         :content-transfer-encoding:message-id:cc:x-mailer:from:subject:date
         :to;
        bh=Y63uysfEHFUKg9GEPi1HSiU0lvrUWaCfISgOUJ4q2y4=;
        b=i0Ad7aos8ZcsrLGb0hUOKune0bAVTr1fTGFMB/LJA47l/rKu0TuvG4ZKD0VjOZzlK9
         O9aIoQPpxfgZnhDjzfndEF0QUxldR/XC1gyqPTaKWWT/yp9pGpMsuXVOfmnGkDXq4EqP
         c833Kn8qnPPSI3k/0y9yeEqw9Y/mkGkvtmmFvQJ6tsM/l+1El29jNZGoXX+zGG/gprO7
         TDUjcm2qVv/uAkBsRyNDZ3sxy9J5GycxkyF9HcbpfUZxLPAl98qoYWngUTHMUv129dp7
         7aKVhJ8eCv3onlO3aY8BNvTYS/Dl7lAyMvLwX39OoDU5qoTm2Zt6wxzvKoiK5ZHDhFvx
         etoA==
In-Reply-To: <CAEySpB7frBeNDFAZM8+magDZqSNwf4XEQqzUK652hrak9H5tXA@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: toto <guillaume@apostoly.com>, "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Thanks for your quick answer ! I already tried cd and ls but it does no=
t work, I will try stat tomorrow, until now the automount trigger is on=
ly working when trying to access from a GUI. I will let you know of the=
 result.

Envoy=C3=A9 de mon iPad

Le 26 mars 2013 =C3=A0 21:41, Leonardo Chiquitto <leonardo.lists@gmail.=
com> a =C3=A9crit :

> On Tue, Mar 26, 2013 at 9:56 AM, toto <guillaume@apostoly.com> wrote:
>> Leonardo Chiquitto <leonardo.lists <at> gmail.com> writes:
>>=20
>>>=20
>>> Hello,
>>>=20
>>> After the update to 2.6.38, I noticed that AutoFS started to mount =
volumes
>>> at times it normally wouldn't. More specifically, "ls -la" inside a=
n AutoFS
>>> mount point will trigger the mount of all available maps.
>> __________
>>> autofs mailing list
>>> autofs <at> linux.kernel.org
>>> http://linux.kernel.org/mailman/listinfo/autofs
>>=20
>> Hi,
>=20
> Hi,
>=20
>> When you are saying that "ls -la" should not trigger
>> the automounting of the volumes inside the directory,
>> what would be then the good command line to
>> trigger the mounting of volumes declared in auto.master ?
>=20
> The problem that was discussed in this thread was about
> accesses to a parent directory triggering mounts of volumes
> in sub-directories. An example:
>=20
> /nfs/volume1
> /nfs/volume2
>=20
> Here volume1 and volume2 are two automounted directories.
> What was happening is that "ls -la /nfs" was triggering the
> mounts of volume1 and volume2.
>=20
>> I am using Mac OS X 10.8.3 and by default,
>> the elements defined in automaster are mounted when
>> accessed by an application (like the Finder,
>> which is if you don't know the file manager of OS X), but how
>> then to trigger the silent mounting at startup
>> with a shell script ?
>=20
> You just need to access the volume. Using the example above,
> any of these should work:
>=20
> $ stat /nfs/volume1/    #  the slash at the end is important
> $ cd /nfs/volume1
> $ ls /nfs/volume1
>=20
>> Are there parameters to pass to "mount"
>> command to say "mount this folder
>> NOW as defined in auto master" ?
>=20
> No, not that I'm aware.
>=20
> Thanks,
> Leonardo
