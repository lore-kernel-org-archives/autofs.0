From: raven@themaw.net
Subject: Re: Debian: Init script confused by options
Date: Sun, 9 May 2004 12:13:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405091206180.19921@donald.themaw.net>
References: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16541.33862.63334.177007@Psilocybe.Update.UU.SE>
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
To: Thorild Selen <thorild@Update.UU.SE>
Cc: autofs@linux.kernel.org

On Sun, 9 May 2004, Thorild Selen wrote:

> Starting the automounter in Debian:
> 
> > [Psilocybe] update # /etc/init.d/autofs start
> > Starting automounter: --ghost.
> 
> This doesn't look very pretty. Function "debian" in the start script
> reads the output from getmounts assuming that the first thing after
> the command is the mount point. However, it might be an option. It
> wouldn't do to skip everything after the daemon name up to the first
> thing that does not start with a dash and then assume that the next
> thing is the mount point, since some options take arguments. These
> arguments may start with dashes or slashes.

Sorry Thorild.

Certainly I'm guilty of not tracking changes in the init with the Debian 
part.

What is really needed here is for the Debian maintainer to help out.

Are you there Daniel?

> 
> The fix below assumes that the mount point will be the first thing
> that starts with a slash and is followed by something that starts with
> a letter (the map type). A bit ugly, but it will still work with
> option arguments that starts with dashes or slashes; also, it doesn't
> need to know a thing about which options there are and whether they
> take any arguments or not. As long as the mount point starts with a
> slash and the map type starts with a letter, we're fine.
> 
> (Does anyone have a better idea?)

One day, when I get time.

In the mean time I'll use your supplied patch.

Thanks
Ian
