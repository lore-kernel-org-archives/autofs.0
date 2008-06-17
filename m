From: Stef Bon <stef@bononline.nl>
Subject: Suggestion for better manpage.
Date: Tue, 17 Jun 2008 12:57:45 +0200
Message-ID: <200806171257.45914.stef@bononline.nl>
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
To: autofs mailing list <autofs@linux.kernel.org>

Hello,

reading the manpage of automount, I would like to change the section in the 
manpage about how the daemon reacts on signals.

It is now:


If  the  automount  daemon  catches  a  USR1  signal, it will umount all 
currently unused autofs managed mounted file systems and continue running
       (forced expire).  If it catches the TERM signal it will umount all 
unused autofs managed mounted file systems and exit if there are  no  
remaining
       busy  file systems. If autofs has been compiled with the option to 
ignore busy mounts on exit it will exit leaving any busy mounts in place 
other-
       wise busy file systems will not be umounted and autofs will not exit.  
Alternatively, if autofs has been compiled with the option to enable forced
       shutdown then a USR2 signal to the daemon will cause all mounts to be 
umounted and any busy mounts to be forcibly umounted, including autofs mount
       point directories (summary execution). Note that the forced umount is 
an unlink operation and the actual umount will not happen in the kernel  un-
       til active file handles are released.  The daemon also responds to a 
HUP signal which triggers an update of the maps for each mount point.

       If any autofs mount point directories are busy when the daemon is sent 
an exit signal the daemon will not exit. The exception to this is if autofs
       has been built with configure options to either ignore busy mounts at 
exit or force umount at exit. If the ignore busy mounts at  exit  option  is
       used  the filesystems will be left in a catatonic (non-functional) 
state and can be manually umounted when they become unused. If the force 
umount
       at exit option is used the filesystems will be umounted but the mount 
will not be released by the kernel until they are no longer in  use  by  the
       processes that held them busy.  If automount managed filesystems are 
found mounted when autofs is started they will be recoverd unless they are no
       longer present in the map in which case they need to umounted manually.

I would like to suggest:

The automount daemon can react on a few signals. Some of them are standard, 
others are less standard and/or need compiletime options.

TERM

If it catches the TERM signal it will umount all unused autofs managed mounted 
filesystems, and exit if there are no remaining mounts left. It will keep on 
running (till??)
If compiled with the "ignore busy mounts" option, it will exit here, and leave 
any mountpoint in place.

USR2
This only applies when the automounter is compiled with the "enable forced 
shudown". When it catches the USR2, it will umount all mounts, busy or not. 
Note: umounting a busy mountpoint  is actually an unlink operation. The actual 
umount will be done later, when all active file handleds are released. (this 
id done by??)

USR1
With the USR1 signal it will umount all currently unused mounts, and continue 
running (forced expire).

HUP
This signal triggers an update of the maps for each mountpoint.


 I've left out some parts, but mostly rearranged the information. I've left 
out the text "summary execution" Is it important?

But what do you think. Is it better this way?

Stef Bon
