From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 18:39:50 +1100
Message-ID: <87efohwn21.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net> <874lpo2y9e.fsf@notabene.neil.brown.name> <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net> <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net> <20171127160147.GA27613@qualcomm.com> <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net> <20171128002935.GC27898@qualcomm.com> <87a7z5yjbs.fsf@notabene.neil.brown.name> <ae8e93be-8e3f-ffd8-9043-13737230d18d@themaw.net> <87lgipwxwo.fsf@notabene.neil.brown.name> <aeedaa64-5b1e-a6e7-29f0-576de17eabf4@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <aeedaa64-5b1e-a6e7-29f0-576de17eabf4@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>, Mike Marion <mmarion@qualcomm.com>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29 2017, Ian Kent wrote:

> On 29/11/17 11:45, NeilBrown wrote:
>> On Wed, Nov 29 2017, Ian Kent wrote:
>>=20
>>> Adding Al Viro to the Cc list as I believe Stephen Whitehouse and
>>> Al have discussed something similar, please feel free to chime in
>>> with your thoughts Al.
>>>
>>> On 29/11/17 09:17, NeilBrown wrote:
>>>> On Tue, Nov 28 2017, Mike Marion wrote:
>>>>
>>>>> On Tue, Nov 28, 2017 at 07:43:05AM +0800, Ian Kent wrote:
>>>>>
>>>>>> I think the situation is going to get worse before it gets better.
>>>>>>
>>>>>> On recent Fedora and kernel, with a large map and heavy mount activi=
ty
>>>>>> I see:
>>>>>>
>>>>>> systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
>>>>>> gnome-settings-daemon, packagekitd and gnome-shell
>>>>>>
>>>>>> all go crazy consuming large amounts of CPU.
>>>>>
>>>>> Yep.  I'm not even worried about the CPU usage as much (yet, I'm sure=
=20
>>>>> it'll be more of a problem as time goes on).  We have pretty huge
>>>>> direct maps and our initial startup tests on a new host with the link=
 vs
>>>>> file took >6 hours.  That's not a typo.  We worked with Suse engineer=
ing=20
>>>>> to come up with a fix, which should've been pushed here some time ago.
>>>>>
>>>>> Then, there's shutdowns (and reboots). They also took a long time (on
>>>>> the order of 20+min) because it would walk the entire /proc/mounts
>>>>> "unmounting" things.  Also fixed now.  That one had something to do in
>>>>> SMP code as if you used a single CPU/core, it didn't take long at all.
>>>>>
>>>>> Just got a fix for the suse grub2-mkconfig script to fix their parsin=
g=20
>>>>> looking for the root dev to skip over fstype autofs
>>>>> (probe_nfsroot_device function).
>>>>>
>>>>>> The symlink change was probably the start, now a number of applicati=
ons
>>>>>> now got directly to the proc file system for this information.
>>>>>>
>>>>>> For large mount tables and many processes accessing the mount table
>>>>>> (probably reading the whole thing, either periodically or on change
>>>>>> notification) the current system does not scale well at all.
>>>>>
>>>>> We use Clearcase in some instances as well, and that's yet another th=
ing
>>>>> adding mounts, and its startup is very slow, due to the size of
>>>>> /proc/mounts.=20=20
>>>>>
>>>>> It's definitely something that's more than just autofs and probably
>>>>> going to get worse, as you say.
>>>>
>>>> If we assume that applications are going to want to read
>>>> /proc/self/mount* a log, we probably need to make it faster.
>>>> I performed a simple experiment where I mounted 1000 tmpfs filesystems,
>>>> copied /proc/self/mountinfo to /tmp/mountinfo, then
>>>> ran 4 for loops in parallel catting one of these files to /dev/null 10=
00 times.
>>>> On a single CPU VM:
>>>>   For /tmp/mountinfo, each group of 1000 cats took about 3 seconds.
>>>>   For /proc/self/mountinfo, each group of 1000 cats took about 14 seco=
nds.
>>>> On a 4 CPU VM
>>>>   /tmp/mountinfo: 1.5secs
>>>>   /proc/self/mountinfo: 3.5 secs
>>>>
>>>> Using "perf record" it appears that most of the cost is repeated calls
>>>> to prepend_path, with a small contribution from the fact that each read
>>>> only returns 4K rather than the 128K that cat asks for.
>>>>
>>>> If we could hang a cache off struct mnt_namespace and use it instead of
>>>> iterating the mount table - using rcu and ns->event to ensure currency=
 -
>>>> we should be able to minimize the cost of this increased use of
>>>> /proc/self/mount*.
>>>>
>>>> I suspect that the best approach would be implement a cache at the
>>>> seq_file level.
>>>>
>>>> One possible problem might be if applications assume that a read will
>>>> always return a whole number of lines (it currently does).  To be
>>>> sure we remain safe, we would only be able to use the cache for
>>>> a read() syscall which reads the whole file.
>>>> How big do people see /proc/self/mount* getting?  What size reads
>>>> does 'strace' show the various programs using to read it?
>>>
>>> Buffer size almost always has a significant impact on IO so that's
>>> likely a big factor but the other aspect of this is notification
>>> of changes.
>>>
>>> The risk is improving the IO efficiency might just allow a higher
>>> rate of processing of change notifications and similar symptoms
>>> to what we have now.
>>=20
>> That's an issue that we should be able to get empirical data on.
>> Are these systems that demonstrate problems actually showing a high
>> rate of changes to the mount table, or is the mount table being
>> read frequently despite not changing?
>> To find out you could use a program like one of the answers to:
>>=20
>> https://stackoverflow.com/questions/5070801/monitoring-mount-point-chang=
es-via-proc-mounts
>>=20
>> or instrument the kernel to add a counter to 'struct mnt_namespace' and
>> have mounts_open_common() increment that counter and report the value as
>> well as ns->event.  The long term ratio of the two numbers might be
>> interesting.
>
> One scenario is, under heavy mount activity, the CPU usage of processes
> systemd, udisksd2, gvfs-udisks2-volume-monitor, gvfsd-trash,
> gnome-settings-daemon and packagekitd (and possibly gnome-shell, might
> be a false positive though) grow to consume all available CPU.

