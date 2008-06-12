From: Ian Kent <raven@themaw.net>
Subject: Re: automount ignores remote logins
Date: Thu, 12 Jun 2008 20:24:34 +0800
Message-ID: <1213273474.4994.109.camel@raven.themaw.net>
References: <20080612111400.pq5zr4r14cwgk44s@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612111400.pq5zr4r14cwgk44s@webmail.df.eu>
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
To: Max Harvest <max_h@limbus.net>
Cc: autofs@linux.kernel.org


On Thu, 2008-06-12 at 11:14 +0200, Max Harvest wrote:
> Ian Kent wrote:
> 
> >
> > Do this on a test machine:
> >
> > Ensure autofs debug logging is enabled.
> done
> > With autofs stopped (obviously you need to log into an account that
> > doesn't use automounted directories).
> > Check that no automount related mounts are active by
> > inspecting /proc/mounts.
> done, no automount entries in /proc/mounts
> > Start autofs.
> this is the output:
> Jun  12 10:11:22 node061 automount[2274]: Starting automounter version  
> 5.0.2, master map auto.master
> Jun  12 10:11:22 node061 automount[2274]: using kernel protocol version 5.00
> Jun  12 10:11:22 node061 automount[2274]: lookup_nss_read_master:  
> reading master nis auto.master
> Jun  12 10:11:22 node061 automount[2274]: lookup_init: lookup(yp):  
> ctxt->mapname=auto.master
> Jun  12 10:11:22 node061 automount[2274]: parse_init: parse(sun): init  
> gathered global options: (null)
> Jun  12 10:11:22 node061 automount[2274]: mount_init: mount(bind):  
> bind_works = 1
> 
> > Attempt to log in from a remote machine using an account that does use
> > an automounted directory.
> this is the output:
> Jun  12 10:11:53 node061 sshd[2304]: Accepted keyboard-interactive/pam  
> for maxh from 192.168.0.250 port 44822 ssh2
> I can log in, but have no home. There is no output from automount.
> 
> > Attempt to log in locally using an account that does use an automounted
> > directory.
> works (as allready posted), the account name is "maxh" this is the output:
> Jun  12 10:17:07 node061 automount[2274]: master_do_mount: mounting /users
> Jun  12 10:17:07 node061 automount[2274]: lookup_nss_read_map: reading  
> map yp auto.users
> Jun  12 10:17:07 node061 automount[2274]: lookup_init: lookup(yp):  
> ctxt->mapname=auto.users
> Jun  12 10:17:07 node061 automount[2274]: parse_init: parse(sun): init  
> gathered global options: (null)
> Jun  12 10:17:07 node061 automount[2274]: mount_init: mount(bind):  
> bind_works = 1
> Jun  12 10:17:07 node061 automount[2274]: mounted indirect mount on  
> /users with timeout 600, freq 150 seconds
> Jun  12 10:17:07 node061 automount[2274]: ghosting enabled
> Jun  12 10:17:12 node061 automount[2274]: handle_packet: type = 3
> Jun  12 10:17:12 node061 automount[2274]:  
> handle_packet_missing_indirect: token 1, name maxh, request pid 2325
> Jun  12 10:17:12 node061 automount[2274]: attempting to mount entry  
> /users/maxh
> Jun  12 10:17:12 node061 automount[2274]: lookup_mount: lookup(file):  
> looking up maxh
> Jun  12 10:17:12 node061 automount[2274]: lookup_mount: lookup(file):  
> maxh -> bootserver:/home/maxh
> Jun  12 10:17:12 node061 automount[2274]: parse_mount: parse(sun):  
> expanded entry: bootserver:/home/maxh
> Jun  12 10:17:12 node061 automount[2274]: parse_mount: parse(sun):  
> gathered options: fstype=nfs,soft,intr
> Jun  12 10:17:12 node061 automount[2274]: parse_mount: parse(sun):  
> dequote("bootserver:/home/maxh") -> bootserver:/home/maxh
> Jun  12 10:17:12 node061 automount[2274]: parse_mount: parse(sun):  
> core of entry: options=fstype=nfs,soft,intr, loc=bootserver:/home/maxh
> Jun  12 10:17:12 node061 automount[2274]: sun_mount: parse(sun):  
> mounting root /users, mountpoint maxh, what bootserver:/home/maxh,  
> fstype nfs, options soft,intr
> Jun  12 10:17:12 node061 automount[2274]: mount_mount: mount(nfs):  
> root=/users name=maxh what=bootserver:/home/maxh, fstype=nfs,  
> options=soft,intr
> Jun  12 10:17:12 node061 automount[2274]: mount_mount: mount(nfs): nfs  
> options="soft,intr", nosymlink=0, ro=0
> Jun  12 10:17:12 node061 automount[2274]: mount_mount: mount(nfs):  
> calling mkdir_path /users/maxh
> Jun  12 10:17:12 node061 automount[2274]: mount_mount: mount(nfs):  
> calling mount -t nfs -s -o soft,intr bootserver:/home/maxh /users/maxh
> Jun  12 10:17:12 node061 automount[2274]: Version 1.1.0 Starting
> Jun  12 10:17:12 node061 automount[2274]: Flags:
> Jun  12 10:17:12 node061 automount[2274]: statd running as root. chown  
> /var/lib/nfs/sm to choose different user
> Jun  12 10:17:12 node061 automount[2274]: mount(nfs): mounted  
> bootserver:/home/maxh on /users/maxh
> Jun  12 10:17:12 node061 automount[2274]: send_ready: token = 1
> Jun  12 10:17:12 node061 automount[2274]: mounted /users/maxh
> 
> > Log both sessions out.
> done. The output from remote session:
> Jun  12 10:19:49 node061 sshd[2348]: PAM audit_log_acct_message()  
> failed: Operation not permitted
> 
> > Stop autofs.
> works. This is the output:
> Jun  12 10:22:52 node061 automount[2274]: do_notify_state: signal 15
> Jun  12 10:22:52 node061 automount[2274]: master_notify_state_change:  
> sig 15 switching /users from 1 to 5
> Jun  12 10:22:52 node061 automount[2274]: st_prepare_shutdown: state 1  
> path /users
> Jun  12 10:22:52 node061 automount[2274]: expire_proc: exp_proc =  
> 1075984720 path /users
> Jun  12 10:22:52 node061 automount[2274]: expire_proc_indirect: expire  
> /users/maxh
> Jun  12 10:22:52 node061 automount[2274]: handle_packet: type = 4
> Jun  12 10:22:52 node061 automount[2274]:  
> handle_packet_expire_indirect: token 2, name maxh
> Jun  12 10:22:52 node061 automount[2274]: expiring path /users/maxh
> Jun  12 10:22:52 node061 automount[2274]: umount_multi: path  
> /users/maxh incl 1
> Jun  12 10:22:52 node061 automount[2274]: unmounting dir = /users/maxh
> Jun  12 10:22:52 node061 automount[2274]: rm_unwanted_fn: removing  
> directory /users/maxh
> Jun  12 10:22:52 node061 automount[2274]: expired /users/maxh
> Jun  12 10:22:52 node061 automount[2274]: send_ready: token = 2
> Jun  12 10:22:53 node061 automount[2274]: expire_cleanup: got thid  
> 1075984720 path /users stat 0
> Jun  12 10:22:53 node061 automount[2274]: expire_cleanup: sigchld: exp  
> 1075984720 finished, switching from 5 to 7
> Jun  12 10:22:53 node061 automount[2274]: umount_multi: path /users incl 0
> Jun  12 10:22:53 node061 automount[2274]: rm_unwanted_fn: removing  
> directory /users/work
> Jun  12 10:22:53 node061 automount[2274]: umounted indirect mount /users
> Jun  12 10:22:53 node061 automount[2274]: shut down path /users
> 
> > Post resulting log here.
> see above.

No, this is not what I asked for.
Go through the procedure and post the log as a single unit.
Add comments about the activities that relate to timestamps in the log
but I want to see a single continuous log. If you have to post the log
as an attachment.

Ian
