From: Ian Kent <raven@themaw.net>
Subject: Re: Automount ghost option
Date: Sat, 19 Nov 2005 11:35:02 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511191116260.2069@donald.themaw.net>
References: <437E0F3A.2000906@free.fr>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161258AbVKSDf1@vger.kernel.org>
In-Reply-To: <437E0F3A.2000906@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Olivier Croquette <ocroquette@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org

On Fri, 18 Nov 2005, Olivier Croquette wrote:

> 
> I want the automount mount points to be visible even if they are not mounted.
> 
> It seems the "ghost" option implements that. I can find several references on
> the internet which indicates it is available, like:
> http://gentoo-wiki.com/HOWTO_Auto_mount_filesystems_(AUTOFS)

This looks like a good description of to do it.

> 
> Nevertheless, on some recent distributions I have tested on, this option is
> not available.

For example?

It is available on all recent RedHat distributions, Debian 3.1, latest 
SuSE and although last time I looked Gentoo is a little behind on their 
release and patches it should still work. I also recommend a fairly recent 
2.6 kernel in order to get the latest bug fixes. I've fallen somewhat 
behind in updating my 2.4 patches but those that are available at 

http://www.kernel.org/pub/linux/daemons/autofs/v4

should work adequately.

> 
> Can anyone tell me in which version of automount it is present?
> Or is it a distribution specific patch?

Preferably 4.1.4 with at least the patches autofs-4.1.4-*.patch from 
kernel.org above applied but distributions that have a 4.1 version should 
work.

You need to be aware that some maps cannot be browsable (the terminology 
is about to change from ghosting). For example

*	host:/some/dir/&

is not browsable because autofs cannot know what the map keys at startup.

Basically, if the map keys cannot be known in advance they will not be 
seen, at least immediately after startup.
 
Ian
