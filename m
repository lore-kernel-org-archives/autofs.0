From: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: Problem with Automount 4.1.x
Date: Tue, 4 May 2004 09:44:40 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE718D45BB@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I'm experiencing an issue where automount v4.1.2 (before and after
the most current patch) will not mount NFS dirs.  I'm pasting an
"strace -f" of the automount process responsible for the automount
dir.

This happens when we boot the machine (tested on RHEL 3 and FC1).
It won't mount NFS dirs and will sometimes resolve itself (always
after restarting the automount processes).

In the case of the strace, the mountpoint I'm trying to get to is
"/software/OW12PL" which is defined in a yp map.  In messages I
see this:

May  4 09:06:25 houu30 automount[1842]: attempting to mount entry /software/OW12PL
May  4 09:06:36 houu30 automount[2763]: mount(nfs): no host elected
May  4 09:06:36 houu30 automount[2763]: failed to mount /software/OW12PL

The strace follows.

-Steve

1842  poll([{fd=4, events=POLLIN}, {fd=6, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1842  --- SIGALRM (Alarm clock) @ 0 (0) ---
1842  write(7, "\2\0\0\0", 4)           = 4
1842  sigreturn()                       = ? (mask now [])
1842  poll([{fd=4, events=POLLIN}, {fd=6, events=POLLIN, revents=POLLIN}], 2, -1) = 1
1842  read(6, "\2\0\0\0", 4)            = 4
1842  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [], 8) = 0
1842  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM CHLD], 8) = 0
1842  clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb75d7b08) = 4593
1842  rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM CHLD],  <unfinished ...>
4593  --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
1842  <... rt_sigprocmask resumed> NULL, 8) = 0
4593  --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
1842  rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM],  <unfinished ...>
4593  rt_sigprocmask(SIG_BLOCK, ~[RTMIN],  <unfinished ...>
1842  <... rt_sigprocmask resumed> NULL, 8) = 0
4593  <... rt_sigprocmask resumed> NULL, 8) = 0
1842  poll( <unfinished ...>
4593  rt_sigaction(SIGHUP, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGQUIT, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGILL, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGTRAP, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGABRT, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGBUS, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGFPE, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGKILL, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
4593  rt_sigaction(SIGUSR1, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGSEGV, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGUSR2, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGALRM, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGTERM, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGSTKFLT, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGCHLD, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGCONT, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGSTOP, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
4593  rt_sigaction(SIGTSTP, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGTTIN, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGTTOU, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGURG, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGXCPU, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGXFSZ, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGVTALRM, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGPROF, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGWINCH, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGIO, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGPWR, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGSYS, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_1, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_2, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_3, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_4, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_5, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_6, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_7, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_8, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_9, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_10, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_11, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_12, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_13, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_14, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_15, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_16, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_17, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_18, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_19, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_20, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_21, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_22, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_23, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_24, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_25, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_26, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_27, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_28, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_29, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_30, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_31, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGRT_32, {SIG_IGN}, NULL, 8) = 0
4593  rt_sigaction(SIGCHLD, {SIG_DFL}, NULL, 8) = 0
4593  rt_sigprocmask(SIG_UNBLOCK, ~[RTMIN], NULL, 8) = 0
4593  close(4)                          = 0
4593  close(6)                          = 0
4593  close(7)                          = 0
4593  getpriority(PRIO_PROCESS, 0)      = 20
4593  setpriority(PRIO_PROCESS, 0, -4)  = 0
4593  getpriority(PRIO_PROCESS, 0)      = 24
4593  lstat64("/software", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4593  open("/software", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
4593  fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4593  fcntl64(4, F_SETFD, FD_CLOEXEC)   = 0
4593  getdents64(4, /* 2 entries */, 4096) = 48
4593  getdents64(4, /* 0 entries */, 4096) = 0
4593  close(4)                          = 0
4593  ioctl(5, AUTOFS_IOC_EXPIRE_MULTI, 0xbfffd6dc) = -1 EAGAIN (Resource temporarily unavailable)
4593  lstat64("/software", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4593  open("/software", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
4593  fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4593  fcntl64(4, F_SETFD, FD_CLOEXEC)   = 0
4593  getdents64(4, /* 2 entries */, 4096) = 48
4593  getdents64(4, /* 0 entries */, 4096) = 0
4593  close(4)                          = 0
4593  exit_group(0)                     = ?
1842  <... poll resumed> [{fd=4, events=POLLIN}, {fd=6, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1842  --- SIGCHLD (Child exited) @ 0 (0) ---
1842  waitpid(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG) = 4593
1842  alarm(15)                         = 0
1842  waitpid(-1, 0xbfffd574, WNOHANG)  = -1 ECHILD (No child processes)
1842  write(7, "\1\0\0\0", 4)           = 4
1842  sigreturn()                       = ? (mask now [HUP USR1 USR2 ALRM TERM])
1842  poll([{fd=4, events=POLLIN}, {fd=6, events=POLLIN, revents=POLLIN}], 2, -1) = 1
1842  read(6, "\1\0\0\0", 4)            = 4
1842  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM], 8) = 0
1842  rt_sigprocmask(SIG_UNBLOCK, [HUP USR1 USR2 ALRM TERM CHLD], NULL, 8) = 0
1842  poll([{fd=4, events=POLLIN}, {fd=6, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1842  --- SIGALRM (Alarm clock) @ 0 (0) ---
1842  write(7, "\2\0\0\0", 4)           = 4
1842  sigreturn()                       = ? (mask now [])
1842  poll([{fd=4, events=POLLIN}, {fd=6, events=POLLIN, revents=POLLIN}], 2, -1) = 1
1842  read(6, "\2\0\0\0", 4)            = 4
1842  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [], 8) = 0
1842  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM CHLD], 8) = 0
1842  clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xb75d7b08) = 4659
1842  rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM CHLD],  <unfinished ...>
4659  --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
1842  <... rt_sigprocmask resumed> NULL, 8) = 0
4659  --- SIGSTOP (Stopped (signal)) @ 0 (0) ---
1842  rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM],  <unfinished ...>
4659  rt_sigprocmask(SIG_BLOCK, ~[RTMIN],  <unfinished ...>
1842  <... rt_sigprocmask resumed> NULL, 8) = 0
4659  <... rt_sigprocmask resumed> NULL, 8) = 0
1842  poll( <unfinished ...>
4659  rt_sigaction(SIGHUP, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGQUIT, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGILL, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGTRAP, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGABRT, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGBUS, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGFPE, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGKILL, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
4659  rt_sigaction(SIGUSR1, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGSEGV, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGUSR2, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGPIPE, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGALRM, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGTERM, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGSTKFLT, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGCHLD, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGCONT, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGSTOP, {SIG_IGN}, NULL, 8) = -1 EINVAL (Invalid argument)
4659  rt_sigaction(SIGTSTP, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGTTIN, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGTTOU, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGURG, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGXCPU, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGXFSZ, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGVTALRM, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGPROF, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGWINCH, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGIO, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGPWR, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGSYS, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_1, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_2, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_3, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_4, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_5, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_6, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_7, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_8, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_9, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_10, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_11, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_12, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_13, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_14, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_15, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_16, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_17, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_18, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_19, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_20, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_21, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_22, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_23, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_24, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_25, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_26, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_27, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_28, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_29, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_30, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_31, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGRT_32, {SIG_IGN}, NULL, 8) = 0
4659  rt_sigaction(SIGCHLD, {SIG_DFL}, NULL, 8) = 0
4659  rt_sigprocmask(SIG_UNBLOCK, ~[RTMIN], NULL, 8) = 0
4659  close(4)                          = 0
4659  close(6)                          = 0
4659  close(7)                          = 0
4659  getpriority(PRIO_PROCESS, 0)      = 20
4659  setpriority(PRIO_PROCESS, 0, -4)  = 0
4659  getpriority(PRIO_PROCESS, 0)      = 24
4659  lstat64("/software", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4659  open("/software", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
4659  fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4659  fcntl64(4, F_SETFD, FD_CLOEXEC)   = 0
4659  getdents64(4, /* 2 entries */, 4096) = 48
4659  getdents64(4, /* 0 entries */, 4096) = 0
4659  close(4)                          = 0
4659  ioctl(5, AUTOFS_IOC_EXPIRE_MULTI, 0xbfffd6dc) = -1 EAGAIN (Resource temporarily unavailable)
4659  lstat64("/software", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4659  open("/software", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
4659  fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
4659  fcntl64(4, F_SETFD, FD_CLOEXEC)   = 0
4659  getdents64(4, /* 2 entries */, 4096) = 48
4659  getdents64(4, /* 0 entries */, 4096) = 0
4659  close(4)                          = 0
4659  exit_group(0)                     = ?
1842  <... poll resumed> [{fd=4, events=POLLIN}, {fd=6, events=POLLIN}], 2, -1) = -1 EINTR (Interrupted system call)
1842  --- SIGCHLD (Child exited) @ 0 (0) ---
1842  waitpid(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 0], WNOHANG) = 4659
1842  alarm(15)                         = 0
1842  waitpid(-1, 0xbfffd574, WNOHANG)  = -1 ECHILD (No child processes)
1842  write(7, "\1\0\0\0", 4)           = 4
1842  sigreturn()                       = ? (mask now [HUP USR1 USR2 ALRM TERM])
1842  poll([{fd=4, events=POLLIN}, {fd=6, events=POLLIN, revents=POLLIN}], 2, -1) = 1
1842  read(6, "\1\0\0\0", 4)            = 4
1842  rt_sigprocmask(SIG_BLOCK, [HUP USR1 USR2 ALRM TERM CHLD], [HUP USR1 USR2 ALRM TERM], 8) = 0
1842  rt_sigprocmask(SIG_UNBLOCK, [HUP USR1 USR2 ALRM TERM CHLD], NULL, 8) = 0
1842  poll( <unfinished ...>
