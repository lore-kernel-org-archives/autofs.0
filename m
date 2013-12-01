From: Ian Kent <raven@themaw.net>
Subject: Re: expire after kill -HUP ?
Date: Sun, 1 Dec 2013 15:21:21 +0800
Message-ID: <7B07798B-AB21-4FD2-AE32-B280A8DAE045@themaw.net>
References: <5299B9CF.8030808@molgen.mpg.de>
Mime-Version: 1.0 (1.0)
Content-Transfer-Encoding: 8BIT
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	references:mime-version:in-reply-to:content-type
	:content-transfer-encoding:message-id:cc:from:subject:date:to;
	 s=mesmtp; bh=tW3xBybmpWLG0Ih0XqgUrbkwHxs=; b=D6thZSgHTRWYXGMH7u
	JLgYrWpCuOcXpxLV34dNuBZfcNj+J3NaDH7mTPPLfeMvmjdooSr0yC19YYDof7kN
	/EKL5/0j0vgJ9NqrbP491vIXlhnRUJRsWxVbM5HuM+XwqGxhiHZfl7Q6f7XCKWpn
	fueC312BMFVzSHPyYo0XgtXrk=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=references:mime-version:in-reply-to
	:content-type:content-transfer-encoding:message-id:cc:from
	:subject:date:to; s=smtpout; bh=tW3xBybmpWLG0Ih0XqgUrbkwHxs=; b=
	Wo2KDlhTShxeQfyi9WtaXzEI+GowBNpOf0JzUGL/cjhJKsOSG7PF3DsJBKUqwiZD
	iTtAaNXRUpno88Witnr+l4FpZmWx79Z7CmZ8jG57daCiU5Ya1N3gg4lKHFD2jAxW
	HyzZmm2ZDS1mWBVpIqTFIsMIOZolnY93WB4xaiyslmE=
In-Reply-To: <5299B9CF.8030808@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>



> On 30 Nov 2013, at 6:11 pm, Donald Buczek <buczek@molgen.mpg.de> wrote:
> 
> Hello,
> 
> autofs-5.0.8
> kernel 3.8.2
> 
> I've noticed, that in our installation mounts stop expiring after we send the daemon a SIGHUP to notify it about map updates.

I don't see that here.

> Debug log from the daemon seems to confirm that, the regular "st_expire: state 1 path... " messages no longer appear after the HUP is received and processed ("re-reading master map"...).
> 

There have been a couple of changes in that area, I'll have a look around.
Can you give a bit more detail about the problem like:
does it happen the very first time every time.
are there specific changes that trigger the behaviour.
does it happen if no changes are actually made.
what sort of activity is happening when the problem occurs.

and a look at the log would probably be useful.


> Maybe the signal goes to the st_queue_handler task?

The signal goes to the main thread and the thread is responsible for adding tasks to the task queue as needed.

That's pretty much only for readmap and program exit, but alarms (which trigger the expire runs) are cleared and set at various places, mostly at the start and end of expire run.

> 
> Regards
>   Donald Buczek
> 
> -- 
> Donald Buczek
> buczek@molgen.mpg.de
> Tel: +49 30 8413 1433
> 
> 
> 
