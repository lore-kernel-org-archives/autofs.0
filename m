From: raven@themaw.net
Subject: Re: Program map and submount problem
Date: Sat, 24 Jan 2004 11:48:58 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0401241139160.1751@raven.themaw.net>
References: <F573AEE6-4DE9-11D8-9249-000A95A011F0@qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <F573AEE6-4DE9-11D8-9249-000A95A011F0@qualcomm.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Fri, 23 Jan 2004, Mike Marion wrote:

> 
> Ok, I did a strace of the dameons on
> /usr/local/projects/some/automount and ./submount
> It appears that the daemon on .../submount does, in fact, try to umount 
> itself after the NFS mounts are expired, without checking to see if 
> it's path is busy, and when the umount fails, it simply tries to do an 
> rmdir and then exits, even though this bit of code in automount.c seems 
> to indicate that if umount fails it should stay runnnig:
> 
> ~line 562:
>                         case ST_PRUNE:
>                                  /* If we're a submount and we've just
>                                     pruned or expired everything away,
>                                     try to shut down */
>                                  if (submount && success && ap.state != 
> ST_SHUTDOWN) {
>                                          next = ST_SHUTDOWN_PENDING;
>                                          break;
>                                  }
>                                  /* FALLTHROUGH */
> 
>                          case ST_READY:
>                                  next = ST_READY;
>                                  break;
> 
>                          case ST_SHUTDOWN_PENDING:
>                                  next = ST_SHUTDOWN;
> 
> [This doesn't appear to be happening, even though umount fails]
>                            /* Failed shutdown returns to ready */
>                                  if (!success) {
>                                          syslog(LOG_WARNING,
>                                                 "shutdown failed: 
> filesystem %s still busy",
>                                                 ap.path);
>                                          alarm(ap.exp_runfreq);
>                                          next = ST_READY;
>                                  }
>                                  break;

Good work Mike. This will help me alot. However I don't think the daemon 
actually gets to this point. Checking ....


> 
> ====
> 
> This subroutine appears to be called, even though the submount wasn't 
> umounted, since it's where the log entry
> Jan 23 12:46:22 linux-glab-1 automount[31939]: failed to remove dir 
> /usr/local/projects/some/automount/submount: Device or resource busy
> seems to be coming from:
> 
> static void cleanup_exit(const char *path, int exit_code)
> {
>          if (ap.lookup)
>                  close_lookup(ap.lookup);
> 
>          if (pid_file)
>                  unlink(pid_file);
> 
>          closelog();
> 
>          if ((!ap.ghost || !submount) && *(path + 1) != '-')
>                  if (rmdir(path) == -1)
>                          syslog(LOG_WARNING, "failed to remove dir %s: 
> %m", path);
> 
>          exit(exit_code);
> }

Called when the daemon pops out of the event loop.

Can be caused by umount failure. I saw something like this the other day 
and I've been meaning to return to it to try and find it.

Jim Carter would like this. I caused it by an incorect return from buffer 
overflow checking code. I think this problem is hitting the same bad error 
handling code. Looking ...

Ian
