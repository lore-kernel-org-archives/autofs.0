From: chris barry <Christopher.Barry@qlogic.com>
Subject: fairly complex nested filesystems question
Date: Thu, 20 Dec 2007 18:29:51 -0500
Message-ID: <1198193391.6195.33.camel@localhost>
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

Greetings,

I'm trying to create a nested filesystem structure that combines an
automounted nfs home directory, with bind mounts from the local machine.

The structure will look like this:
/
|-home
   `-user1        <-(nfs somehost:/home/user1)
       |-myftp    <-(bind /var/ftp/users/user1)
       `-pub_ftp  <-(bind /var/ftp/pub)

The entire structure needs to get automounted as a group on login, and
then is chrooted as users ftp into this box.

My auto.master looks like this:
/home   /etc/auto.home --timeout=30

My auto.home looks like this:
*              -fstype=nfs,rw,intr   10.20.30.40:/home/& \
/home/&/myftp  -fstype=file          :/var/ftp/users/& \
/home/&/ftp    -fstype=file          :/var/ftp/pub


My home mounts fine via nfs, and is chrooted (when I ftp in), but the
other mounts do not occur, and no errors are thrown. Thinking it was a
timing issue, and the chroot had occurred before the local mounts
happened, I came in via ssh (which is not chrooted, but will not be
available to users later), and I get the same results. Finding any
examples of this kind of map has been challenging to say the least. 

I'm assuming my map syntax is incorrect, or is this type of thing simply
impossible?


Unfortunately, I have to stay at these versions.
RHEL4U5 2.6.9-55.ELsmp
ProFTPD  Version 1.3.1
Linux automount version 4.1.3-199.3


What am I doing wrong here?


Thanks,
-C
