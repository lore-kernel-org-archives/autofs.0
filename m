From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Program map and submount problem
Date: Fri, 23 Jan 2004 13:20:24 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <F573AEE6-4DE9-11D8-9249-000A95A011F0@qualcomm.com>
References: <Pine.LNX.4.44.0401232049020.4706-100000@raven.themaw.net>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0401232049020.4706-100000@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On Jan 23, 2004, at 12:38 PM, mmarion@qualcomm.com wrote:

> The -Dpref= option is a leftover from the original autofsv3 script, I
> believe.  I'm trying a test without that to see if it makes any
> difference but I doubt it.  Also going to strace the daemon on the
> submount point to see what it does before quitting.

Ok, I did a strace of the dameons on
/usr/local/projects/some/automount and ./submount
It appears that the daemon on .../submount does, in fact, try to umount 
itself after the NFS mounts are expired, without checking to see if 
it's path is busy, and when the umount fails, it simply tries to do an 
rmdir and then exits, even though this bit of code in automount.c seems 
to indicate that if umount fails it should stay runnnig:

~line 562:
                        case ST_PRUNE:
                                 /* If we're a submount and we've just
                                    pruned or expired everything away,
                                    try to shut down */
                                 if (submount && success && ap.state != 
ST_SHUTDOWN) {
                                         next = ST_SHUTDOWN_PENDING;
                                         break;
                                 }
                                 /* FALLTHROUGH */

                         case ST_READY:
                                 next = ST_READY;
                                 break;

                         case ST_SHUTDOWN_PENDING:
                                 next = ST_SHUTDOWN;

[This doesn't appear to be happening, even though umount fails]
                           /* Failed shutdown returns to ready */
                                 if (!success) {
                                         syslog(LOG_WARNING,
                                                "shutdown failed: 
filesystem %s still busy",
                                                ap.path);
                                         alarm(ap.exp_runfreq);
                                         next = ST_READY;
                                 }
                                 break;

====

This subroutine appears to be called, even though the submount wasn't 
umounted, since it's where the log entry
Jan 23 12:46:22 linux-glab-1 automount[31939]: failed to remove dir 
/usr/local/projects/some/automount/submount: Device or resource busy
seems to be coming from:

static void cleanup_exit(const char *path, int exit_code)
{
         if (ap.lookup)
                 close_lookup(ap.lookup);

         if (pid_file)
                 unlink(pid_file);

         closelog();

         if ((!ap.ghost || !submount) && *(path + 1) != '-')
                 if (rmdir(path) == -1)
                         syslog(LOG_WARNING, "failed to remove dir %s: 
%m", path);

         exit(exit_code);
}

====

here's strace at important part btw:

2987  oldumount("/usr/local/projects/some/automount/submount") = -1 
EBUSY (Device or resource busy)
2987  lstat64("/etc/mtab", {st_mode=S_IFREG|0644, st_size=1007, ...}) = 
0
2987  open("/etc/mtab", O_RDWR|O_CREAT|O_LARGEFILE, 0644) = 3
2987  close(3)                          = 0
2987  write(2, "umount: /usr/local/projects/some/"..., 63) = 63
31939 <... read resumed> "umount: /usr/local/projects/some/"..., 2047) 
= 63
2987  _exit(1)                          = ?
31939 time([1074890782])                = 1074890782
31939 getpid()                          = 31939
31939 rt_sigaction(SIGPIPE, {0x420e46d0, [], 0x4000000}, {0x804a318, 
[HUP USR1 USR2 ALRM TERM], SA_RESTART|SA_ONESHOT|0x4000000}, 8) = 0
31939 send(3, "<31>Jan 23 12:46:22 automount[31"..., 103, 0) = 103
31939 rt_sigaction(SIGPIPE, {0x804a318, [HUP USR1 USR2 ALRM TERM], 
SA_RESTART|SA_ONESHOT|0x4000000}, NULL, 8) = 0
31939 read(4, "", 2047)                 = 0
31939 close(4)                          = 0
31939 wait4(2987, [WIFEXITED(s) && WEXITSTATUS(s) == 1], 0, NULL) = 2987
31939 rt_sigprocmask(SIG_SETMASK, [HUP USR1 USR2 ALRM TERM], NULL, 8) = 
0
31939 --- SIGCHLD (Child exited) ---
31939 wait4(-1, 0xbfffeaec, WNOHANG, NULL) = -1 ECHILD (No child 
processes)
31939 sigreturn()                       = ? (mask now [HUP USR1 USR2 
ALRM TERM])
31939 unlink("/var/lock/autofs")        = 0
31939 stat64("/usr/local/projects/some/automount/submount", 
{st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
31939 time([1074890782])                = 1074890782
31939 getpid()                          = 31939
31939 rt_sigaction(SIGPIPE, {0x420e46d0, [], 0x4000000}, {0x804a318, 
[HUP USR1 USR2 ALRM TERM], SA_RESTART|SA_ONESHOT|0x4000000}, 8) = 0
31939 send(3, "<27>Jan 23 12:46:22 automount[31"..., 91, 0) = 91
31939 rt_sigaction(SIGPIPE, {0x804a318, [HUP USR1 USR2 ALRM TERM], 
SA_RESTART|SA_ONESHOT|0x4000000}, NULL, 8) = 0
31939 time([1074890782])                = 1074890782
31939 getpid()                          = 31939
31939 rt_sigaction(SIGPIPE, {0x420e46d0, [], 0x4000000}, {0x804a318, 
[HUP USR1 USR2 ALRM TERM], SA_RESTART|SA_ONESHOT|0x4000000}, 8) = 0
31939 send(3, "<30>Jan 23 12:46:22 automount[31"..., 94, 0) = 94
31939 rt_sigaction(SIGPIPE, {0x804a318, [HUP USR1 USR2 ALRM TERM], 
SA_RESTART|SA_ONESHOT|0x4000000}, NULL, 8) = 0
31939 munmap(0x4001b000, 14688)         = 0
31939 munmap(0x40017000, 14024)         = 0
31939 munmap(0x40014000, 9340)          = 0
31939 close(3)                          = 0
31939 rmdir("/usr/local/projects/some/automount/submount") = -1 EBUSY 
(Device or resource busy)
31939 time([1074890782])                = 1074890782



-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Drew: "Violence doesn't solve anything? World War I. World War II. Star 
Wars.
every Super Bowl. Who says violence doesn't solve anything?!" ==> Drew 
Cary Show
