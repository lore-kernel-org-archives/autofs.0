From: Daniel Lutz <danlutz@debian.org>
Subject: Re: Debian: Init script confused by options
Date: Wed, 12 May 2004 15:34:26 +0200
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20040512133426.GA30296@majestix.home.watz.ch>
References: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
	<20040512092907.GB28873@majestix.home.watz.ch>
	<Pine.LNX.4.58.0405122051330.6844@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405122051330.6844@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Thorild Selen <thorild@Update.UU.SE>

> Would you like me to try to merge this into the package Daniel?

Currently, I have the following main concern with this:

- I think different distributions' init scripts have different
  behaviors. For example, Debian's init script supports
  /etc/nsswitch.conf and LDAP for auto.master since some time, but
  it behaves a bit different than for example RedHat's init script. I needed
  to do this for remaining compatible to older versions of the
  (Debian) package, so that upgrades of a Debian installation don't break
  the system.

I haven't yet tested it, but I think Debian's current init script should
work more or less with autofs 4.1.x. So I would say merging this
script into your package wouldn't be a big advantage for the moment, at least
not for me.

> There are some significat fixes to startup problems in the current version 
> of autofs v4. I don't think they are fully accounted for in the Debian 
> init script. As you know I have already merged a fair number of the 
> Debian patches and taken steps to solve some other concerns, such as 
> log verbosity.
> 
> What can I do to encourage you to upgrade from the 4.0.0pre10 base you are 
> using. Sorry, I know it's quite a bit of work, but I'm certain the current 
> version is more stable and functional than your current base.

I'm fully aware that an upgrade to 4.1.x would be the best thing to do,
a lot of bugs in Debians bug tracking system could be closed.
But unfortunately I'm still too busy for doing this big step.

-Daniel