OK, that's pretty clearly caused by lots of changes happening in quick
succession.
The current poll support in the kernel is slightly non-optimal in that
it could trigger more events than necessary, but it probably doesn't
make a big difference.

The current code means that poll/select will report an event if there
has been an event since the last time that poll/select reported an
event.
It is only necessary to report an event if these has been one since the
last time that the first record in the file was read.
So if there are a sequence of events, then the file is read, a
subsequent poll will report another event where there isn't really one.
This would only be noticed if there was a delay between the event being
reported in the kernel, and the read happening.

You could test by removing
		m->poll_event =3D event;
from mounts_poll() and adding something like:
 if (*pos =3D=3D 0) m->poll_event =3D p->ns->event;
to m_start().


>
> The processes gvfs-udisks2-volume-monitor and gnome-settings-daemon=20
> (and possibly packagekitd, might be false positive) continue to use
> excessive CPU when the mount table is large but there is no mount/umount
> activity.

That is strange.  I wonder if something could be triggering phantom
events in some way.. Do they eventually settle, or does this continue
for hours.  Is there an easy way I could reproduce?

>
> In this case heavy mount activity means starting autofs with a direct
> mount map of 15k+ entries.

I'll try that tomorrow and see what happens.  Would bind mounts be
enough?

>
> The shutdown can be a problem too but umount(2) is just too slow for it
> to be as pronounced a problem as what we see at startup. The umount
> slowness appears to be constant. I'm not sure if it's proportional in any
> way to the number of mounts present on the system.

Changing synchronize_rcu() in namespace_unlock() to
synchronize_rcu_expedited() makes umount much faster.  Al has the patch
but hasn't responded.  Using "umount -c", which systemd now does, can
also help I think.

>
>>=20
>>=20
>>=20
>>>
>>> The suggestion is that a system that allows for incremental (diff
>>> type) update notification is needed to allow mount table propagation
>>> to scale well.
>>>
>>> That implies some as yet undefined user <-> kernel communication
>>> protocol.
>>=20
>> I can almost conceive a mountinfo variant where new entries always
>> appear at the end and deletions appear as just "$mnt_id".
>> struct proc_mounts would contain a bitmap similar to mnt_id_ida which
>> records which ids have been reported to this file.  When an event is
>> noticed it checks for deletions and reports them before anything else.
>> Keeping track of location in the ns->list list might be tricky.  It
>> could be done with a new 64bit never-reused mnt id, though some other
>> approach might be possible.
>>=20
>> An app would read to the end, then poll/select for exceptional events
>> and keep reading.
>
> Keeping track of modifications is certainly one of the problems and this
> sounds like a good start to resolving it ....
>
> I believe the current preferred delivery of this to be a shared library
> interface available to user space that talks to the kernel to obtain the
> needed information.

Any suggests at the sort of interface?  If I provided a pollable fd, and
a function which given the fd and a 'struct mntent' (or similar) would
fill in the mntent if info was available, would that be likely to suit?
Not that I'm promising anything but having a framework helps guide
thoughts.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloeZEYACgkQOeye3VZi
gbnfQxAArHrhe8hWxKkPj0quWu80AdZG6/1Rsp21oETVc3Qh0eWXg/wniihHI0C7
bhJRUr7YQ5NVVjCA8S7xcsbdajyxmAbsHaYh/YezAg6KYNjRaiEOBLN6M3dqjIju
pyXHkonA991L61t2pvh0zo1aVmNasuu9myR6TuwF2eSwdEZaMOaBL3LVug1XKZSZ
rgm967CXjeep1IHFcsW77VYX30lXVNYpzK+1Ba3EdnInB7mp2icmL7ILhHGYIkNi
nkiCUCpF4/6G/UiHsdIzr2DhE6kdJkrTWCzCAJvoElXqH3fSdV8f1gfe2FrAbfW6
1ZH7sJyizs1u70PW/ORYF4uu2s3ewrJRSwhf7INxaWGlSY0YgwlK6/4Ytb44IlpP
9uW2tmI/vQV/wOguhIChEZzgYpaTQ5EpqOSlsjiRo0WsOOkT3gdKj/HkFcWbkFKQ
ICp6B3nwHiKEORJARp14gMDp3NnudzwDYy8KEjLfKq52DL9gQrgJGZWU8KR/Uxrq
SGV+qze9HHcG4qYBgNrA42NLD+Krb0CeEAGaHU3H6cjJ8OVkQ4yf2Z4rZnOSreS4
qki/FIA/0zFTH1/RnJ7ICAjNcV6d7XjTy5ajWuOyMfsAGXcKukXYII3+AQCt2GHB
xBxspueJ3Y5Np5/pXkPf+FRngUynM0hubZJosebr+P0fQKhvmzo=
=nnsy
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
