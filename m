From: Ian Kent <raven@themaw.net>
Subject: Re: No mount possible when only listing?
Date: Wed, 26 Dec 2007 21:49:44 +0900
Message-ID: <1198673384.9481.22.camel@raven.themaw.net>
References: <200712251137.39694.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200712251137.39694.stef@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Tue, 2007-12-25 at 11:37 +0100, Stef Bon wrote:
> Hello,
> 
> I'm using a construction to browse and to access the Windows/Samba
> network hosts and shares. It works like:
> 
> http://www.novell.com/coolsolutions/tip/19076.html
> 
> Now you access a share like:
> 
> ls -al /mydomain/hostA/firstsharehostA
> 
> it will mount the share (autofs does this) and the content of the share will be shown, as expected.
> 
> My construction, which you can find at:
> 
> http://www.howtoforge.com/automatic_discovery_mounting_smb_networkshares
> 
> works with shares which are symlinks pointing from a "networktree" in the homedirectory of the user
> to this autofs directory. In my case it looks like:
> 
> /home/sbon/Global Network/Windows Network/hostA/firstsharehostA -> /mydomain/hostA/firstsharehostA
> /home/sbon/Global Network/Windows Network/hostA/secondsharehostA -> /mydomain/hostA/secondsharehostA
> /home/sbon/Global Network/Windows Network/hostA/thirdsharehostA -> /mydomain/hostA/thirdsharehostA
> 
> In my howto on howtoforge I've used a different setup, but basically it's exactly the same.

The auto.mydomain.sub is not a legal map and I can't say that it will
continue to work that way you expect it to.

Only one wildcard entry is allowed in a map.

> 
> Now when listing the content of the directory
> 
> ls -al /home/sbon/Global Network/Windows Network/hostA/firstsharehostA
> 
> it will act the same as shown above: the share will be mounted, and a virtual directory
> for the host is created by the automounter using autofs.
> 
> Now when you want to see the contents of hostA with:
> 
> ls -al /home/sbon/Global Network/Windows Network/hostA
> 
> it will show all shares hostA has (first, second and thirdsharehostA), but at the same time it will mount the shares,
> which is not necessary at all. I only want the content of hostA, not the content of the shares.
> 
> I can explain the behaviour. The ls command follows the symlink. When looking to where it is pointing to,
> the automounter is activated, and does a mount.
> 
> It is somehow possible to instruct the automounter, that when it comes to a simple "readlink" it does not mount
> the shares, but shows some sort of preview.

I'm not sure I understand what you're saying but I think you're
referring to a directory that contains symlinks. The directory that
contains the symlinks isn't an automount managed directory and so autofs
has no knowledge of what happens their. If you use color "ls" it will
stat the links that point to valid automount mounts, performing a path
walk on each, causing it to be mounted. I don't think there's much that
can be done about this within the submounted setup that you're using.

I think the only way to get around this would be to enhance the setup
using something along the lines of the auto.smb example program map in
the distribution and version 5 of autofs.

Ian
