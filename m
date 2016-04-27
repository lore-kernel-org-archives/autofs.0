From: Christof Koehler <christof.koehler@bccms.uni-bremen.de>
Subject: Re: autofs reverts to IPv4 for multi-homed IPv6 server ?
Date: Wed, 27 Apr 2016 18:52:50 +0200
Message-ID: <20160427165250.GM30271@bccms.uni-bremen.de>
References: <20160408122552.GW15153@bccms.uni-bremen.de>
 <20160408142907.GX15153@bccms.uni-bremen.de>
 <1460166126.3073.20.camel@themaw.net>
 <20160409095659.GB15153@bccms.uni-bremen.de>
 <1461559248.3012.24.camel@themaw.net>
 <20160425150638.GC30271@bccms.uni-bremen.de>
 <1461632818.3218.29.camel@themaw.net>
 <1461664433.3218.42.camel@themaw.net>
 <20160426152711.GF30271@bccms.uni-bremen.de>
 <1461722078.4208.31.camel@themaw.net>
Reply-To: christof.koehler@bccms.uni-bremen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NKtYx2Ppz7d1tORf"
Content-Transfer-Encoding: 8bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=bccms.uni-bremen.de;
	s=dkim; t=1461775972;
	bh=Dei1aXLG5TI8/Axd3mO0Jd6F7Td5GoYTTsE5alAjdfU=;
	h=Date:From:To:Cc:Reply-To:References:In-Reply-To;
	b=Lb8//Cw6gVuGg6L9ZH3tTGw2Fgsn50z3ZnQ2yXfe4PmVMx0BbB0BtOe7eesnrHeo9
	 UU0pLX2DubdJojZI5/sqVYJut2tfb8Pv21LP2iLJr8lQKAQ+78DPuNx1UMjabwNt1E
	 53vI+VD7TaEgxW11A2nsSRiBptHBSubGMUeKVdKo=
Content-Disposition: inline
In-Reply-To: <1461722078.4208.31.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org


--NKtYx2Ppz7d1tORf
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I have the system running and did first tests. This was 
interesting although I observed basically the behaviour you were 
expecting.

From what I see without libtirpc (standard package), autofs is as
expected oblivious to IPv6. It passes the servers hostname to mount, which 
in the case of IPv4 and a single IPv6 address in the end uses the IPv6 one. 
In the case of two IPv6 addresses it falls back to IPv4 for some reason. So 
that is unrelated to autofs then (and I should ask somewhere else) ? I 
attached two syslog ouputs (debug level) covering the single IPv6 
(single_log_wo_tirpc.txt.gz) and double IPv6 (multi_log_wo_tirpc.txt.gz) cases.

I note, though, that mount on its own (mount -tnfs4 core330:/locals ...)
always picks one of the IPv6 addresses and never the IPv4 address if
both IPv6 addresses are in the DNS. So there is some difference to the
behaviour when called from autofs. Do you have an idea what that might
be or what I can do to find that out ?

