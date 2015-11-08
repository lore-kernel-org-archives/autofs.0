From: Ian Kent <raven@themaw.net>
Subject: Re: "rmdir_path: lstat of <path> failed" issues, despite updated
 autofs RPM
Date: Sun, 08 Nov 2015 14:33:31 +0800
Message-ID: <1446964411.2974.7.camel@themaw.net>
References: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=s/e4GarBaLwJYyrNf8L8RLZuRCE=; b=qwnG+G
	BhV8ncgZKIVg2gNXIMGPg5uySOFMVAPUgvOqV25Fv2AN49wajhf6cAItjblf55wK
	t4IoI5iD80xsGaKteUOBu/IaZxDo6zaqqsdnNnbIDHiFdfZxBwCCDWexRkNCwTzO
	KX2ku3KblSDlv5M1GQHqUQ2Z0V1Gfxuzntk64=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=s/e4GarBaLwJYyr
	Nf8L8RLZuRCE=; b=o4KFoz92XwrTZTQWZQE6h1SBAnVpsFFuA/b5QadNgszyg3i
	j9ZZMxhVdn0/X+MlCAwd5/BCoN3vhGfGLe+R+S0W09WJkJyfutuajnmpghoafPEx
	xuQWPHxCWnIOdXr/PKk5nNSJ6pxU8hhCaAJqFiw/34MhKQKlay3T72aKKo4w=
In-Reply-To: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org

On Fri, 2015-11-06 at 13:03 -0800, Greg Earle wrote:
> Ian et al.:
> 
> We just upgraded a production server from RHEL 5.4 to 5.10.  (Yeah,
> yeah, I
> know - I work at a place that has things called "flight project
> freezes".)
> 
> Ever since then, we keep getting these mysterious autofs messages:
> 
> [root@mipldiv log]# grep rmdir_path messages | wc -l
> 100
> 
> [root@mipldiv log]# grep rmdir_path messages | tail -5
> Nov  6 08:30:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects failed
> Nov  6 09:30:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects failed
> Nov  6 11:30:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/refs failed
> Nov  6 11:45:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/objects failed
> Nov  6 12:30:05 mipldiv automount[31419]: rmdir_path: lstat of
> /home/refs failed
> 
> [root@mipldiv log]# ypcat -k auto.home | grep objects
> [root@mipldiv log]# ypcat -k auto.home | grep refs
> [root@mipldiv log]# 
> 
> (I have no idea where these "/home/objects" or "/home/refs" paths
> come from;
> we do not have any accounts with those names, obviously.)
> 
> We're running the latest RHEL 5.x autofs version as far as I can
> tell:
> 
> [root@mipldiv log]# rpm -qa autofs*
> autofs-5.0.1-0.rc2.184.el5
> 
> I have this problem on several machines; including - bizarrely enough
> -
> 3 machines on one flight project that get a rash of them all at
> exactly
> the same time (usually 8:45 PM).  Those systems are currently frozen
> but
> may also be upgraded to 5.10 soon.
> 
> Bug 336961 implies that this was addressed in an Errata (RHBA-2008
> -0354),
> but we are a full superseded Errata revision (RHBA-2014:1240-2)
> beyond that
> one already, and yet I'm still seeing these messages.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=336961
> 
> Given the age of RHEL 5.x am I better off trying to track down the
> cause
> of these phantom "/home" paths so the messages won't come out at all?
> Because I really don't have a clue where these "objects" & "refs"
> references
> are coming from.

Not really sure.
That is kinda old!

Do those directories actually exist within /home?
Has the machine been up for a long time?
Are they actually causing a problem, other than annoyance value?

They could be left over from when they where keys in a map but not
removed on cleanup for some reason or they could be the result of a
failed or partial lookup and also not cleaned up on error.

You could try scheduling a reboot at some opportune time as that will
result in a clean autofs directory at system startup since the autofs
pseudo file system is ram based. Then if the messages continue it must
be some process attempting access of a path starting with /home/<dir>.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
