From: Sebastian Hetze <s.hetze@linux-ag.com>
Subject: autmount hangs occasionally on bind-mounts
Date: Mon, 27 Sep 2010 07:55:16 +0200
Message-ID: <20100927055516.493C39802E@mail.linux-ag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi *,

we are suffering from some sort of race condition that causes
automount to hang:

[351841.568061] INFO: task automount:22055 blocked for more than 120 second=
s.
[351841.568689] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables=
 this message.
[351841.569717] automount     D b983e7f6     0 22055      1 0x00000000
[351841.570252]  e0ca7ef4 00000082 f3c38000 b983e7f6 00013fde eaed6000 f63a=
f880 f5037c00
[351841.571308]  c0863320 c0863320 f30de480 f30de718 c5589320 00000002 b984=
1648 00013fde
[351841.572316]  f30de718 f72ceff4 f72ceff0 ffffffff e0ca7f20 c059fd3e e0ca=
7f14 f30de480
[351841.573364] Call Trace:
[351841.573686]  [<c059fd3e>] __mutex_lock_slowpath+0xbe/0x120
[351841.574130]  [<c059fc60>] mutex_lock+0x20/0x40
[351841.574496]  [<c0202732>] do_rmdir+0x52/0xe0
[351841.574878]  [<c04b67ad>] ? sys_socketcall+0x1cd/0x2a0
[351841.575266]  [<c0202820>] sys_rmdir+0x10/0x20
[351841.575781]  [<c010968c>] syscall_call+0x7/0xb

The error occurs occasionally, sometimes after one day, sometimes after
one week. It occurs with all kind of kernel versions and with all kind
of automount. Currently we are running autofs 5.0.4 and kernel
2.6.31-22-generic-pae from ubuntu.

I have tried to find out whats going wrong and have come
to the suspicion, that this might be a systematic problem
with automount.

In the failing system we are running automount locally, so automount
uses bind-mounts to make file system branches accessable somewhere
else.

The blocking sys_rmdir happens on such an bind-mount. =


It appears that the bind-mount can be unmounted regardless how
many open files there are. Since the open files live on the
"real file system" there seems to be no notion of usage for
the bind mountpoint neither in automount nor in the kernel.

So what i suspect to happen is the automount tries to umount
the branch after the timeout has passed, the umount succeeds
although there are open files, automount proceeds with
removing the directory but before the sys_rmdir succeeds
occasionally one of the processes having open files on
the branch accesses this file/directory causing the kernel
to hang.

Is this a valid explanation? Can you accept this as an bug
and do something about it...

Best regards,

  Sebastian
-- =

Sebastian Hetze
Linux Information Systems AG
Bundesallee 93, D-12161 Berlin

Fon: +49 30 818686-45, Fax: +49 30 818686-78
s.hetze@linux-ag.com, http://www.linux-ag.com
----------------------------------------------------------
Sitz der Gesellschaft: Putzbrunner Str. 71, 81739 M=FCnchen
Amtsgericht M=FCnchen: HRB 128 019
Vorstand: Rudolf Strobl
Aufsichtsrat: Michael Tarabochia (Vorsitzender)
