From: "Marion, Mike" <mmarion@qualcomm.com>
Subject: Re: [PATCH] autofs: fix contained_in_local_fs and improve scalability
Date: Tue, 22 Mar 2016 01:24:46 +0000
Message-ID: <20160322012444.GE28078@qualcomm.com>
References: <56EC6897.7040409@suse.com> <56EC7267.6000103@suse.com>
 <1458531845.3042.36.camel@themaw.net> <56F070F6.7030802@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qualcomm.com; i=@qualcomm.com; q=dns/txt; s=qcdkim;
  t=1458609902; x=1490145902;
  h=from:to:subject:thread-topic:thread-index:date:
   message-id:references:in-reply-to:accept-language:
   content-language:x-ms-has-attach:x-ms-tnef-correlator:
   user-agent:x-operating-system:x-distribution:
   x-ms-exchange-messagesentrepresentingtype:
   x-ms-exchange-transport-fromentityheader:x-originating-ip:
   content-type:content-id:content-transfer-encoding:
   mime-version;
  bh=T940E8h0hPM8fAuGdBn/U6zZLxVmO9N8wHc7bsL3mCE=;
  b=rNCxLauS9yWDUT/jiSnsAe2VQM+ucnYOUTJnnQ/PEH4HqUXKrJxfzAIy
   umEcBd3idh4+hY2sJJASDDGNDFOPwiBTMzZCJ0kDcekLN6TKIbHEyzupg
   QITBizD81ABky4XspSuWthqqcqukWduolvl9+PARaJu+58f3gN6m27auJ
   M=;
In-Reply-To: <56F070F6.7030802@suse.com>
Content-Language: en-US
Content-ID: <DECC43AC5893AE408059A20064DF73DE@qualcomm.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, Mar 21, 2016 at 06:08:54PM -0400, Jeff Mahoney wrote:

> > I thought that was bad so this really needs to be fixed.
> > 
> > I am puzzled why I haven't seen other bug reports.
> 
> Yeah, I usually see all of the autofs bugs reported against our products
> and it's the first time I've seen it too.

Probably because enterprise customers tend to be behind the curve
already.  I know the engineers we support are even further behind
because the tools they're using are behind even where we'd like to be.
When the first moves to bring out "Enterprise Linux" distros started, the
big EDA ISVs we work with (Synopsys, Cadence, etc) thought the 18 month
time-frames being discussed then were too fast.  If you can believe it.

The SLE12 (and RH7.x) stuff is another special case though because our
internal CM systems needed to be updated to handle the big change that
systemd was, but still work on the older stuff as well.  We didn't get 
that to the point where we could test with our namespaces until SP1 
had come out.

We're the/a customer that raised this issue BTW.  We have pretty huge
direct maps that have been working fine for quite a few years, until the
/etc/mtab symlink.  Our large maps and heavy autofs usage has led us
into breaking it in many... "interesting" ways over the years that
helped the Suse guys get patches upstream that benefit everyone though,
so there's that.

-- 
Mike Marion-Unix SysAdmin/Sr. Staff IT Engineer-http://www.qualcomm.com
Homer: "Oh.. I hate having parties.  The toilet always gets backed up!"
==> Simpsons--
To unsubscribe from this list: send the line "unsubscribe autofs" in
