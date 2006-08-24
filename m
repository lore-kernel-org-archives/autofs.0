From: Anders Blomdell <anders.blomdell@control.lth.se>
Subject: Bug#379780: autofs: Automounts fail to automount after a few days of uptime
Date: Thu, 24 Aug 2006 12:28:49 +0200
Message-ID: <44ED7F61.1040402@control.lth.se>
Reply-To: Anders Blomdell <anders.blomdell@control.lth.se>,
	379780@bugs.debian.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.379780.B379780.1156415343704@bugs.debian.org>
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: 379780@bugs.debian.org
Cc: Christian Weeks <christian.weeks@oracle.com>, autofs@linux.kernel.org

I see similar behaviour on a FC4 system running 2.6.13-1.1526_FC4smp, in this 
case the problem seems to be (gleaned from strace of /usr/sbin/automount) when 
stating "/home/dir/subd":

read(3, "\4\0\0\0\0\0\0\0\f\214\2\0\10\0\0\0dir/subd\0\0\0\0\0\0"..., 272) = 272
chdir("/home")                          = 0
lstat64("dir/subd", 0xbfb6e0cc)         = -1 ENOENT (No such file or directory)

in cases where no error occurs, the same stat gives this in the strace:

read(3, "\4\0\0\0\0\0\0\0\16\214\2\0\6\0\0\0dir\0\0\0\0\0\0\0"..., 272) = 272
chdir("/home")                          = 0
lstat64("dir", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0

so to mee it seems like the kernel is requesting the wrong information from the 
automounter...

Regards

Anders

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

