From: David Wuertele <dave-gnus@bfnet.com>
Subject: support for Japanese share names?
Date: Tue, 28 Sep 2004 16:15:45 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <m3u0tidly6.fsf@bfnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="iso-2022-jp"
To: autofs@linux.kernel.org

The system:

    Fedora Core 2, relatively stock:

    # rpm -q autofs
    autofs-4.1.2-2
    # uname -a
    Linux 5nave 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 i686 i386=
 GNU/Linux
    # cat /etc/auto.master
    /mnt/server /etc/auto.server
    # cat /etc/auto.server
    * -fstype=3Dcifs,ip=3D192.168.5.172 ://server/&
    #=20

The problem:

    Shares that have low-ASCII names mount fine, but shares that have
    Japanese names won't mount under autofs:

    # ls /mnt/server/share
    dave	docs	Music   bitmaps  Photos
    # ls /mnt/server/=BF=B7=A4=B7=A4=A4=A5=D5=A5=A9=A5=EB=A5=C0
    ls: /mnt/server/=BF=B7=A4=B7=A4=A4=A5=D5=A5=A9=A5=EB=A5=C0: No such f=
ile or directory
    #=20

    The exact same share mounts fine when I do it manually:

    # mount -t cifs //server/=BF=B7=A4=B7=A4=A4=A5=D5=A5=A9=A5=EB=A5=C0 /=
mnt/dave -o ip=3D192.168.5.172
    # ls dave
    file1   file2   file3
    #=20

The question:

    Does autofs have support for non-ASCII sharenames at all?
    How do I make it work with Japanese sharenames?

Thanks,
Dave
