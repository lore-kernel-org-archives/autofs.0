From: Ian Kent <raven@themaw.net>
Subject: Re: Re: Where will it live
Date: Thu, 4 Sep 2003 20:28:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309041947430.3156-100000@raven.themaw.net>
References: <3F567FF4.9050207@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F567FF4.9050207@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Alvin Oga <alvin@Mail.Linux-Consulting.com>

On Wed, 3 Sep 2003, H. Peter Anvin wrote:

> Alvin Oga wrote:
> > hi ya
> > 
> > On Wed, 3 Sep 2003, H. Peter Anvin wrote:
> > 
> > 
> >>Obviously for posting packages there is kernel.org, as before;
> >>unfortunately we don't really have the human resources at this time to
> >>set up SCM repositories.
> > 
> > 
> > i'd be more than happy to spend time and drop a machine off
> > to be autofs.kernel.org  ...
> > 	( have plenty of spare 1U boxes - used for testing )
> > 
> > and configure anoncvs ... i havent done that yet .. ( the
> > challenge/fun/frustation )
> > 
> 
> I guess what we'd really need is cvs.kernel.org for all kinds of
> different projects.
> 
> Here is probably not the best option for hosting if you are going to
> maintain it, but I think I have a solution to that.  Let me get back to
> you next week if there is interest, ok?
> 

I have a few thoughts on the discussion.

Firstly I think it goes without saying we need to maintain an up to date 
copy of the tarballs on kernel.org. Everyone expects it to be there and 
the authoritative autofs release packages should all be in the same place 
in at least one location.

I have not used CVS much. We use SCCS for most of our admin and utility 
scripts at work. The function is the same so the issues are the same.

I will maintain a 'mostly not working' CVS on my little co-lo machine 
anyway as I need to be able to grab it when I can't get onto my computer 
'cause the kids have kicked me of mine' but that's another story.

Forgive me for stating the obvious. But for completeness I will.

The big issues here are the CVS repository needs care and feeding and 
backup. This is trivial for a few small packages such as autofs but these 
things have a tendency to grow without bound when you least expect them 
to. This becomes important for development when CVS becomes the 'place 
the distribution lives' for dif comparison and bug hunting etc.

Although we don't expect much traffic, it is possible that at times 
considerable download volumes may occur which of course means dollars.

The point being we shouldn't take the amount of effort needed to keep it 
available and maintain it lightly.

I think that one of the public CVS repositories would be best for these 
reasons but ...

Peter clearly has a different need and it would be great if we could 
establish cvs.kernel.org. However I think we would need a sponsor for 
this.

Thanks for your kind offer Alvin. Maybe you will be the sponsor.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
