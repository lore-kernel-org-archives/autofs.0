From: "idiot)_) supreme" <ejw50@hotmail.com>
Subject: autofs default behavior on syminks?
Date: Sat, 10 Apr 2004 13:53:36 +0000
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Sea2-F21JTYxUARaYlF0005b05e@hotmail.com>
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
Content-Type: text/plain; format=flowed; charset="windows-1252"
To: autofs@linux.kernel.org

Hi all

We are running autofs4.1.0 with 2.4.22 on about 100 machines, and 2.6.5 o=
n=20
about 100 machines with all of the the kernel patches for both.


What is autofs's behavior trying to cross symlinks when you type 'ls'? =20
autofs seems to time out a lot faster than AMD for example.

We are occasionally seeing problems timeouts trying to cross symlinks.  I=
f I=20
type 'ls' it might show

abc -> /net/emc/u11

as a broken symlink

but if I type 'ls /net/emc/u11'
the symlink comes back.



My auto.master line contains
/net/emc auto.emc --timeout 3600 --ghost

my auto.emc line contains

u11=20
-rw,hard,intr,wsize=3D32768,rsize=3D32768,vers=3D3,proto=3Dtcp,retry=3D20=
00,timeo=3D1000,retrans=3D500=20
emc1.bbn.com:/&

I know some of these options do not apply for 'tcp', but I did not know h=
ow=20
autofs treated broken symlinks.  I am not sure if this is an nfs problem =
or=20
an automount problem.  Any insight would be appreciated.


Thanks


Eric

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar =96 get it now!=20
http://toolbar.msn.com/go/onm00200415ave/direct/01/
