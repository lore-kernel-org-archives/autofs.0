From: "atlantos41" <atlantos41@yandex.ru>
Subject: Is autofs4 8-bit compatible?
Date: Thu, 24 Feb 2005 23:54:29 +0300 (MSK)
Message-ID: <421E3F05.00006A.08775@mfront7.yandex.ru>
Reply-To: atlantos41@yandex.ru
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Content-Type: text/plain; charset="iso-8859-1"
To: autofs@linux.kernel.org

Hi.
I start automount with command:
automount --timeout=3D60 /smb file /etc/auto.smb

where /etc/auto.smb is
test_data<cyrchar>est    -fstype=3Dsmbfs    ://test/data<cyrchar>est

where <cyrchar> is one cyrillic char, for example "=D4", i. e.
~ echo -n <cyrchar> | hexdump
0000000 00d4                                  =20
0000001

When I try to change directory to /smb/test_data<cyrchar>est, then autofs=
=20
fails with messages in syslog:
automount[13111]: failed to mount /smb/test_data

But if I change key in /etc/auto.smb to 7-bit, for example=20
"test_data<cyrchar>est" to "test_datatest":
test_datatest    -fstype=3Dsmbfs    ://test/data<cyrchar>est

and then restart automount, autofs works as it should be.

This problem appears to be in autofs 4.1.3 and autofs 4.1.4_beta1, but no=
t in=20
autofs 3.1.7.
