From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 12:17:27 +1100
Message-ID: <87a7z5yjbs.fsf@notabene.neil.brown.name>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net> <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net> <874lpo2y9e.fsf@notabene.neil.brown.name> <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net> <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net> <20171127160147.GA27613@qualcomm.com> <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net> <20171128002935.GC27898@qualcomm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <20171128002935.GC27898@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Mike Marion <mmarion@qualcomm.com>, Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28 2017, Mike Marion wrote:

> On Tue, Nov 28, 2017 at 07:43:05AM +0800, Ian Kent wrote:
>
>> I think the situation is going to get worse before it gets better.
>>=20
>> On recent Fedora and kernel, with a large map and heavy mount activity
>> I see:
>>=20
>> systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
>> gnome-settings-daemon, packagekitd and gnome-shell
>>=20
>> all go crazy consuming large amounts of CPU.
>
> Yep.  I'm not even worried about the CPU usage as much (yet, I'm sure=20
> it'll be more of a problem as time goes on).  We have pretty huge
> direct maps and our initial startup tests on a new host with the link vs
> file took >6 hours.  That's not a typo.  We worked with Suse engineering=
=20
> to come up with a fix, which should've been pushed here some time ago.
>
> Then, there's shutdowns (and reboots). They also took a long time (on
> the order of 20+min) because it would walk the entire /proc/mounts
> "unmounting" things.  Also fixed now.  That one had something to do in
> SMP code as if you used a single CPU/core, it didn't take long at all.
>
> Just got a fix for the suse grub2-mkconfig script to fix their parsing=20
> looking for the root dev to skip over fstype autofs
> (probe_nfsroot_device function).
>
>> The symlink change was probably the start, now a number of applications
>> now got directly to the proc file system for this information.
>>=20
>> For large mount tables and many processes accessing the mount table
>> (probably reading the whole thing, either periodically or on change
>> notification) the current system does not scale well at all.
>
> We use Clearcase in some instances as well, and that's yet another thing
> adding mounts, and its startup is very slow, due to the size of
> /proc/mounts.=20=20
>
> It's definitely something that's more than just autofs and probably
> going to get worse, as you say.

If we assume that applications are going to want to read
/proc/self/mount* a log, we probably need to make it faster.
I performed a simple experiment where I mounted 1000 tmpfs filesystems,
copied /proc/self/mountinfo to /tmp/mountinfo, then
ran 4 for loops in parallel catting one of these files to /dev/null 1000 ti=
mes.
On a single CPU VM:
  For /tmp/mountinfo, each group of 1000 cats took about 3 seconds.
  For /proc/self/mountinfo, each group of 1000 cats took about 14 seconds.
On a 4 CPU VM
  /tmp/mountinfo: 1.5secs
  /proc/self/mountinfo: 3.5 secs

Using "perf record" it appears that most of the cost is repeated calls
to prepend_path, with a small contribution from the fact that each read
only returns 4K rather than the 128K that cat asks for.

If we could hang a cache off struct mnt_namespace and use it instead of
iterating the mount table - using rcu and ns->event to ensure currency -
we should be able to minimize the cost of this increased use of
/proc/self/mount*.

I suspect that the best approach would be implement a cache at the
seq_file level.

One possible problem might be if applications assume that a read will
always return a whole number of lines (it currently does).  To be
sure we remain safe, we would only be able to use the cache for
a read() syscall which reads the whole file.
How big do people see /proc/self/mount* getting?  What size reads
does 'strace' show the various programs using to read it?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAloeCqcACgkQOeye3VZi
gbm+cQ//YeZtxhSCSCa30cOZfo4liAh6+SRUrJspc3pFeXBFXUO9rsHDA4ZmOtwX
UD3hdyM9K6Zvu95LwQoEurxRC4QRswbYwwsuRtBRr8vZGK1RyJXpMvKy7ahDNE+f
blyhGVm/vAI8EdndvhFiw52bvbtWGENNwegTMR1MGt7xuCyiudnTf5yhP5iFVhMk
GfUtc2b1kOybj8+8nsE21JrELHb6cQDpzMxmdggaQESUh/H9fo4+xBsXAIcnkOT+
4rZ7F2l+LPg3m2QIRKQLuibJfpkBj3lzZjcz7Ncw85KNEBVa9WykCO/F1zUv08Mt
k4xLu6MbTHHbXv/bxsy6cZKleIzRadhF1AUBwVNy/4WINxzpumgybR4Vr0SUcGdg
Zz32Sbc8BsELh4eLduTEPerCsCkmRYdwQVYYxHqMRviOSFDfWORIBlSsx1+euyaR
JYoJYc1UWPnKO44jILMCVmAS4naS6N6zfbI2sZcoXcXYDjgMG/Ydw5SWkba/L5KD
ZjJApfBVQTYRqDXuWk7qZScfbAMxcCUvL/b0lss99K7j6kmMSMGTwwkqYzKGTwE3
4D/v6gvZO0a8/3oKg1TfwgCfUYvv2J0TdjlkevC/0q6lF4VaOLluFg3RVBjS4A8Y
EUn8RV/a5jh2xYaV9Zh4Wi/gPqiBd3lnyeVEZ1uZIbOiAt94UwA=
=ELQa
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
