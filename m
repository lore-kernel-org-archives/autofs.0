From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Is Autofs 5 Slower Than 4
Date: Wed, 20 Aug 2008 09:28:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0808200851290.24770@simba.math.ucla.edu>
References: <241046.64511.qm@web54306.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <241046.64511.qm@web54306.mail.re2.yahoo.com>
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
To: Thanh Tran <ttran7700@yahoo.com>
Cc: autofs@linux.kernel.org

On Wed, 20 Aug 2008, Thanh Tran wrote:

> I upgraded my entire OS from Fedora 5 to 8.  By slow, I mean around 20 
> seconds to detect and mount.  There are too many variables.  I was hoping 
> it would be a simple polling flag that could be switched in autofs.  I 
> can live with the slower time.  I did notice that it took a long time 
> only when I physically removed the drive and re-inserted the drive.  
> When I use the "umount" command and not remove the drive, I can quickly 
> change directory back to drive and it mounts in like 2 seconds at most.  
> Thanks for the help.

It sounds like the issue is with hotplug -- automount can't mount a drive 
when the kernel doesn't admit that it exists.  If you could capture syslog 
traffic from the kernel at the "debug" level, you could see from the 
timestamps exactly how long it took to get the USB device alive enough to 
be mounted.  Also, I can easily imagine a race condition in which the 
device is partially hotplugged, enough that the mount command doesn't fail 
but does get stuck in some kind of timeout.  If you wanted to put a lot of 
work into the project, you could do this:

Starting with the device unmounted and removed, insert it and 
simultaneously press enter on a command like this:
    time /bin/sh -c "sleep 1 ; ls -ld /media/myusbdrive/."
(the ending /. makes sure that the command cannot finish until the referent 
is actually mounted -- with "ls /media/myusbdrive" you wonder if an 
optimization might deliver only confirmation that the mount point is in the 
/media directory.)  Unmount and repeat, varying the sleep time from 1 to 20 
secs, and see if there's a specific time, probably about 5 secs, where 
the long extra delay does not happen.

Jeff Moyer mentioned that most people use HAL and friends to mount 
hotplugged volumes.  I've written up a small "howto" on this topic.  See 
"Jim Carter's Bugfixes", 
http://www.math.ucla.edu/~jimc/documents/bugfix.html
about halfway through, the item titled "Automatic Volume Mounting Without 
KDE or Gnome", and the items following.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 520 Portola Plaza; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
