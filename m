From: Stef Bon <stef@bononline.nl>
Subject: No mount possible when only listing?
Date: Tue, 25 Dec 2007 11:37:39 +0100
Message-ID: <200712251137.39694.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

Hello,

I'm using a construction to browse and to access the Windows/Samba
network hosts and shares. It works like:

http://www.novell.com/coolsolutions/tip/19076.html

Now you access a share like:

ls -al /mydomain/hostA/firstsharehostA

it will mount the share (autofs does this) and the content of the share will be shown, as expected.

My construction, which you can find at:

http://www.howtoforge.com/automatic_discovery_mounting_smb_networkshares

works with shares which are symlinks pointing from a "networktree" in the homedirectory of the user
to this autofs directory. In my case it looks like:

/home/sbon/Global Network/Windows Network/hostA/firstsharehostA -> /mydomain/hostA/firstsharehostA
/home/sbon/Global Network/Windows Network/hostA/secondsharehostA -> /mydomain/hostA/secondsharehostA
/home/sbon/Global Network/Windows Network/hostA/thirdsharehostA -> /mydomain/hostA/thirdsharehostA

In my howto on howtoforge I've used a different setup, but basically it's exactly the same.

Now when listing the content of the directory

ls -al /home/sbon/Global Network/Windows Network/hostA/firstsharehostA

it will act the same as shown above: the share will be mounted, and a virtual directory
for the host is created by the automounter using autofs.

Now when you want to see the contents of hostA with:

ls -al /home/sbon/Global Network/Windows Network/hostA

it will show all shares hostA has (first, second and thirdsharehostA), but at the same time it will mount the shares,
which is not necessary at all. I only want the content of hostA, not the content of the shares.

I can explain the behaviour. The ls command follows the symlink. When looking to where it is pointing to,
the automounter is activated, and does a mount.

It is somehow possible to instruct the automounter, that when it comes to a simple "readlink" it does not mount
the shares, but shows some sort of preview.

I hope you understand the problem. I can imagine it is quite complicated when reading this.

Stef Bon
Voorburg
the Netherlands
