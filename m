From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5 not recognizing manual umounts properly
Date: Mon, 30 Oct 2006 18:49:12 +0800
Message-ID: <1162205352.2900.40.camel@localhost>
References: <0F5A1C742BC73849AFF518F1F8249D4D0181D723@mtpx3m2.mtp.emea.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <0F5A1C742BC73849AFF518F1F8249D4D0181D723@mtpx3m2.mtp.emea.dell.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Scott_Rochford@DELL.com
Cc: autofs@linux.kernel.org

On Mon, 2006-10-30 at 09:53 +0000, Scott_Rochford@DELL.com wrote:
> > I'm likely to end up saying that manual umounting of automounted 
> > shares is a bad thing and doing so may lead to unpredictable 
> > behavior. I may be able to improve matters but it is unlikely to be 
> > totally reliable.
> > So I recommend leaving the automounts alone.
> 
> In an ideal world, yes of course, but in reality in large production
> environments with NFS servers going down and/or hanging from time to
> time for various reasons I think it's a situation that needs to be
> accounted for.

In any world really.
The man pages for the Solaris automounter say much the same thing.

Never the less, it looks like there is some more work to be done in this
area. Also, not all types of automounts will not work properly when they
are manually umounted but I can't say it's OK for some and not others as
that will introduce confusion. In particular, manually umounting parts
of nested mount trees is not something that should be attempted at all.

> 
> Failing that, an alternative procedure?  Stop the automounter, unmount,
> and restart it perhaps?

As it turns out the FC6 build uses the "--enable-ignore-busy" configure
option. If mounts are wedged then restarting autofs will unlink umount
all mounts and start afresh. This allows existing processes using mounts
that aren't wedged to continue until they are done with the mount, while
new mount requests are handled by the new daemon. Clearly, if a mount is
blocked in an uninterruptable sleep then they won't be released by the
kernel and the process that is stuck would need to be encouraged to go
away in a fairly forceful manner, if it can be persuaded to go away at
all. This is not a perfect solution because there is a finite amount of
time that there is no daemon to answer requests but I can't see any
other way to deal with this.

I've given this problem a lot of thought and considerable effort and
it's about as good as it can be until I can come up with something
better if that's possible.

Ian
