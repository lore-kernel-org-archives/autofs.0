From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 18:38:31 +0800
Message-ID: <1442227111.3030.75.camel@themaw.net>
References: <55F58085.4090509@excellency.fr>
	  <1442197882.3030.33.camel@themaw.net> <55F68878.40803@excellency.fr>
	 <1442223945.3030.64.camel@themaw.net> <55F69DA2.7060204@excellency.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=utzkBOK9liL6alQ9hilzYj6CYNs=; b=kOcKW7
	T44tKzSvF9VJg+3b/U19HuFIYiN7C9W45o9g3+4MZVkkK1X/bAh4uyNL4yIajxKl
	dYAvRzQgQxvdStiR0OifClb6RiQEq6aY/WXpwGF5DpnoxbaQkWP7WZ4g5934ih+d
	CclLs/aWWMrb6EolinUidL59OJZTiLvKCEyN0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=utzkBOK9liL6alQ
	9hilzYj6CYNs=; b=gt0NxH/3IIGH4GKSnQKeiFJPwDRRGIeDF8sdhzwMNSPkWHa
	3HgfhrLjTa1yOsWggkuj8HnXLUDNpm8mNIL8fS9MpLEiEe4VmaKuCyAeW2NGzGa4
	y6vWQbe3fpk+TjC9R6/MmWZ8rH6z/KrzOo6i2VMllQW5eRXcYI7Ayl5ATei4=
In-Reply-To: <55F69DA2.7060204@excellency.fr>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Cyril B." <cbay@excellency.fr>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

On Mon, 2015-09-14 at 12:12 +0200, Cyril B. wrote:
> Ian Kent wrote:
> > So are you saying you don't have sufficient faith in the permissions set
> > on the file systems your mounting, that contain the information you want
> > to protect, that you must have the permissions of an intermediate file
> > system set to ensure that information about that vulnerability is not
> > seen?
> 
> I do know that there's no vulnerability at all, and that you can 
> trivially list users by other means.
> 
> Unfortunately, some of my less tech savvy users believe that there's a 
> vulnerability because they can see other accounts' home directories, and 
> thus feel that their own files are not safe. Is this stupid? absolutely. 
> But changing my /home permissions to 751 makes those users happy and 
> saves my time -- and my reputation as a sysadmin :)
> 
> I also do realize that the 755 permissions come from the autofs kernel 
> filesystem itself. But the kernel doesn't support a 'mode' option for 
> autofs (some other file systems do), and even if it did, autofs would 
> have to be patched to support it (in a slightly different way than my 
> current patch).
> 
> I understand that my use case may be a corner case, and I'm perfectly 
> fine with keeping my patch in my own tree. I figured that since I had 
> written the patch for myself anway, I may as well post it here as it 
> could be useful for others :)

And I didn't say I wouldn't accept the change but I will need you to do
the work to include all the things that the patch needs.

I'm not sure if it would be better to add mode as an autofs file system
option to the kernel and yes, the daemon would still need changes. It
might end up more complicated that way.

Ian

--
To unsubscribe from this list: send the line "unsubscribe autofs" in
