From: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
Date: Thu, 8 Jan 2004 18:31:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040108183135.GE30321@parcelfarce.linux.theplanet.co.uk>
References: <3FFC96FE.9050002@zytor.com> <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401082050210.354-100000@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jim Carter <jimc@math.ucla.edu>, "Ogden, Aaron A." <aogden@unocal.com>, thockin@sun.com, autofs mailing list <autofs@linux.kernel.org>, Mike Waychison <Michael.Waychison@sun.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jan 08, 2004 at 08:52:31PM +0800, Ian Kent wrote:
> On Wed, 7 Jan 2004, H. Peter Anvin wrote:
> 
> >
> > These are the mount traps Al Viro has been architecting.
> >
> 
> Please tell me about these.
> 
> I have`nt seen any discussion on the implementation.
> 
> Just a few sentences ....

Special vfsmount mounted somewhere; has no superblock associated with it;
attempt to step on it triggers event; normal result of that event is to
get a normal mount on top of it, at which point usual chaining logics
will make sure that we don't see the trap until it's uncovered by removal
of covering filesystem.  Trap (and everything mounted on it, etc.) can
be removed by normal lazy umount.

Basically, it's a single-point analog of autofs done entirely in VFS.
The job of automounter is to maintain the traps and react to events.

And yes, I should've done that months ago.  Waaaaay too long backlog -
bdev work, dev_t stuff, netdev, yadda, yadda.
