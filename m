From: Greg Earle <earle@isolar.DynDNS.ORG>
Subject: Re: "rmdir_path: lstat of <path> failed" issues, despite updated autofs RPM
Date: Mon, 9 Nov 2015 23:18:28 -0800
Message-ID: <146CD18A-8C87-4E7D-8FA8-262FAA9C1195@isolar.DynDNS.ORG>
References: <7D63CDFD-57AB-4BCA-AD12-138CBC44342D@isolar.DynDNS.ORG> <1446964411.2974.7.camel@themaw.net> <8C7EFEF6-C73F-43F2-AC63-5CB5ED2B806B@isolar.DynDNS.ORG> <1447026421.2990.11.camel@themaw.net> <80BF6988-2849-49A0-AEC5-4079AB9B8CFF@isolar.DynDNS.ORG> <1447134536.3010.21.camel@themaw.net>
Reply-To: autofs@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1447134536.3010.21.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: autofs@vger.kernel.org


> On Nov 9, 2015, at 9:48 PM, Ian Kent <raven@themaw.net> wrote:
> 
> If there are directories that are possibly broken in some way then to
> clear them up the autofs managed mount point must be umounted.
> 
> But if any mounts are busy at shutdown they are left mounted, and the
> autofs mount itself obviously must be left mounted too, then autofs re
> -connects to the mounts when it starts again.

That's interesting, never knew that before.  So maybe it thinks these
phantom mounts should still be "mounted", and keeps trying to do it.


> That complexity is the reason I usually just recommend a re-boot be
> scheduled, plus if there is some sort of brokenness within the mounted
> autofs file system there's no knowing if there were side effects when
> it happened.
> 
> Sorry, I'm not really much help with this.

Well, I've already told Xymon to ignore these (at my peril!), so as long
as they are just harmless messages, I'll live  :-)

Thanks for looking at the code just in case.  Was hoping it might be
something simple; obviously it wasn't.

	- Greg

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
