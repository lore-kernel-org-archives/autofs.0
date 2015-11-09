From: Greg Earle <earle@isolar.DynDNS.ORG>
Subject: Re: "rmdir_path: lstat of <path> failed" issues, despite updated autofs RPM
Date: Mon, 9 Nov 2015 12:42:58 -0800
Message-ID: <80BF6988-2849-49A0-AEC5-4079AB9B8CFF@isolar.DynDNS.ORG>
References: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG> <1446964411.2974.7.camel@themaw.net> <8C7EFEF6-C73F-43F2-AC63-5CB5ED2B806B@isolar.DynDNS.ORG> <1447026421.2990.11.camel@themaw.net>
Reply-To: autofs@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1447026421.2990.11.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org


> On Nov 8, 2015, at 3:47 PM, Ian Kent <raven@themaw.net> wrote:
> 
>> The keys were never in a map.  That is what is so weird.  I went to
>> our
>> Solaris NIS master and there is no reference to "objects" or "refs"
>> in
>> /etc/auto_home or /etc/auto_*.  I can't imagine what could be running
>> that is trying to access those two phantom "/home" paths.
> 
> Yeah, that function is called from a few places.
> 
> At map read time, at autofs fs mount time and on HUP signal or if a
> lookup makes autofs think the map has been modified and at expire when
> attempting to remove a path on failed mount attempts for some fs types,
> notably NFS.

I checked and of course it was still doing it:

Nov  9 12:30:05 mipldiv automount[31419]: rmdir_path: lstat of /home/objects \
failed

So I SIGHUP'ed the daemon and immediately got another one:

Nov  9 12:35:36 mipldiv automount[31419]: rmdir_path: lstat of /home/objects \
failed

I can't stop & restart the autofs service because it's a production server
for a flight project.

Seems like there's some sort of saved state that it reloads when HUP'ed,
that brings this message out?

	- Greg

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
