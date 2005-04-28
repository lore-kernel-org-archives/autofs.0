From: Robert Swan <rswanster@gmail.com>
Subject: debug failed automount
Date: Thu, 28 Apr 2005 10:19:34 -0400
Message-ID: <11101302050428071921ec8bb7@mail.gmail.com>
Reply-To: Robert Swan <rswanster@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I'm trying to debug automount refusal to mount volumes.  The manual
mount works fine:

> ypcat -k auto.home | grep robert
robert remotehost:/export/users/car073/robert

then

> mount remotehost:/export/users/car073/robert /home/robert

and ls /home/robert works as expected. However, if I

> automount /var/autofs/home/ yp auto.home

and then try to ls /var/autofs/home/robert, I get 

ls:/var/autofs/home/robert: No such file or directory, 

and /var/log/syslog contains

localhost automount[23333]: failed to mount /var/autofs/home/robert

I've also verified that I'm able to automount locally exported
directories (using a "file" map, however).

One point is that the remote host is accessed through a VPN tunnel.

I've attached automount syslog entries using the -d and -v automount
command line options. I suspect "winner=(null)" is a clue but I have
no idea what it means.

Thanks for any help,
Robert

Apr 28 07:52:28 localhost automount[12608]: handle_packet: type = 0
Apr 28 07:52:28 localhost automount[12608]: handle_packet_missing:
token 4, name robert
Apr 28 07:52:28 localhost automount[12608]: attempting to mount entry
/var/autofs/home/robert
Apr 28 07:52:28 localhost automount[12617]: lookup(yp): looking up robert
Apr 28 07:52:28 localhost automount[12617]: ret = 1
Apr 28 07:52:28 localhost automount[12617]: lookup(yp): robert ->
remotehost:/export/users/car073/robert
Apr 28 07:52:28 localhost automount[12617]: parse(sun): expanded
entry: remotehost:/export/users/car073/robert
Apr 28 07:52:28 localhost automount[12617]: parse(sun): gathered options:
Apr 28 07:52:28 localhost automount[12617]: parse(sun):
dequote("remotehost:/export/users/car073/robert") ->
remotehost:/export/users/car073/robert
Apr 28 07:52:28 localhost automount[12617]: parse(sun): core of entry:
options=, loc=remotehost:/export/users/car073/robert
Apr 28 07:52:28 localhost automount[12617]: parse(sun): mounting root
/var/autofs/home, mountpoint robert, what
remotehost:/export/users/car073/robert, fstype nfs, options (null)
Apr 28 07:52:28 localhost automount[12617]: mount(nfs):
root=/var/autofs/home name=robert
what=remotehost:/export/users/car073/robert, fstype=nfs,
options=(null)
Apr 28 07:52:29 localhost automount[12617]: mount(nfs): winner =
(null) local = 0
Apr 28 07:52:29 localhost automount[12617]: mount(nfs): no host elected
Apr 28 07:52:29 localhost automount[12617]: failed to mount
/var/autofs/home/robert
Apr 28 07:52:29 localhost automount[12617]: umount_multi:
path=/var/autofs/home/robert incl=1
Apr 28 07:52:29 localhost automount[12617]: umount_multi: no mounts
found under /var/autofs/home/robert
Apr 28 07:52:29 localhost automount[12608]: handle_child: got pid
12617, sig 0 (0), stat 1
Apr 28 07:52:29 localhost automount[12608]: sig_child: found pending
iop pid 12617: signalled 0 (sig 0), exit status 1
Apr 28 07:52:29 localhost automount[12608]: send_fail: token=4
