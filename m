From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 16:51:05 +0000
Message-ID: <20171129165104.GE2873@qualcomm.com>
References: <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
 <20171128002935.GC27898@qualcomm.com>
 <87a7z5yjbs.fsf@notabene.neil.brown.name>
 <ae8e93be-8e3f-ffd8-9043-13737230d18d@themaw.net>
 <87lgipwxwo.fsf@notabene.neil.brown.name>
 <aeedaa64-5b1e-a6e7-29f0-576de17eabf4@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=@qualcomm.com; q=dns/txt; s=qcdkim;
  t=1511974268; x=1543510268;
  h=x-ironport-av:x-mga-submission:from:to:cc:subject:
   thread-topic:thread-index:date:message-id:references:
   in-reply-to:accept-language:content-language:
   x-ms-has-attach:x-ms-tnef-correlator:user-agent:
   x-operating-system:x-distribution:
   x-ms-exchange-messagesentrepresentingtype:
   x-ms-exchange-transport-fromentityheader:x-originating-ip:
   content-type:content-id:content-transfer-encoding:
   mime-version;
  bh=28kCWLbSh2xGhWq56MfrFXcAczuQ6dLgiRuFvtmuRGY=;
  b=TJTK3AQXZOFWFjBNuvxNBu/Psp5PxQoLZyMUFrxOqEmMwsYQuk4fl5Cw
   PlCxccAwCJd3SPXKZL0DMMO/lXQjbFZoHYaF3F2IsO8lfvP37JthnnWpC
   JTf05ls+GNaKlcL7ZKHUMFSOR3bGutybwqibf2CFKfJjSw61sZIsAYRmN
   k=;
