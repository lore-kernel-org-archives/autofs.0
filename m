From: Aaron Straus <aaron@merfinllc.com>
Subject: Re: autofs does not umount
Date: Thu, 27 Aug 2009 17:15:46 -0700
Message-ID: <20090828001545.GA28811@merfinllc.com>
References: <20090827222825.GA23043@merfinllc.com>
	<20090827232753.GA26300@merfinllc.com>
	<4A971D47.3050503@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A971D47.3050503@themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, viro@zeniv.linux.org.uk

Hi,

On Aug 28 07:56 AM, Ian Kent wrote:
> That commit certainly looks OK, a straight conversion to use struct path.
> 
> How about a debug log from autofs so we can try to find out what bit is
> actually going wrong.

Sure.

This is auto.master:
/home	/etc/auto.home

This is auto.home:
aaron	:/srv/home/aaron

This is the syslog with the -d option to automount.  Below you'll see me
sending a USR1 signal to the automount process, but the umount not
happening.  After this I just umount /home/aaron by hand and then stop
automounter...

Aug 27 17:10:49 catfish automount[8460]: starting automounter version 4.1.4, path = /home, maptype = file, mapname = /etc/auto.home
Aug 27 17:10:49 catfish automount[8460]: mount(bind): bind_works = 1 
Aug 27 17:10:49 catfish automount[8460]: using kernel protocol version 4.01
Aug 27 17:10:49 catfish automount[8460]: using timeout 300 seconds; freq 75 secs
Aug 27 17:10:53 catfish automount[8460]: handle_packet: type = 0 
Aug 27 17:10:53 catfish automount[8460]: handle_packet_missing: token 78, name aaron 
Aug 27 17:10:53 catfish automount[8460]: attempting to mount entry /home/aaron
Aug 27 17:10:53 catfish automount[8466]: lookup(file): aaron -> :/srv/home/aaron
Aug 27 17:10:53 catfish automount[8466]: parse(sun): expanded entry: :/srv/home/aaron
Aug 27 17:10:53 catfish automount[8466]: parse(sun): gathered options: 
Aug 27 17:10:53 catfish automount[8466]: parse(sun): dequote("/srv/home/aaron") -> /srv/home/aaron
Aug 27 17:10:53 catfish automount[8466]: parse(sun): core of entry: options=, loc=/srv/home/aaron
Aug 27 17:10:53 catfish automount[8466]: parse(sun): mounting root /home, mountpoint aaron, what /srv/home/aaron, fstype nfs, options (null) 
Aug 27 17:10:53 catfish automount[8466]: mount(nfs): root=/home name=aaron what=/srv/home/aaron, fstype=nfs, options=(null)
Aug 27 17:10:53 catfish automount[8466]: mount(nfs): aaron is local, doing bind
Aug 27 17:10:53 catfish automount[8466]: mount(bind): calling mkdir_path /home/aaron
Aug 27 17:10:53 catfish automount[8466]: mount(bind): calling mount --bind -s  -o defaults /srv/home/aaron /home/aaron
Aug 27 17:10:53 catfish automount[8466]: mount(bind): mounted /srv/home/aaron type bind on /home/aaron
Aug 27 17:10:53 catfish automount[8460]: handle_child: got pid 8466, sig 0 (0), stat 0 
Aug 27 17:10:53 catfish automount[8460]: sig_child: found pending iop pid 8466: signalled 0 (sig 0), exit status 0
Aug 27 17:10:53 catfish automount[8460]: send_ready: token=78 
Aug 27 17:11:01 catfish automount[8460]: sig 10 switching from 1 to 3
Aug 27 17:11:01 catfish automount[8460]: get_pkt: state 1, next 3
Aug 27 17:11:01 catfish automount[8460]: st_prune(): state = 1 
Aug 27 17:11:01 catfish automount[8460]: signal_children: send 10 to process group 8460
Aug 27 17:11:01 catfish automount[8460]: expire_proc: exp_proc=8469
Aug 27 17:11:01 catfish automount[8469]: expire_proc: 1 remaining in /home 
Aug 27 17:11:01 catfish automount[8460]: handle_child: got pid 8469, sig 0 (0), stat 1 
Aug 27 17:11:01 catfish automount[8460]: sigchld: exp 8469 finished, switching from 3 to 1
Aug 27 17:11:01 catfish automount[8460]: get_pkt: state 3, next 1
Aug 27 17:11:01 catfish automount[8460]: st_ready(): state = 3 
Aug 27 17:11:10 catfish automount[8460]: sig 12 switching from 1 to 5
Aug 27 17:11:10 catfish automount[8460]: get_pkt: state 1, next 5
Aug 27 17:11:10 catfish automount[8460]: prep_shutdown: state = 1 
Aug 27 17:11:10 catfish automount[8460]: signal_children: send 12 to process group 8460
Aug 27 17:11:10 catfish automount[8460]: expire_proc: exp_proc=8485
Aug 27 17:11:10 catfish automount[8460]: prep_shutdown: expire returns 1 
Aug 27 17:11:10 catfish automount[8460]: handle_child: got pid 8485, sig 0 (0), stat 0 
Aug 27 17:11:10 catfish automount[8460]: sigchld: exp 8485 finished, switching from 5 to 6
Aug 27 17:11:10 catfish automount[8460]: get_pkt: state 5, next 6
Aug 27 17:11:10 catfish automount[8460]: umount_multi: path=/home incl=0 
Aug 27 17:11:10 catfish automount[8460]: umount_multi: no mounts found under /home
Aug 27 17:11:10 catfish automount[8460]: shut down, path = /home
-- 
===================
Aaron Straus
aaron@merfinllc.com
