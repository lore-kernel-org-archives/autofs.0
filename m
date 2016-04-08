From: Ian Kent <raven@themaw.net>
Subject: Re: mount -oaddr=<ipaddr> ?
Date: Fri, 08 Apr 2016 08:21:45 +0800
Message-ID: <1460074905.3135.19.camel@themaw.net>
References: <57030D04.7010805@suse.com>
	 <1459825949.4090.10.camel@themaw.net> <5703BB28.9000508@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=WH7ruh2tKmtZYmdXxI26UxqXktM=; b=vNNc+B
	O/eZecgfEB2M8sS0mlolQ/1A68RfbVXWinN6ntzIPUcaXD9ERu9cbsn5/+Wrrlcj
	GrXAoAr5LATI4Qzs904UokISbUrdGPDAkmvx38+AHQIWgTEgNq3umqBdT7eJ82WE
	iGWsDrc7Tt2RYxNylKDWWMFDGbl06Sgu9dZD0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=WH7ruh2tKmtZYmd
	XxI26UxqXktM=; b=oGq/h91YUc1rA5lmP4m4gJDxWIyOndNmf4bLduXM+1cx5qV
	CI+oseEBZVUSqDsqW96HJ1YcWUz0gtgB4fI//uv+beKalyYBGl3asRHSqn6WcuMw
	UxZuRo66qQVDj2IsIe6aZaPI6QRkVGvf5y40H9YXZsfZNTFRfy9Kfi+droRc=
In-Reply-To: <5703BB28.9000508@suse.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jeff Mahoney <jeffm@suse.com>, autofs@vger.kernel.org

On Tue, 2016-04-05 at 09:18 -0400, Jeff Mahoney wrote:
> On 4/4/16 11:12 PM, Ian Kent wrote:
> > On Mon, 2016-04-04 at 20:55 -0400, Jeff Mahoney wrote:
> > > Hi all -
> > > 
> > > I'm investigating an issue where our user updated from SLE11 to
> > > SLE12
> > > and the hostname for autofs mounts stopped appearing in the
> > > 'mount'
> > > output.  I know why this happens, what the reason for it being
> > > this
> > > way
> > > is, and that it can be overridden by setting the
> > > use_hostname_for_mounts=yes option (and the side effects).  Before
> > > I
> > > go
> > > and write up the patch implementing it, is there a reason why
> > > autofs
> > > doesn't pass the hostname in the mount source and specify the ip
> > > address
> > > using the -oaddr=<ipaddr> option?  Was this tried and found to be
> > > wanting somehow?
> > 
> > TBH I didn't even consider doing that.
> > 
> > But the daemon needs to be conservative in the options it uses
> > because
> > maps may be used with other platforms and unknown or non-standard
> > options can cause mount failures.
> > 
> > While Linux mount.nfs(8) has the sloppy option (which maintainers
> > seem
> > to try and remove from time to time) other platforms probably don't.
> > 
> > The addr=<address> option isn't listed as a valid option in nfs(5)
> > and
> > neither is it listed in on-line Solaris documentation that I could
> > find
> > so I'm not sure making the daemon use it is a good idea.
> > 
> > Maybe there's another way...
> > 
> > Note that I do need to be able to mount to a specific IP address
> > while
> > specifying the host name in the mount command but don't know of a
> > way todo it.
> 
> After looking at it again, the kernel supports doing this but nfs
> -utils
> explicitly doesn't.
> 
> A closer look at nfs-utils also shows that, given a hostname,
> mount.nfs
> will iterate over all available addresses matching the specification
> (e.g. constrained by proto=) and try to mount using each one.  It will
> properly pass an addr= field to the kernel but it ignores the one
> passed
> on the mount command line.  It will use getaddrinfo() to get the list
> of
> addresses for the remote host and then iterate over them, retrying
> until
> it finds one that works.  So that part of it works, but the
> prioritization implemented by the replicated modules isn't.  I wonder
> if
> it would make sense to move that to nfs-utils instead.  It seems like
> it
> would be generally useful.

I'm not sure that's a good idea.

The syntax that would need to be supported by nfs-utils for this is used
by OSes that provide read-only replicated mount fail over.

So, as soon as that was added people will assume the Linux kernel NFS
client has this fail over support which it hasn't.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
