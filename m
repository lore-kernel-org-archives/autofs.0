From: Ian Kent <raven@themaw.net>
Subject: Re: autofs / davfs
Date: Thu, 07 Jun 2007 20:29:10 +0800
Message-ID: <1181219350.6735.31.camel@raven.themaw.net>
References: <4104f1cf0705170218ua2b6bbdu8f1456193741cd65@mail.gmail.com>
	<x49ejkpur83.fsf@segfault.boston.devel.redhat.com>
	<4104f1cf0706062333j4a580702u150179ced475657f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4104f1cf0706062333j4a580702u150179ced475657f@mail.gmail.com>
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
To: Kevin Muller <k.muller@sideshowdigital.com>
Cc: autofs@linux.kernel.org

On Thu, 2007-06-07 at 09:33 +0300, Kevin Muller wrote:
> On 6/6/07, Jeff Moyer <jmoyer@redhat.com> wrote:
> > ==> On Thu, 17 May 2007 12:18:47 +0300, "Kevin Muller" <k.muller@sideshowdigital.com> said:
> >
> > Kevin> autofs / davfs
> > Kevin> Im having a problem automounting a davfs share.
> > Kevin> The share is setup, and works perfect without the automount.
> > Kevin> but as soon as a 'ls' is done on the automount directory, and the autofs
> > Kevin> tries to mount it, it hangs for a while, then if ctrl-c's out of it, the
> > Kevin> next ls on that directory shows the files correctly.
> >
> > Kevin> The idea is to have the files available through Samba, and as soon as samba
> > Kevin> tries to access the folder it will be a webdav share that gets mounted at
> > Kevin> that point.
> >
> > Kevin> Any suggestions at this point will be helpful.
> >
> > I'm sorry, did we leave you hanging on this issue?  The last thing I
> > see in the discussion was this post from you:
> >
> > ,----
> > | mount(generic): calling mount -t davfs http://v6.muglets.com.dev/repos
> > | /home/automount/web.site.com
> > | May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs: no
> > | free coda device to mount
> > | May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs:
> > | trying fuse kernel file system
> > | May 21 15:56:22 devaccess automount[32663]: >> /sbin/mount.davfs: fuse
> > | device opened successfully
> > |
> > | >From this I deduce that the modules load, and the file system is put
> > | in place, and the autofs hangs before control is returned.
> > `----
> >
> > When you reproduce this, can you get the output from `ps auxwww | grep
> > mount` and post it here?  I'm wondering whether the mount command ever
> > returns.  Also, this looks to be just a snippet of the log.  Could you
> > include the rest of the logs, or tell us if this was the last thing
> > logged by automount?
> >
> > Thanks!
> >
> > Jeff
> >
> 
> I have set the logging to as verbose as possible, and the logging is
> rather long winded, I have included that, as well as the output from
> the ps.
> 
> [root@devaccess ~]# ps auxwww | grep mount
> root      7546  0.0  0.0  16584  1400 ?        Ssl  May31   0:02 automount
> root     11984  0.0  0.0   4368   928 pts/4    S+   09:13   0:00 ls
> --color=tty /home/automount/website/
> root     11986  0.0  0.0      0     0 ?        Z    09:13   0:00
> [mount] <defunct>

Does this defunct mount process remain after the davfs mount below
reports it is finished?

> davfs2   11988  0.0  0.0   6924   920 ?        Ss   09:13   0:00
> /sbin/mount.davfs http://website.com.dev/repos /home/automount/website
> -o rw
> root     11996  0.0  0.0   3880   664 pts/5    R+   09:14   0:00 grep mount
> 
> *** File: /var/log/debug
> Jun  7 09:13:53 devaccess automount[7546]: handle_packet: type = 3
> Jun  7 09:13:53 devaccess automount[7546]:
> handle_packet_missing_indirect: token 39, name website, request pid
> 11984
> Jun  7 09:13:53 devaccess automount[7546]: lookup_mount: lookup(file):
> looking up website
> Jun  7 09:13:53 devaccess automount[7546]: lookup_mount: lookup(file):
> website -> -fstype=davfs http://website.com.dev/repos
> Jun  7 09:13:53 devaccess automount[7546]: parse_mount: parse(sun):
> expanded entry: -fstype=davfs       http://website.com.dev/repos
> Jun  7 09:13:53 devaccess automount[7546]: parse_mount: parse(sun):
> gathered options: fstype=davfs
> Jun  7 09:13:53 devaccess automount[7546]: parse_mount: parse(sun):
> dequote("http://website.com.dev/repos") ->
> http://website.com.dev/repos
> Jun  7 09:13:53 devaccess automount[7546]: parse_mount: parse(sun):
> core of entry: options=fstype=davfs, loc=http://website.com.dev/repos
> Jun  7 09:13:53 devaccess automount[7546]: sun_mount: parse(sun):
> mounting root /home/automount, mountpoint website, what
> http://website.com.dev/repos, fstype davfs, options
> Jun  7 09:13:53 devaccess automount[7546]: open_mount: (mount):cannot
> open mount module davfs (/usr/lib/autofs/mount_davfs.so: cannot open
> shared object file: No such file or directory)
> Jun  7 09:13:53 devaccess automount[7546]: do_mount:
> http://website.com.dev/repos /home/automount/website type davfs
> options  using module generic
> Jun  7 09:13:53 devaccess automount[7546]: mount_mount:
> mount(generic): calling mkdir_path /home/automount/website
> Jun  7 09:13:53 devaccess automount[7546]: mount_mount:
> mount(generic): calling mount -t davfs http://website.com.dev/repos
> /home/automount/website
> Jun  7 09:14:00 devaccess automount[7546]: st_expire: state 1 path
> /home/automount
> Jun  7 09:14:00 devaccess automount[7546]: expire_proc: exp_proc =
> 3079506832 path /home/automount
> Jun  7 09:14:00 devaccess automount[7546]: expire_proc_indirect:
> expire /home/automount/website
> Jun  7 09:14:01 devaccess automount[7546]: expire_proc_indirect: 1
> remaining in /home/automount
> Jun  7 09:14:01 devaccess automount[7546]: expire_cleanup: got thid
> 3079506832 path /home/automount stat 2
> Jun  7 09:14:01 devaccess automount[7546]: expire_cleanup: sigchld:
> exp 3079506832 finished, switching from 2 to 1
> Jun  7 09:14:01 devaccess automount[7546]: st_ready: st_ready(): state
> = 2 path /home/automount
> 
> 
> *** File: /var/log/messages
> Jun  7 09:13:53 devaccess automount[7546]: open_mount: (mount):cannot
> open mount module davfs (/usr/lib/autofs/mount_davfs.so: cannot open
> shared object file: No such file or directory)
> Jun  7 09:13:53 devaccess mount.davfs: Parsing command line
> Jun  7 09:13:53 devaccess mount.davfs:   /sbin/mount.davfs
> http://website.com.dev/repos /home/automount/website -o rw
> Jun  7 09:13:53 devaccess mount.davfs:   URL: http://website.com.dev/repos
> Jun  7 09:13:53 devaccess mount.davfs:   Mount point: /home/automount/website
> Jun  7 09:13:53 devaccess mount.davfs: Checking for setuid
> Jun  7 09:13:53 devaccess mount.davfs: Parsing configuration files
> Jun  7 09:13:53 devaccess mount.davfs:   Reading config from
> Jun  7 09:13:53 devaccess mount.davfs:     /usr/local/etc/davfs2/davfs2.conf.
> Jun  7 09:13:53 devaccess mount.davfs:   Arguments after parsing config files:
> Jun  7 09:13:53 devaccess mount.davfs:     dav_user = davfs2
> Jun  7 09:13:53 devaccess mount.davfs:     dav_group = davfs2
> Jun  7 09:13:53 devaccess mount.davfs:     ignore_home = 1
> Jun  7 09:13:53 devaccess mount.davfs:     conf = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     user = 0
> Jun  7 09:13:53 devaccess mount.davfs:     netdev = 1
> Jun  7 09:13:53 devaccess mount.davfs:     mopts = 0xc0ed0006
> Jun  7 09:13:53 devaccess mount.davfs:     add_mopts = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     kernel_fs = fuse
> Jun  7 09:13:53 devaccess mount.davfs:     buf_size = 32 KiBytes
> Jun  7 09:13:53 devaccess mount.davfs:     uid = 0
> Jun  7 09:13:53 devaccess mount.davfs:     gid = 0
> Jun  7 09:13:53 devaccess mount.davfs:     dir_umask = 06000
> Jun  7 09:13:53 devaccess mount.davfs:     file_umask = 06000
> Jun  7 09:13:53 devaccess mount.davfs:     dir_mode = 040755
> Jun  7 09:13:53 devaccess mount.davfs:     file_mode = 0100644
> Jun  7 09:13:53 devaccess mount.davfs:     scheme = http
> Jun  7 09:13:53 devaccess mount.davfs:     host = website.com.dev
> Jun  7 09:13:53 devaccess mount.davfs:     port = 80
> Jun  7 09:13:53 devaccess mount.davfs:     path = /repos/
> Jun  7 09:13:53 devaccess mount.davfs:     servercert = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     secrets = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     clicert = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     p_host = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     p_port = 8080
> Jun  7 09:13:53 devaccess mount.davfs:     useproxy = 0
> Jun  7 09:13:53 devaccess mount.davfs:     askauth = 0
> Jun  7 09:13:53 devaccess mount.davfs:     displayname = 1
> Jun  7 09:13:53 devaccess mount.davfs:     locks = 0
> Jun  7 09:13:53 devaccess mount.davfs:     expect100 = 1
> Jun  7 09:13:53 devaccess mount.davfs:     read_timeout = 10 s
> Jun  7 09:13:53 devaccess mount.davfs:     server_charset = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     sys_cache = /var/cache/davfs2
> Jun  7 09:13:53 devaccess mount.davfs:     cache_dir = /var/cache/davfs2
> Jun  7 09:13:53 devaccess mount.davfs:     backup_dir = lost+found
> Jun  7 09:13:53 devaccess mount.davfs:     cache_size = 50 MiByte
> Jun  7 09:13:53 devaccess mount.davfs:     table_size = 1024
> Jun  7 09:13:53 devaccess mount.davfs:     idle_time = 10 s
> Jun  7 09:13:53 devaccess mount.davfs:     dir_refresh = 60 s
> Jun  7 09:13:53 devaccess mount.davfs:     file_refresh = 1 s
> Jun  7 09:13:53 devaccess mount.davfs:     gui_optimize = 0
> Jun  7 09:13:53 devaccess mount.davfs:     retry = 30 s
> Jun  7 09:13:53 devaccess mount.davfs:     max_retry = 300 s
> Jun  7 09:13:53 devaccess mount.davfs:     lock_timeout = 1800 s
> Jun  7 09:13:53 devaccess mount.davfs:     lock_refresh = 60 s
> Jun  7 09:13:53 devaccess mount.davfs:     lock_owner = (null)
> Jun  7 09:13:53 devaccess mount.davfs: Checking mount point
> Jun  7 09:13:53 devaccess mount.davfs:   Mountpoint: /home/automount/website
> Jun  7 09:13:53 devaccess mount.davfs: Checking directories
> Jun  7 09:13:53 devaccess mount.davfs: Mounts in /proc/mounts
> Jun  7 09:13:53 devaccess mount.davfs: Checking permissions
> Jun  7 09:13:53 devaccess mount.davfs: Parsing secrets files
> Jun  7 09:13:53 devaccess mount.davfs:   Reading secrets from
> Jun  7 09:13:53 devaccess mount.davfs:     /usr/local/etc/davfs2/secrets.
> Jun  7 09:13:53 devaccess mount.davfs:   Credentials:
> Jun  7 09:13:53 devaccess mount.davfs:     username = samba
> Jun  7 09:13:53 devaccess mount.davfs:     passord = *******
> Jun  7 09:13:53 devaccess mount.davfs:     p_user = (null)
> Jun  7 09:13:53 devaccess mount.davfs:     p_passord = (null)
> Jun  7 09:13:53 devaccess mount.davfs: Checking for double mounts
> Jun  7 09:13:53 devaccess mount.davfs: PID file:
> /var/run/mount.davfs/home-automount-website.pid
> Jun  7 09:13:53 devaccess mount.davfs: Changing persona:
> Jun  7 09:13:53 devaccess mount.davfs:   euid 501, gid 500
> Jun  7 09:13:53 devaccess mount.davfs: Initialize WebDAV-session
> Jun  7 09:13:53 devaccess mount.davfs: Initialize Cache
> Jun  7 09:13:53 devaccess mount.davfs:   Alignment of dav_node: 8
> Jun  7 09:13:53 devaccess mount.davfs:   Checking cache directory.
> Jun  7 09:13:54 devaccess mount.davfs:
> /var/cache/davfs2/website.com.dev-repos+home-automount-website+root
> Jun  7 09:13:54 devaccess mount.davfs:   New node: (nil)->0x8104b18
> Jun  7 09:13:54 devaccess mount.davfs:   Reading stored cache data.
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x8104bf8
> Jun  7 09:13:54 devaccess mount.davfs:   Neon wants creditentials for
> website.com.dev.
> Jun  7 09:13:54 devaccess mount.davfs:   PROPFIND /repos/
> Jun  7 09:13:54 devaccess mount.davfs:   PROPFIND: 207 Multi-Status
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810d3f8
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/rl/"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810c2c8
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/litmus/"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810c328
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/index.html"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810c388
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/autohandler.html"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810d490
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/RSS/"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810d4f0
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/autohandler"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810d550
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/_conf/"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810d5b0
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/EN/"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x810d878
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/dhandler"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x81053e0
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/_assets/"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x8105440
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/printerFriendly.mhtml"
> Jun  7 09:13:54 devaccess mount.davfs:   New node: 0x8104b18->0x81054a0
> Jun  7 09:13:54 devaccess mount.davfs:     "/repos/groups/"
> Jun  7 09:13:54 devaccess mount.davfs:   Directory updated: (nil)->0x8104b18
> Jun  7 09:13:54 devaccess mount.davfs:   "/repos/"
> Jun  7 09:13:54 devaccess mount.davfs: Initialize kernel interface
> Jun  7 09:13:54 devaccess mount.davfs: Fork into daemon mode
> Jun  7 09:13:54 devaccess mount.davfs: Set signal handler
> Jun  7 09:13:54 devaccess mount.davfs: Parent: parent pid: 11987,
> child pid: 11988
> Jun  7 09:13:54 devaccess mount.davfs: Releasing root privileges
> Jun  7 09:13:54 devaccess mount.davfs: Parent: writing mtab entry
> Jun  7 09:13:54 devaccess mount.davfs: Writing pid file
> Jun  7 09:13:54 devaccess mount.davfs: Parent: leaving now	<- Note*
> this shows the davfs parent is complete.
> ---------------------------------------------
> All the messages after this show while the ls command has not
> returned, and continues to show while the daemon runs.
> ---------------------------------------------
> Jun  7 09:13:54 devaccess mount.davfs: Starting message loop
> Jun  7 09:13:54 devaccess mount.davfs: FUSE_INIT:
> Jun  7 09:13:54 devaccess mount.davfs:   return: OK
> Jun  7 09:14:00 devaccess mount.davfs: FUSE_GETATTR:
> Jun  7 09:14:00 devaccess mount.davfs:   n 0x8104b18
> Jun  7 09:14:00 devaccess mount.davfs:   "/repos/"
> Jun  7 09:14:00 devaccess mount.davfs:   return: OK
> Jun  7 09:14:00 devaccess mount.davfs: FUSE_GETATTR:
> Jun  7 09:14:00 devaccess mount.davfs:   n 0x8104b18
> Jun  7 09:14:00 devaccess mount.davfs:   "/repos/"
> Jun  7 09:14:00 devaccess mount.davfs:   return: OK
> Jun  7 09:14:05 devaccess mount.davfs: TIDY_CACHE: from index 0
> Jun  7 09:14:05 devaccess mount.davfs:               to index 1023
> 
> 
> I don't understand why it does not return correctly, yet on its own
> without the autofs, it works perfect.
> 
> Thank you,
> Kevinm
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
