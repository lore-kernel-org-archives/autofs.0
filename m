From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: [PATCH 3/3] autofs - fix AT_NO_AUTOMOUNT not being honored
Date: Wed, 29 Nov 2017 02:13:55 +0000
Message-ID: <20171129021354.GB2873@qualcomm.com>
References: <149438991819.26550.11290804420751932707.stgit@pluto.themaw.net>
 <149438992850.26550.14370272866390445786.stgit@pluto.themaw.net>
 <874lpo2y9e.fsf@notabene.neil.brown.name>
 <ed908288-536c-d34a-6d3d-c21bb8fdfc62@themaw.net>
 <864efc64-c430-a862-3e98-fe5ce2535329@themaw.net>
 <20171127160147.GA27613@qualcomm.com>
 <fe35e57a-df04-3e77-a717-48483c01701a@themaw.net>
 <20171128002935.GC27898@qualcomm.com>
 <87a7z5yjbs.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=@qualcomm.com; q=dns/txt; s=qcdkim;
  t=1511921637; x=1543457637;
  h=x-ironport-av:x-mga-submission:from:to:cc:subject:
   thread-topic:thread-index:date:message-id:references:
   in-reply-to:accept-language:content-language:
   x-ms-has-attach:x-ms-tnef-correlator:user-agent:
   x-operating-system:x-distribution:
   x-ms-exchange-messagesentrepresentingtype:
   x-ms-exchange-transport-fromentityheader:x-originating-ip:
   content-type:content-id:content-transfer-encoding:
   mime-version;
  bh=uSrDbdOPJVsZK5/PV1Urbg3gGTXAcvUuMwvmwhlqP+s=;
  b=FC+pLbNnkiXr5zMWLd9aS5oqmPY7gOrt6kUebY4NTl8i4hd7mEuZn2yK
   U8XMnn+rrAdkSasiErTgHpB2mDUQm83RbPlYAm+fXxXo/y7UHDS0DzHfj
   9J6EsMCYJIoonCLYP7WieSvENnu6kBNqf0ZLFjJP7BcrbtCSt4yRbq5Ge
   Y=;
In-Reply-To: <87a7z5yjbs.fsf@notabene.neil.brown.name>
Content-Language: en-US
Content-ID: <BCB59843BAABE54F8AAB35434B973306@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: NeilBrown <neilb@suse.com>
Cc: Ian Kent <raven@themaw.net>, autofs mailing list <autofs@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Wed, Nov 29, 2017 at 12:17:27PM +1100, NeilBrown wrote:

> How big do people see /proc/self/mount* getting?  What size reads
> does 'strace' show the various programs using to read it?

We already have line counts into 5 figures.  This wasn't an issue until=20
the change of /etc/mtab to a link.  The large count is due to our large
direct automount maps.

--=20
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com=
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
