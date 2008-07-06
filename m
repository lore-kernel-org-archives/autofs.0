From: Ian Kent <raven@themaw.net>
Subject: Re: autofs errors - expire_cleanup, st_expire, etc.
Date: Sun, 06 Jul 2008 14:53:58 +0800
Message-ID: <1215327239.3073.164.camel@raven.themaw.net>
References: <bb02c53c0806272135m3958f08el6adecac4aea5c15a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <bb02c53c0806272135m3958f08el6adecac4aea5c15a@mail.gmail.com>
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
To: Darren Gitelman <d.gitelman@gmail.com>
Cc: autofs@linux.kernel.org


On Fri, 2008-06-27 at 23:35 -0500, Darren Gitelman wrote:
> Within the last 2 weeks automount has started to generate thousands of
> errors (about every 10-15 secs) in the system log (/var/log/messages).
> The directories all seem to mount properly but all these error
> messages must be having some impact. I cannot find anything about
> this. Turning off autofs stops the errors. I have the exact same
> configuration and program versions on 2 other machines, but don't see
> these errors. 
> 
> Any help appreciated.
> 
> 
> Jun 27 16:21:47 mistral automount[3353]: st_ready: st_ready(): state =
> 2 path /-
> Jun 27 16:21:47 mistral automount[3353]: st_ready: st_ready(): state =
> 2 path /home/users
> Jun 27 16:22:02 mistral automount[3353]: st_expire: state 1 path /-
> Jun 27 16:22:02 mistral automount[3353]: expire_proc: exp_proc =
> 3081669520 path /-
> Jun 27 16:22:02 mistral automount[3353]: expire_cleanup: got thid
> 3081669520 path /- stat 0
> Jun 27 16:22:02 mistral automount[3353]: expire_cleanup: sigchld: exp
> 3081669520 finished, switching from 2 to 1
> Jun 27 16:22:02 mistral automount[3353]: st_ready: st_ready(): state =
> 2 path /-
> Jun 27 16:22:17 mistral automount[3353]: st_expire: state 1
> path /home/users
> Jun 27 16:22:17 mistral automount[3353]: expire_proc: exp_proc =
> 3081669520 path /home/users
> Jun 27 16:22:17 mistral automount[3353]: st_expire: state 1 path /-
> Jun 27 16:22:17 mistral automount[3353]: expire_proc: exp_proc =
> 3078917008 path /-
> Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: got thid
> 3081669520 path /home/users stat 0
> Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: sigchld: exp
> 3081669520 finished, switching from 2 to 1
> Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: got thid
> 3078917008 path /- stat 0
> Jun 27 16:22:17 mistral automount[3353]: expire_cleanup: sigchld: exp
> 3078917008 finished, switching from 2 to 1
> 
> [root@mistral log]$ automount --version
> Linux automount version 5.0.1-0.rc2.88
> 
> Directories:
>         config dir:     /etc/sysconfig
>         maps dir:       /etc
>         modules dir:    /usr/lib/autofs
> 
> Compile options:
>   DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS WITH_HESIOD
> WITH_LDAP 
>   WITH_SASL 
> 
> The /etc/sysconfig/autofs file contains all default entries.

No, it doesn't.

This is debug logging output.
You have LOGGING="debug" or DEFAULT_LOGGING="debug" in your
configuration which isn't the default.

You have also increased the syslog log level for facility daemon.

Ian
