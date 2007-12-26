From: Stef Bon <stef@bononline.nl>
Subject: Re: No mount possible when only listing?
Date: Wed, 26 Dec 2007 21:45:22 +0100
Message-ID: <200712262145.22593.stef@bononline.nl>
References: <200712251137.39694.stef@bononline.nl>
	<1198673384.9481.22.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1198673384.9481.22.camel@raven.themaw.net>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

On Wednesday 26 December 2007 13:49:44 you wrote:
> On Tue, 2007-12-25 at 11:37 +0100, Stef Bon wrote:
> > works with shares which are symlinks pointing from a "networktree" in the homedirectory of the user
> > to this autofs directory. In my case it looks like:
> > 
> > /home/sbon/Global Network/Windows Network/hostA/firstsharehostA -> /mydomain/hostA/firstsharehostA
> > /home/sbon/Global Network/Windows Network/hostA/secondsharehostA -> /mydomain/hostA/secondsharehostA
> > /home/sbon/Global Network/Windows Network/hostA/thirdsharehostA -> /mydomain/hostA/thirdsharehostA
> > 
> > In my howto on howtoforge I've used a different setup, but basically it's exactly the same.
> 
> The auto.mydomain.sub is not a legal map and I can't say that it will
> continue to work that way you expect it to.
> 
> Only one wildcard entry is allowed in a map.
> 
Well, that's not very good news. This makes that my construction is not supported by version 5 of autofs.
I asume there is a reason for this. Can you explain?

> > which is not necessary at all. I only want the content of hostA, not the content of the shares.
> > 
> > I can explain the behaviour. The ls command follows the symlink. When looking to where it is pointing to,
> > the automounter is activated, and does a mount.
> > 
> > It is somehow possible to instruct the automounter, that when it comes to a simple "readlink" it does not mount
> > the shares, but shows some sort of preview.
> 
> I'm not sure I understand what you're saying but I think you're
> referring to a directory that contains symlinks. The directory that
> contains the symlinks isn't an automount managed directory and so autofs
> has no knowledge of what happens their. If you use color "ls" it will
> stat the links that point to valid automount mounts, performing a path
> walk on each, causing it to be mounted. I don't think there's much that
> can be done about this within the submounted setup that you're using.
> 
Indeed the ls command is responsible for the following of the symlinks. On my system there
is an alias for ls: ls ='ls --color=auto'
I've tried to do a ls by invoking the command with the whole path (/bin/ls) and the behaviour
is what I want: no mounting.
I can undo the creating of the alias, but the problem will remain when using the tools in a graphical
environment like KDE. The default filemanager does follow the symlinks 
(and does probably a stat or something).

So the problem remains. But it is no showstopper: it would be very nice when solved, 
but no disaster if it isn't.

> I think the only way to get around this would be to enhance the setup
> using something along the lines of the auto.smb example program map in
> the distribution and version 5 of autofs.

Now my construction does not use smbclient when mounting. Instead is makes use
of a cache (which is build with nbtscan and smbclient). 
But anyhow, I cannot see directly how the auto.smb program can do this. Can you 
explain your idea more a little bit?


Stef Bon