In-Reply-To: <aeedaa64-5b1e-a6e7-29f0-576de17eabf4@themaw.net>
Content-Language: en-US
Content-ID: <6C28DB4ACCBACC47A1262904270ABEF4@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: NeilBrown <neilb@suse.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Wed, Nov 29, 2017 at 02:00:31PM +0800, Ian Kent wrote:
> On 29/11/17 11:45, NeilBrown wrote:
> > On Wed, Nov 29 2017, Ian Kent wrote:
> >=20
> >> Adding Al Viro to the Cc list as I believe Stephen Whitehouse and
> >> Al have discussed something similar, please feel free to chime in
> >> with your thoughts Al.
> >>
> >> On 29/11/17 09:17, NeilBrown wrote:
> >>> On Tue, Nov 28 2017, Mike Marion wrote:
> >>>
> >>>> On Tue, Nov 28, 2017 at 07:43:05AM +0800, Ian Kent wrote:
> >>>>
> >>>>> I think the situation is going to get worse before it gets better.
> >>>>>
> >>>>> On recent Fedora and kernel, with a large map and heavy mount activ=
ity
> >>>>> I see:
> >>>>>
> >>>>> systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
> >>>>> gnome-settings-daemon, packagekitd and gnome-shell
> >>>>>
> >>>>> all go crazy consuming large amounts of CPU.
> >>>>
> >>>> Yep.  I'm not even worried about the CPU usage as much (yet, I'm sur=
e=20
> >>>> it'll be more of a problem as time goes on).  We have pretty huge
> >>>> direct maps and our initial startup tests on a new host with the lin=
k vs
> >>>> file took >6 hours.  That's not a typo.  We worked with Suse enginee=
ring=20
> >>>> to come up with a fix, which should've been pushed here some time ag=
o.
> >>>>
> >>>> Then, there's shutdowns (and reboots). They also took a long time (o=
n
> >>>> the order of 20+min) because it would walk the entire /proc/mounts
> >>>> "unmounting" things.  Also fixed now.  That one had something to do =
in
> >>>> SMP code as if you used a single CPU/core, it didn't take long at al=
l.
> >>>>
> >>>> Just got a fix for the suse grub2-mkconfig script to fix their parsi=
ng=20
> >>>> looking for the root dev to skip over fstype autofs
> >>>> (probe_nfsroot_device function).
> >>>>
> >>>>> The symlink change was probably the start, now a number of applicat=
ions
> >>>>> now got directly to the proc file system for this information.
> >>>>>
> >>>>> For large mount tables and many processes accessing the mount table
> >>>>> (probably reading the whole thing, either periodically or on change
> >>>>> notification) the current system does not scale well at all.
> >>>>
> >>>> We use Clearcase in some instances as well, and that's yet another t=
hing
> >>>> adding mounts, and its startup is very slow, due to the size of
> >>>> /proc/mounts. =20
> >>>>
> >>>> It's definitely something that's more than just autofs and probably
> >>>> going to get worse, as you say.
> >>>
> >>> If we assume that applications are going to want to read
> >>> /proc/self/mount* a log, we probably need to make it faster.
> >>> I performed a simple experiment where I mounted 1000 tmpfs filesystem=
s,
> >>> copied /proc/self/mountinfo to /tmp/mountinfo, then
> >>> ran 4 for loops in parallel catting one of these files to /dev/null 1=
000 times.
> >>> On a single CPU VM:
> >>>   For /tmp/mountinfo, each group of 1000 cats took about 3 seconds.
> >>>   For /proc/self/mountinfo, each group of 1000 cats took about 14 sec=
onds.
> >>> On a 4 CPU VM
> >>>   /tmp/mountinfo: 1.5secs
> >>>   /proc/self/mountinfo: 3.5 secs
> >>>
> >>> Using "perf record" it appears that most of the cost is repeated call=
s
> >>> to prepend_path, with a small contribution from the fact that each re=
ad
> >>> only returns 4K rather than the 128K that cat asks for.
> >>>
> >>> If we could hang a cache off struct mnt_namespace and use it instead =
of
> >>> iterating the mount table - using rcu and ns->event to ensure currenc=
y -
> >>> we should be able to minimize the cost of this increased use of
> >>> /proc/self/mount*.
> >>>
> >>> I suspect that the best approach would be implement a cache at the
> >>> seq_file level.
> >>>
> >>> One possible problem might be if applications assume that a read will
> >>> always return a whole number of lines (it currently does).  To be
> >>> sure we remain safe, we would only be able to use the cache for
> >>> a read() syscall which reads the whole file.
> >>> How big do people see /proc/self/mount* getting?  What size reads
> >>> does 'strace' show the various programs using to read it?
> >>
> >> Buffer size almost always has a significant impact on IO so that's
> >> likely a big factor but the other aspect of this is notification
> >> of changes.
> >>
> >> The risk is improving the IO efficiency might just allow a higher
> >> rate of processing of change notifications and similar symptoms
> >> to what we have now.
> >=20
> > That's an issue that we should be able to get empirical data on.
> > Are these systems that demonstrate problems actually showing a high
> > rate of changes to the mount table, or is the mount table being
> > read frequently despite not changing?
> > To find out you could use a program like one of the answers to:
> >=20
> > https://stackoverflow.com/questions/5070801/monitoring-mount-point-chan=
ges-via-proc-mounts
> >=20
> > or instrument the kernel to add a counter to 'struct mnt_namespace' and
> > have mounts_open_common() increment that counter and report the value a=
s
> > well as ns->event.  The long term ratio of the two numbers might be
> > interesting.
>=20
> One scenario is, under heavy mount activity, the CPU usage of processes
> systemd, udisksd2, gvfs-udisks2-volume-monitor, gvfsd-trash,
> gnome-settings-daemon and packagekitd (and possibly gnome-shell, might
> be a false positive though) grow to consume all available CPU.
>=20
> The processes gvfs-udisks2-volume-monitor and gnome-settings-daemon=20
> (and possibly packagekitd, might be false positive) continue to use
> excessive CPU when the mount table is large but there is no mount/umount
> activity.
>=20
> In this case heavy mount activity means starting autofs with a direct
> mount map of 15k+ entries.
>=20
> The shutdown can be a problem too but umount(2) is just too slow for it
> to be as pronounced a problem as what we see at startup. The umount
> slowness appears to be constant. I'm not sure if it's proportional in any
> way to the number of mounts present on the system.

BTW, the previously mentioned fix we got from suse is (I'm pretty sure)
this one:
http://kernel.suse.com/cgit/kernel-source/commit/?id=3D10c43659465b18bd337f=
4434f41e133d09e08b13
Which simply changes a synchronize_rcu(); call to synchronize_rcu_expedited=
();

I do believe that they found it both proportional to the number of
mounts as well as something that only slowed down shutdown noticeably on
SMP hosts.  That SMP bit was only stumbled upon when their initial
testing was on a single cpu VM, since that's about the only time anyone
runs with only 1 CPU these days.

> >>
> >> The suggestion is that a system that allows for incremental (diff
> >> type) update notification is needed to allow mount table propagation
> >> to scale well.
> >>
> >> That implies some as yet undefined user <-> kernel communication
> >> protocol.
> >=20
> > I can almost conceive a mountinfo variant where new entries always
> > appear at the end and deletions appear as just "$mnt_id".
> > struct proc_mounts would contain a bitmap similar to mnt_id_ida which
> > records which ids have been reported to this file.  When an event is
> > noticed it checks for deletions and reports them before anything else.
> > Keeping track of location in the ns->list list might be tricky.  It
> > could be done with a new 64bit never-reused mnt id, though some other
> > approach might be possible.
> >=20
> > An app would read to the end, then poll/select for exceptional events
> > and keep reading.
>=20
> Keeping track of modifications is certainly one of the problems and this
> sounds like a good start to resolving it ....
>=20
> I believe the current preferred delivery of this to be a shared library
> interface available to user space that talks to the kernel to obtain the
> needed information.
>=20
> Ian

--=20
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com=
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
