From: Ian Kent <raven@themaw.net>
Subject: Re: autofs and nautilus
Date: Mon, 1 Sep 2003 21:55:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309012139520.4150-100000@raven.themaw.net>
References: <1062411218.22264.38.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1062411218.22264.38.camel@localhost.localdomain>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Larsson <alexl@redhat.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Nautilus <nautilus-list@gnome.org>

On 1 Sep 2003, Alexander Larsson wrote:

> On Sat, 2003-08-30 at 16:55, Ian Kent wrote:
> > Hi all,
> > 
> > I have recently taken on maintenance of autofs v4 and am investigating a 
> > problem with Nautilus and autofs.
> > 
> > It appears that the if the Trash monitor scans the mounts at the time that 
> > an expire is happening it remounts the the automount entry. I have spent 
> > quite a while developing an understanding of what is happening but I can't 
> > think of a way to get around this purely within autofs. I am hoping that 
> > a solution can be found in discussion here on the list.
> > 
> > Please help.
> 
> I'm all for fixing this in Nautilus, however i'm hardly an expert in
> autofs or mounting in general. The nautilus volume handling code is
> pretty gross, and at some point it will probably be rewritten. 

In cooperation with autofs we should be able to sort it out.

> 
> However, is trash scanning really a problem? Don't we only do that on
> startup?

That's the sort of thing I'm here to find out.

I'm happy to do more experimentation.

It appears to me that there is probably a call to stat or the like that 
often (sometimes 3 out of 4, sometimes 1 out of 4, then sometimes not a 
all) happens when an automount times out, like it is triggered upon 
seeing the change in the mount table. This, as it should, causes 
a (re)mount to occur. A quick scan over the source gave me the impression 
it might be a scan for trash folders but I am by no means sure. One 
obvious thought is that it's probably not useful to act on umounts but 
rather on mounts. I'm sure it can't be that simple.

Perhaps a pointer to the relevant bits of code could shed some light on it 
for me without the pain of having to go through it bit by bit.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