I rebuilt the stock package "--with-libtirpc" (after removing the
problematic #ifdef block from rpc_subs.c) against the systems libtirpc
0.2.5. Then I tested again the two cases mentioned above, log output is
attached as single_log_tirpc.txt.gz and multi_log_tirpc.txt.gz.

In the "single" case the IPv6 address is always used as far as I could see
(about 10 tries, fewer in log). The response time is apparently not used
e.g. (see single_log_tirpc.txt.gz)
Apr 27 16:23:33 core400 automount[2473]: get_nfs_info: nfs v4 rpc ping
time: 0.000115
Apr 27 16:23:33 core400 automount[2473]: get_nfs_info: nfs v4 rpc ping
time: 0.000153
results in
Apr 27 16:23:33 core400 automount[2473]: mount_mount: mount(nfs):
calling mount -t nfs4 -s -o rw,intr,nosuid,soft,nodev core330:/locals /local/core330
which then apparently decides to use the IPv6 address in its own.

In the double IPv6 address case I see that all available addresses 
(IPv4 192.168.220.118, IPv6 GUA 2001:...:118 and IPv6 ULA fd5f:...:118) are used 
to mount and that actual IP addresses are passed to mount instead of a 
hostname (see single example above for the opposite behaviour). The
choice of address is a direct result of the response time as you mentioned. 

It is unclear to me how it decides if an IP address or an
hostname should be passed to mount, might this be multi-homed or
failover behaviour ? But then even with IPv4 and a single IPv6 address the host
sould be considered multi-homed for that purpose and not only if it has
multiple IPv6 addresses ?

Or is it working as designed ?

Now some opinions before some package rebuild and technical questions:

On Wed, Apr 27, 2016 at 09:54:38AM +0800, Ian Kent wrote:
> 
> Then there's the question of order of addresses to try.
> Should IPv6 addresses be higher priority than IPv4?

I now see and understand the question. The behaviour of mount (stand
alone or called from autofs) is puzzling in this context. Stand alone
mount does IMHO the right thing:

I always assumed that there was an agreed preference, e.g. observing 
for http/ssh connections that IPv6 in fact is preferred before
eventually falling back to IPv4 (perhaps after a timeout).

RFC 6724's Abstract says: 
"In dual-stack implementations, the destination address
selection algorithm can consider both IPv4 and IPv6 addresses --
depending on the available source addresses, the algorithm might
prefer IPv6 addresses over IPv4 addresses, or vice versa."

and in Section 10.3.
"The default policy table gives IPv6 addresses higher precedence than
IPv4 addresses.  This means that applications will use IPv6 in
preference to IPv4 when the two are equally suitable."

This is what /etc/gai.conf (source selection) and "ip addrlabel"
defaults (destination selection) are based on. But may be I am
overinterpreting the RFC considering its Abstract.

As far as I read earlier this preference caused/can cause a great deal of 
pain sometimes.


> 
> Should I even use IPv4 addresses when IPv6 addresses are present and
> fall back to IPv4 if all IPv6 addresses fail?
Fallback after failure might be reasonable. But I agree that there will be
opinions and my use case is not a general or really complicated one, so
I will abstain.

> 
> If there is more than one distinct host and a host with only an IPv4
> address is "closer" (that's the proximity question and also response
> time) than another host with only an IPv6 address, what selection policy
> should I use?
Yes, I see the point. This is obviously out of the RFC's scope.

One could argue for a configuration file or compile time option(s) to
influence address selection, but you know pros and cons of that and I do
not. Especially considering that (some) distros are not even using libtirpc
to begin with.


Now the package rebuild questions:
You built libtirpc 1.0.1 from the sourceforge source, put include and
library files in the system locations by hand and then recompiled the
autofs package against these ? Or is there a neat trick to avoid messing
in the system locations by hand ? 
I am unsure how to reproduce what you did.

Another question: What is your expectation in a situation where only
IPv6 is available, no IPv4 for the server ? Is  the one mentioned in #25 of
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=737679
expected to be still a working solution ? I might have an NFS server soon
which, due to a routing conflict difficult to resolve, would only get
an IPv6 address visible to the clients. I should test this case with a 
dedicated vm as server anyway ...

> 
> And setting up a IPv6 test environment is difficult so having someone
> that needs this is useful.
> Thanks fr doing this.
> 

I am glad to be able to help with testing. And of course thank You for taking
the time to help me !


Best Regards

Christof



-- 
Dr. rer. nat. Christof Köhler       email: c.koehler@bccms.uni-bremen.de
Universitaet Bremen/ BCCMS          phone:  +49-(0)421-218-62334
Am Fallturm 1/ TAB/ Raum 3.12       fax: +49-(0)421-218-62770
28359 Bremen  

PGP: http://www.bccms.uni-bremen.de/cms/people/c_koehler/

--NKtYx2Ppz7d1tORf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="multi_log_wo_tirpc.txt.gz"
Content-Transfer-Encoding: base64

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
e4bmBmqvjpTerh0ZrdfF/R9ROwHkVVMAAA==

--NKtYx2Ppz7d1tORf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="multi_log_tirpc.txt.gz"
Content-Transfer-Encoding: base64

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

--NKtYx2Ppz7d1tORf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="single_log_wo_tirpc.txt.gz"
Content-Transfer-Encoding: base64

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

--NKtYx2Ppz7d1tORf
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="single_log_tirpc.txt.gz"
Content-Transfer-Encoding: base64

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
Wm+P/D+yI0YdfngAAA==

--NKtYx2Ppz7d1tORf--
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
