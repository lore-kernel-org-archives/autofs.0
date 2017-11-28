From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Tue, 28 Nov 2017 00:29:36 +0000
Message-ID: <20171128002935.GC27898@qualcomm.com>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=@qualcomm.com; q=dns/txt; s=qcdkim;
  t=1511828978; x=1543364978;
  h=x-ironport-av:x-mga-submission:from:to:cc:subject:
   thread-topic:thread-index:date:message-id:references:
   in-reply-to:accept-language:content-language:
   x-ms-has-attach:x-ms-tnef-correlator:user-agent:
   x-operating-system:x-distribution:
   x-ms-exchange-messagesentrepresentingtype:
   x-ms-exchange-transport-fromentityheader:x-originating-ip:
   content-type:content-id:content-transfer-encoding:
   mime-version;
  bh=bZUTzfOLRz6L55BA6k4YVxfcoI40h6GwWs1ET/THiVw=;
  b=eJ14zaxbVpCt/+S11c7GdVcGA1jfPPgv5S/mIJ1hTatLk8jBIsVH1HGe
   nly2y/Fv96CHj7qxP0BvhVKu6Qwv+9uz5PUhFNa/ECqzHdi829PPFn7mp
   FOVy4QMPV55dkhZiund0KJd8BSEffl2QFr3ZnEyQDkQ3LiVZcksHln/Hk
   4=;
In-Reply-To: <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
Content-Language: en-US
Content-ID: <1C7D71A7E0525E42814BFB0714CBEA55@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Tue, Nov 28, 2017 at 07:43:05AM +0800, Ian Kent wrote:

> I think the situation is going to get worse before it gets better.
>=20
> On recent Fedora and kernel, with a large map and heavy mount activity
> I see:
>=20
> systemd, udisksd, gvfs-udisks2-volume-monitor, gvfsd-trash,
> gnome-settings-daemon, packagekitd and gnome-shell
>=20
> all go crazy consuming large amounts of CPU.

Yep.  I'm not even worried about the CPU usage as much (yet, I'm sure=20
it'll be more of a problem as time goes on).  We have pretty huge
direct maps and our initial startup tests on a new host with the link vs
file took >6 hours.  That's not a typo.  We worked with Suse engineering=20
to come up with a fix, which should've been pushed here some time ago.

Then, there's shutdowns (and reboots). They also took a long time (on
the order of 20+min) because it would walk the entire /proc/mounts
"unmounting" things.  Also fixed now.  That one had something to do in
SMP code as if you used a single CPU/core, it didn't take long at all.

Just got a fix for the suse grub2-mkconfig script to fix their parsing=20
looking for the root dev to skip over fstype autofs
(probe_nfsroot_device function).

> The symlink change was probably the start, now a number of applications
> now got directly to the proc file system for this information.
>=20
> For large mount tables and many processes accessing the mount table
> (probably reading the whole thing, either periodically or on change
> notification) the current system does not scale well at all.

We use Clearcase in some instances as well, and that's yet another thing
adding mounts, and its startup is very slow, due to the size of
/proc/mounts. =20

It's definitely something that's more than just autofs and probably
going to get worse, as you say.

--=20
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com=
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
