From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Mon, 27 Nov 2017 16:01:53 +0000
Message-ID: <20171127160147.GA27613@qualcomm.com>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=@qualcomm.com; q=dns/txt; s=qcdkim;
  t=1511798515; x=1543334515;
  h=x-ironport-av:x-mga-submission:from:to:cc:subject:
   thread-topic:thread-index:date:message-id:references:
   in-reply-to:accept-language:content-language:
   x-ms-has-attach:x-ms-tnef-correlator:user-agent:
   x-operating-system:x-distribution:
   x-ms-exchange-messagesentrepresentingtype:
   x-ms-exchange-transport-fromentityheader:x-originating-ip:
   content-type:content-id:content-transfer-encoding:
   mime-version;
  bh=iUcT2Mqf2BfyttiT3D/IQh9/N043d62q3OMKHNMOi7M=;
  b=geCO2Yb71QQf2Vu6zvQbng1d+7R78RzJ98OUXUkQMaoNaWtEdWJGMt/o
   xM/IE9KIhLsL8GD/kgswOYppEVN+Pb+4QDUjRU4uE1AwFmmyBHxJXYrlF
   Q2szyJmy9bdMFUypMImv2PuwEGAChLMg9t1LCIbeRbfDTfEXHU1nqxjwl
   w=;
In-Reply-To: <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
Content-Language: en-US
Content-ID: <8EAD71283B752143ACC919036A8947F6@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: NeilBrown <neilb@suse.com>, Al Viro <viro@ZenIV.linux.org.uk>, Colin Walters <walters@redhat.com>, Ondrej Holy <oholy@redhat.com>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Thu, Nov 23, 2017 at 08:36:49AM +0800, Ian Kent wrote:

> And with the move of userspace to use /proc based mount tables (one
> example being the symlink of /etc/mtab into /proc) even modest sized
> direct mount maps will be a problem with every entry getting mounted.
>=20
> Systems will cope with this fine but larger systems not so much.

Yes.. we've run into some big issues due to the change of /etc/mtab from
a file to a symlink to /proc/self/mounts.  Most have been worked around
thus far (mostly due to Suse coming up with patches) but still have a
few annoying ones.

--=20
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com=
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
