From: raven@themaw.net
Subject: Re: Debian: Init script confused by options
Date: Wed, 12 May 2004 20:59:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405122051330.6844@donald.themaw.net>
References: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
 <20040512092907.GB28873@majestix.home.watz.ch>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040512092907.GB28873@majestix.home.watz.ch>
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
To: Daniel Lutz <danlutz@debian.org>
Cc: autofs@linux.kernel.org, Thorild Selen <thorild@Update.UU.SE>

On Wed, 12 May 2004, Daniel Lutz wrote:

> > Starting the automounter in Debian:
> > 
> > > [Psilocybe] update # /etc/init.d/autofs start
> > > Starting automounter: --ghost.
> 
> [...]
> 
> The init script used by the official Debian package isn't yet
> included in the upstream sources, i. e. the Debian-specific
> parts of the init script contained in the upstream sources
> is out of date. The init script of the official Debian package
> is currently generated from the init script contianed in the
> upstream sources by applying a lot of patches.
> 
> I recommend you to take the init script from the latest official
> Debian package. 
> 
> Correct creation of pid files should also work with this script.

Would you like me to try to merge this into the package Daniel?

There are some significat fixes to startup problems in the current version 
of autofs v4. I don't think they are fully accounted for in the Debian 
init script. As you know I have already merged a fair number of the 
Debian patches and taken steps to solve some other concerns, such as 
log verbosity.

What can I do to encourage you to upgrade from the 4.0.0pre10 base you are 
using. Sorry, I know it's quite a bit of work, but I'm certain the current 
version is more stable and functional than your current base.

Ian
