From: Stef Bon <stef@bononline.nl>
Subject: make an executable map rerun.
Date: Wed, 25 Mar 2009 10:21:36 +0100
Message-ID: <49C9F7A0.80603@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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

I've been working on a solution to make networkresources available via 
autofs on a dynamic way. After login with help
from ConsoleKit a mountpoint is added to the master file of the 
automounter. This mountpoint is in the homedirectory of the user logging in.

This way I've a browseable network map in my home directory for Windows 
Networks (via cifs), FTP (via curlftpfs/FUSE) and SSH (with sshfs/FUSE). 
Others, like Novell should be possible.

It works with executable maps. Now for some reasons I would like some 
control over rerrunning the executable map, to make the automounter 
refresh the autofs data. Now I do not see how to do that. I reload 
signal does not do that.

Is there a way to do this?

Stef Bon
