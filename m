From: Pavel Troller <patrol@sinus.cz>
Subject: Re: automount 4.1.3: unmount timeout not working
Date: Sat, 29 Jan 2005 05:49:35 +0100
Message-ID: <20050129044935.GA11104@tangens.sinus.cz>
References: <20050122215228.GA14303@tangens.sinus.cz>
	<Pine.LNX.4.61.0501262240140.1716@donald.themaw.net>
	<20050126194824.GA3627@tangens.sinus.cz>
	<Pine.LNX.4.61.0501291154590.1607@donald.themaw.net>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501291154590.1607@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Pavel Troller <patrol@sinus.cz>

> On Wed, 26 Jan 2005, Pavel Troller wrote:
> 
> >>
> >>But you leave out the crucial log trace following the mount?
> >>
> >>Can we see more of what follows here please.
> >>
> >>Ian
> >Hello Ian,
> > OK, I'm sending the full system log during the mount/umount... I don't 
> > know
> >which part You are interested in, but I don't see anything special...
> 
> Maybe because what I'm looking for is not there.
> So this is probably the cause of the probem.
> 
> I think that what is happening is that for the short timeouts you are 
> using the expire timer is being set to 0, disabling expiration.
> 
> I'll have a look but does this work if you set the timeout to 4 seconds or 
> above?
> 
Hi Ian,
  I increased the timeout to 10 seconds for the test. No change has been
observed, still no auto umount.
  I would like to remember that it worked perfectly and then stopped working
probably after upgrading some part of this system. I'm using exactly the same
setup on other computers with no problems. Timeout is set to 3 there, it was
3 here too, but I tried to change the value after it ceased to work. So
definitely, it's not the cause.
  The only bigger change I remember I did was upgrading bash to 3.0. But I
cannot imagine how could changing a shell cause such a problem. I even tried
to put the old bash back and test it and it didn't work too.
  Please tell me where to put some debug texts to be logged or so, I can
modify the source and cooperate with finding the bug.
                                        With regards, Pavel
