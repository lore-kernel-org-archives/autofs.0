From: raven@themaw.net
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Tue, 13 Jan 2004 00:01:26 +0800 (WST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0401122356100.6362@raven.themaw.net>
References: <Pine.LNX.4.33.0401101325280.2403-100000@wombat.indigo.net.au>
 <40029C19.409@sun.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <40029C19.409@sun.com>
List-Id: <autofs.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Jim Carter <jimc@math.ucla.edu>, autofs mailing list <autofs@linux.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 12 Jan 2004, Mike Waychison wrote:

> >
> >Transparency of an autofs filesystem (as I'm calling it) is the situation
> >where, given a map
> >
> >/usr	/man1	server:/usr/man1
> >	/man2	server:/usr/man2
> >
> >where the filesystem /usr contains, say a directory lib, that needs to be
> >available while also seeing the automounted directories.
> >
> >  
> >
> I see.  This requires direct mount triggers to do properly.  Trying to 
> do it with some sort of passthrough to the underlying filesystem is a 
> nightmare waiting to happen..
> 

So what are we saying here?

We install triggers at /usr/man1 and /usr/man2.
Then suppose the map had a nobrowse option.
Does the trigger also take care of hiding man1 and man2?

Is there some definition of these triggers?

Ian
