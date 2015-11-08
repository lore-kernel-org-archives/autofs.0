From: Ian Kent <raven@themaw.net>
Subject: Re: "rmdir_path: lstat of <path> failed" issues, despite updated
 autofs RPM
Date: Mon, 09 Nov 2015 07:47:01 +0800
Message-ID: <1447026421.2990.11.camel@themaw.net>
References: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG>
	 <1446964411.2974.7.camel@themaw.net>
	 <8C7EFEF6-C73F-43F2-AC63-5CB5ED2B806B@isolar.DynDNS.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=i9dc4ve9UQ4YzMdHrOOJjoP204k=; b=wOCRa9
	slSYRcN/NjQ0+PgBG5qg9yDeEwcPY0ue3bowqiYuWQM6jZi9isF/Joigw066643N
	K7ytBotKu68g0cuZqsL5ByPDl3DAXnQskYfIEVzy8p1pjqSNYUVIZEZD4gIe1aLd
	p9L+V+9d+8+2iDvyuragrlbc7l5rpCxAqqEvg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=i9dc4ve9UQ4YzMd
	HrOOJjoP204k=; b=O8WZc5cn3h+2B6TN6zrT3T+gD31PXN6j7vAsDTKWri8ttju
	bbl3zLkAr7jFxR9KRaSehJrMzdYZGVZV/lbalgAtxlWTzKxp/jgwYttoachdqenG
	J4Amjc+ijdvQWelbVe8UTNdZNI+0n1QXI4g0o92VB2NoyKaBDwLdFkObXUVg=
In-Reply-To: <8C7EFEF6-C73F-43F2-AC63-5CB5ED2B806B@isolar.DynDNS.ORG>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

On Sun, 2015-11-08 at 00:22 -0800, Greg Earle wrote:
> > On Nov 7, 2015, at 10:33 PM, Ian Kent <raven@themaw.net> wrote:
> > 
> > Do those directories actually exist within /home?
> 
> Thanks for responding, Ian.
> 
> "objects" exists (apparently due to tickling by the automounter) but
> "refs"
> does not:
> 
> [root@mipldiv log]# ls -ltF /home | head -2
> total 40
> dr-xr-xr-x  2 root   root        0 Nov  8 00:15 objects/
> 
> [root@mipldiv log]# ls -ltF /home/objects
> ls: /home/objects: No such file or directory
> 
> > Has the machine been up for a long time?
> 
> Ironically, they started happening shortly AFTER the machine was
> upgraded
> from RHEL 5.4 to 5.10 (with several reboots).  (It's been up for just
> over
> 4 days now, and it's still doing it every 15 or 30 minutes.)
> 
> [root@mipldiv log]# grep failed messages | grep -v bin/nrpe | tail -5
> Nov  7 22:00:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/refs failed
> Nov  7 22:15:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects failed
> Nov  7 23:00:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/refs failed
> Nov  7 23:30:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/refs failed
> Nov  8 00:00:06 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects failed
> 
> > Are they actually causing a problem, other than annoyance value?
> 
> Just an annoyance as far as I can tell - our Xymon monitoring system
> triggers on "failed" so we get red alerts from the system(s) whenever
> this happens.  My officemate isn't happy  :-)
> 
> > They could be left over from when they where keys in a map but not
> > removed on cleanup for some reason, or they could be the result of
> > a
> > failed or partial lookup and also not cleaned up on error.
> 
> The keys were never in a map.  That is what is so weird.  I went to
> our
> Solaris NIS master and there is no reference to "objects" or "refs"
> in
> /etc/auto_home or /etc/auto_*.  I can't imagine what could be running
> that is trying to access those two phantom "/home" paths.

Yeah, that function is called from a few places.

At map read time, at autofs fs mount time and on HUP signal or if a
lookup makes autofs think the map has been modified and at expire when
attempting to remove a path on failed mount attempts for some fs types,
notably NFS.

The read map is driven by what's in the internal map entry cache
so they could be negative entries added due to a failed lookup.

The problem might be that the function could get called multiple times
and fails on the later but that would imply bad path lookups occurring
fairly regularly.

Puzzling thing is I haven't had other reports of it.

> 
> > You could try scheduling a reboot at some opportune time as that
> > will
> > result in a clean autofs directory at system startup since the
> > autofs
> > pseudo file system is RAM based.  Then if the messages continue, it
> > must
> > be some process attempting access of a path starting with
> > /home/<dir>.
> 
> Well, given that the behavior really kicked in after the last post
> -install
> reboot, I'm guessing your latter explanation is far more likely.  :-)
> 
> I've just turned process accounting on to see what is running on
> those
> 15-minute intervals that might be triggering these.  Already checked
> the
> "cron" jobs and there aren't any on that frequency.  Most curious ...
> 
> 	- Greg
> 
> --
> To unsubscribe from this list: send the line "unsubscribe autofs" in
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
