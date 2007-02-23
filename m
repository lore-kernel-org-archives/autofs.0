From: Anthony Menasse <anthony.menasse@rsp.com.au>
Subject: automount 4.1  / mount issues and possible workarounds
Date: Fri, 23 Feb 2007 18:09:07 +1100
Message-ID: <45DE9313.4070303@rsp.com.au>
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

Hi,

I was hoping for some feedback on wether the following actions are
appropriate to fix the issues we are having with automount /mount.  I
haven't explained the problems in detail, but from reading the mailing
list and other sources they seem like fairly common issues. I just want
to make sure my proposed fixes make sense. Im guessing a lot of this has
been discussed many times before on this list, but i just wanted some
confirmation that i am on the right track (or not). Any advice would be
greatly appreciated.


Setup:

A bunch of NFS servers running a mixture of  RH Enterprise 4, Enterprise
3 and X/OS linux4 and a bunch of Fedora Core 3 clients running a non
Fedora built 2.6.11.7 kernel.

The automount update i am looking at installing is the latest  automount
package from FC5 (4.1.4 Release 33) rebuilt for FC3 (which seems to work
ok after some initial testing on a single box)

I want to avoid updating the kernel at this point.

Not sure about my strategy about updating 'mount', would you recommend
getting the latest source or will an older package from FC3 do? In other
words are there still serious issues with mount which mean i should be
running the latest source or are the issues such as overriding RPC
timeout values and locking issues with mtab only an issue with ancient
versions of mount?

Issue 1:


nfs: mount failure chop:/export/home/rsp on /home/rsp

I believe this is due to automount using a mount  retry value of 0 and
dodgy versions of mount overriding the default RPC timeout from
60seconds to 0.7 seconds so the attempt times out too quickly

References:

http://nfsworld.blogspot.com/2005/03/automounter-tuning.html

http://www.mail-archive.com/autofs@linux.kernel.org/msg05281.html


Possible Fix:

I want to fix this by using --retry=2 in the auto.master file, and
update mount where i can (i want to do both as i can't update mount on
every machine/ platform right now)

Issue 2:

When accessing an unmounted automount mount point the automounter will
complain that the directory is already mounted (even though it isn't!)

You may get something like this in the log / console.

BUG: <dir> already mounted

I think this is due to a corrupt mtab file due to the  race /locking
issues with older versions of mount

Possible Fix:

I want to update mount where i can , and link /etc/mtab to /proc/mount .
(Are there any issues with having mtab as a link to /proc/mounts?)


Issue 3:

Wierd errors in the logs about attempts to mount files:

Jan 20 18:45:36 glass automount[28315]: mount(nfs): nfs: mount failure
hassan:/export/home/rsp/.sitecshrc on /home/rsp/.sitecshrc

The initial mount is failing due to the issues described above. However
the lookup is continued for the entire path

I think i might ignore this issue until i can upgrade the kernel on the
clients and do more testing as it seems to be related to issue 2.


thankyou if you have actually read this far:)


Cheers
Anthony


-- 
anthony menasse
systems administrator | anthony.menasse@rsp.com.au
rising sun pictures | www.rsp.com.au
direct line +61 2 9384 4572
