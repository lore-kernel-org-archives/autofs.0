From: "Marion, Mike" <mmarion@qualcomm.com>
Subject: Re: documentation issues
Date: Wed, 13 Jul 2016 02:17:42 +0000
Message-ID: <20160713021741.GJ18749@qualcomm.com>
References: <cec586e96030cbbc150886909bf34a45@dds.nl>
 <1467766653.4580.46.camel@themaw.net>
 <120efa5371880caa1f603fb7a4cded84@dds.nl>
 <1467809314.4580.172.camel@themaw.net>
 <9c9a4677493eb868dc68f02d8e5b10c7@dds.nl>
 <1468246190.3102.121.camel@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=@qualcomm.com; q=dns/txt; s=qcdkim;
  t=1468376285; x=1499912285;
  h=from:to:cc:subject:thread-topic:thread-index:date:
   message-id:references:in-reply-to:accept-language:
   content-language:x-ms-has-attach:x-ms-tnef-correlator:
   user-agent:x-operating-system:x-distribution:
   x-ms-exchange-messagesentrepresentingtype:
   x-ms-exchange-transport-fromentityheader:x-originating-ip:
   content-type:content-id:content-transfer-encoding:
   mime-version;
  bh=YU6VwaIteJyi8mW9WWbN0P6CwZ0xwWuxxUZbTYmkzAE=;
  b=cdvUmvBOQYTM66jgEQtCphyLGFq3OZNzJpk4LR0LJMsxKCG5L64rgoPa
   HSGxFj+2f6O4L6gIvp4GlUDCQgqiUQpoA9nAZ6CY0ONRAbsmvXeFVEmIe
   C24irT73Jjfco4fJNVX9uNQv30gj6r1IKBzLj6CZif5/uklmxhp8K9GPR
   M=;
In-Reply-To: <1468246190.3102.121.camel@themaw.net>
Content-Language: en-US
Content-ID: <D89853DEB551944199835F9B7988155C@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Autofs <autofs@vger.kernel.org>

On Mon, Jul 11, 2016 at 10:09:50PM +0800, Ian Kent wrote:

> What is needed is a re-write of the user space <-> kernel space communication
> essentially to add readdir functionality.
> 
> So that listing a directory would show the possible map mount points without the
> need to create the mount point directories.

Oh my god.. we need this!  

We have huge direct maps here and with the changing of /etc/mtab to a
link to /proc/self/mounts things have gotten horrible.  We've worked
with suse to help speed up the start of autofs (it was taking 6+ hours
to simply start the first time due to how automount reads the mtab file,
stats paths, does the mkdir, etc).  But things like mkinitrd running
with our huge maps loaded can take 20-30 min due to all the parsing
different steps do for various filesystem checks. I've learned to stop
automount and do a full umount -t autofs -a before running something
like a zypper update with a kernel upgrade.

-- 
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com
Brian: "So enlighten us, what's your idea of the perfect man?"
Helen: "Oh, I don't know...  Solid, sensitive and dependable, but with a sense of 
whimsy, a love of music and children.  A sense of commitment but a respect for my 
independence; adventurous yet a homebody... I really hadn't thought about it that 
much."  Joe: "Sounds great Helen, but Kermit is a frog."  => Wings--
To unsubscribe from this list: send the line "unsubscribe autofs" in
