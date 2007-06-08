From: akolasny@cis.jhu.edu
Subject: autofs4 + sshfs works but autofs5 + sshfs fails
Date: Fri, 8 Jun 2007 19:21:00 -0400 (EDT)
Message-ID: <2345.69.243.87.84.1181344860.squirrel@webmail.cis.jhu.edu>
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

Greetings:

My NIS auto.net has an entry that looks similar to:

   my_dir -fstype=fuse,reconnect,allow_other,uid=6000,gid=6000,umask=0002
sshfs#user@some.site:/my_dir

It works fine with CentOS 4 x86, x86_64 and ia64 distributions using autofs4. I
installed CentOS 5 x86_64
which uses autofs5 and this NIS mount failed.

Note: In order to allow NIS to properly provide the auto.net entry, I needed to
make a minor change to
      the /var/yp/Makefile to allow '#' in the NIS database.

The 'automount -v -d' reports in /var/messages something like:

   Jun  8 19:02:23 c1 automount[27076]: attempting to mount entry /net/my_dir
   Jun  8 19:02:24 c1 automount[27076]: parse_mount: parse(sun): invalid location
   Jun  8 19:02:24 c1 automount[27076]: failed to mount /net/my_dir


Does autofs-5.0.1/modules/parse_sun.c 'validate_location' function need to allow
the '#' to
get this working again? If it's something simple like this, would it be possible
to add to
the next release?

When I manually use sshfs on the CentOS 5 machine it works fine. 'sshfs -V'
reports:

    SSHFS version 1.8
    FUSE library version: 2.6.5
    fusermount version: 2.6.5
    using FUSE kernel interface version 7.8

Also, If I add the entry in the /etc/fstab, it works.

Your assistance is greatly appreciated.

Thanks,
Anthony
