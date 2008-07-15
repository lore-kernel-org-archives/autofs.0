From: Michael Coffman <coffman@ftc.avagotech.com>
Subject: Unexpected autofs behaviour
Date: Tue, 15 Jul 2008 10:32:16 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0807151027190.17891@sixgun.ftc.avagotech.net>
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

I have a question about the behaviour of autofs.  It seems like it is
very easy to hit a situation where autofs will unmount a file system
and an active process will lose access to a file and fail to read it.
This seems to happen with both direct and indirect mapping.

Specifics about what I am running:

    autofs-4.1.3-199.3
    kernel - 2.6.9-55.ELsmp
    arch - x86_64
    OS - Red Hat Enterprise Linux WS release 4 (Nahant Update 5

autofs is configured to use the defaults and has host mapping
enabled.  When I run the following simple test:

   date;while [[ -r /net/hostname/test ]]; do :; done; date

command output:
   Fri Jul 11 09:02:46 MDT 2008
   Fri Jul 11 09:03:59 MDT 2008
command output run 2:
   Fri Jul 11 09:11:42 MDT 2008
   Fri Jul 11 09:12:45 MDT 2008

As you can see, I lose read access typically shortly after the mount is
supposed to time out.

The file system options from /proc/mounts are:

nfs rw,nosuid,nodev,v3,rsize=32768,wsize=32768,soft,intr,tcp,lock,proto=tcp,timeo=600,retrans=5,addr=farmall 
0 0

I believe that after the timeout, autofs tries to unmount file systems and
if they are busy, resets the timeout counter and remounts any unmounted
mount points if it is a host map.

But in general, I would think that I should never lose read access to the
file.  Shouldn't autofs just remount it if it has been unmounted?

I see the same behaviour on ubuntu 7.04 autofs version 4.1.4-13

Anyone have any insight?

BTW: am-utils (amd) does not behave this way.  I am guessing this
      has to do with the fact that it runs in user space.

Thanks.
--
-MichaelC
