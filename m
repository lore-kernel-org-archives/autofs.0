From: Ian Kent <raven@themaw.net>
Subject: Re: mount -oaddr=<ipaddr> ?
Date: Tue, 05 Apr 2016 11:12:29 +0800
Message-ID: <1459825949.4090.10.camel@themaw.net>
References: <57030D04.7010805@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=MCkc3zpntCjbTfjMf/GYFmVxGJg=; b=GJq0Ss
	vgR/P/N1tDX6Sm0oxMkYYvUhtqG1gv1x1DdJtje/KEdsqYZ8aStiMIy+A44yhRZ4
	CN8ED/EdU5GLnPhqLMz/BRNc+XloXv0KrYGuiHT3IdZPjDan3ACC30Qd0DPhOboq
	aGeVCn6DhaCu7PrCyer4C8TX8iDlEBh/3T7OI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MCkc3zpntCjbTfj
	Mf/GYFmVxGJg=; b=QaVglHuto4TUGfuDv0kt1o7eZcpYRXgbjxaeQNCdyEtAE4/
	WQsr7MAAQlcrdX7uwc02tGNxxvyaPBngTbxl84oHKITGKYPpwcmgkySn6Of1e79H
	yKgvvtVAeky+Wss4YpgYqItbUZg3Vt3GodYONtxSE2Q8eeQb/oYYBXA28kfU=
In-Reply-To: <57030D04.7010805@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Mon, 2016-04-04 at 20:55 -0400, Jeff Mahoney wrote:
> Hi all -
> 
> I'm investigating an issue where our user updated from SLE11 to SLE12
> and the hostname for autofs mounts stopped appearing in the 'mount'
> output.  I know why this happens, what the reason for it being this
> way
> is, and that it can be overridden by setting the
> use_hostname_for_mounts=yes option (and the side effects).  Before I
> go
> and write up the patch implementing it, is there a reason why autofs
> doesn't pass the hostname in the mount source and specify the ip
> address
> using the -oaddr=<ipaddr> option?  Was this tried and found to be
> wanting somehow?

TBH I didn't even consider doing that.

But the daemon needs to be conservative in the options it uses because
maps may be used with other platforms and unknown or non-standard
options can cause mount failures.

While Linux mount.nfs(8) has the sloppy option (which maintainers seem
to try and remove from time to time) other platforms probably don't.

The addr=<address> option isn't listed as a valid option in nfs(5) and
neither is it listed in on-line Solaris documentation that I could find
so I'm not sure making the daemon use it is a good idea.

Maybe there's another way...

Note that I do need to be able to mount to a specific IP address while
specifying the host name in the mount command but don't know of a way todo it.

> 
> Thanks,
> 
> -Jeff
> 
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
