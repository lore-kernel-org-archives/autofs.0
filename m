From: Cedric BRINER <work@infomaniak.ch>
Subject: automount lock
Date: Thu, 27 Apr 2006 16:40:18 +0200
Message-ID: <20060427144018.GA14670@obs.unige.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
Content-disposition: inline
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

Debian/Sarge i386
hi,

I'm having some problems with autofs.
1) is this map entry allowed for auto.master ?
  /home/epfl auto_home_vaud
  /home/vaud auto_home_vaud

2) I'm getting in this situtation
ps -efH
  ...
  root      6947     1  0 Feb13 ?        00:00:01   /usr/sbin/automount --pid-file=/var/run/autofs/_home_vaud.pid --timeout=300 --ghost /home/vaud yp auto_home_vaud
  root     32357  6947  0 09:44 ?        00:00:00     /usr/sbin/automount --pid-file=/var/run/autofs/_home_vaud.pid --timeout=300 --ghost /home/vaud yp auto_home_vaud
  root     32359 32357  0 09:44 ?        00:00:00       [mount] <defunct>
  root     15406  6947  0 11:29 ?        00:00:00     /usr/sbin/automount --pid-file=/var/run/autofs/_home_vaud.pid --timeout=300 --ghost /home/vaud yp auto_home_vaud
  ...

more /var/lock/autofs
32357

is this normal to have more than one automount process by auto.master entry ?


and now when I try to launch an other automount
/usr/sbin/automount -v --debug --pid-file=/var/run/autofs/_unige.pid --timeout=300 --ghost /unige yp auto_unige_linux

tail /var/log/daemon.log
Apr 27 16:35:05 obsdw19 automount[5500]: aquire_lock: can't lock lock file timed out: /var/lock/autofs
Apr 27 16:35:05 obsdw19 automount[5500]: failed to mount autofs path /unige
Apr 27 16:35:05 obsdw19 automount[5500]: /unige: mount failed!
Apr 27 16:35:05 obsdw19 automount[5500]: failed to remove dir /unige: No such file or directory
Apr 27 16:35:09 obsdw19 automount[5598]: starting automounter version 4.1.4_beta2, path = /unige, maptype = yp, mapname = auto_unige_linux
Apr 27 16:35:09 obsdw19 automount[5598]: mount(bind): bind_works = 1

the fact is that /home/vaud is the home directory for the user on this machine. So how can I restart the autofs without asking the user to logoff ?

Ced.

-- 

Cedric BRINER
Geneva - Switzerland
