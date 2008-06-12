From: Ian Kent <raven@themaw.net>
Subject: Re: automount ignores remote logins
Date: Thu, 12 Jun 2008 22:36:35 +0800
Message-ID: <1213281395.4994.146.camel@raven.themaw.net>
References: <20080612111400.pq5zr4r14cwgk44s@webmail.df.eu>
	<1213273474.4994.109.camel@raven.themaw.net>
	<20080612154548.6p0bxb31wkccssgc@webmail.df.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612154548.6p0bxb31wkccssgc@webmail.df.eu>
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


On Thu, 2008-06-12 at 15:45 +0200, Max Harvest wrote:
> Quoting Ian Kent <raven@themaw.net>:
> > No, this is not what I asked for.
> > Go through the procedure and post the log as a single unit.
> > Add comments about the activities that relate to timestamps in the log
> > but I want to see a single continuous log. If you have to post the log
> > as an attachment.
> 
> The complete /var/log/messages (from boot to shutdown) is attached.  
> Comments are indicated by #

# root starts automount
Jun 12 15:13:02 node061 automount[1910]: Starting automounter version 5.0.2, master map auto.master
Jun 12 15:13:02 node061 automount[1910]: using kernel protocol version 5.00
Jun 12 15:13:02 node061 automount[1910]: lookup_nss_read_master: reading master nis auto.master
Jun 12 15:13:02 node061 automount[1910]: lookup_init: lookup(yp): ctxt->mapname=auto.master
Jun 12 15:13:02 node061 automount[1910]: parse_init: parse(sun): init gathered global options: (null)
Jun 12 15:13:02 node061 automount[1910]: mount_init: mount(bind): bind_works = 1

But automount has not read the nis master map or it is empty or it
hasn't completed it's startup. It hasn't mounted any master map
automounts.

# root performs local log in (tty)
Jun 12 15:17:07 node061 automount[1910]: master_do_mount: mounting /users
Jun 12 15:17:07 node061 automount[1910]: lookup_nss_read_map: reading map yp auto.users
Jun 12 15:17:07 node061 automount[1910]: lookup_init: lookup(yp): ctxt->mapname=auto.users
Jun 12 15:17:07 node061 automount[1910]: parse_init: parse(sun): init gathered global options: (null)
Jun 12 15:17:07 node061 automount[1910]: mount_init: mount(bind): bind_works = 1
Jun 12 15:17:07 node061 automount[1910]: mounted indirect mount on /users with timeout 600, freq 150 seconds
Jun 12 15:17:07 node061 automount[1910]: ghosting enabled

Four minutes pass before this log entry, which appears to be the
remainder of the startup, assuming we are seeing everything in the log
for this four minute period, with only the following entry and
apparently nothing else:

# user maxh ($HOME=/users/maxh) performs remote log in _and_ log out
Jun 12 15:13:53 node061 sshd[1999]: Accepted keyboard-interactive/pam for maxh from 192.168.0.250 port 44822 ssh2
Jun 12 15:14:55 node061 sshd[2002]: PAM audit_log_acct_message() failed: Operation not permitted

For which there is no automount activity presumably because there are no
autofs mounts mounted at this time.

You are the person on site, so you are best placed to understand what is
happening.

I have no idea why autofs is either not seeing any nis master map
entries or is blocking on network io at startup. However, we don't see
evidence of a HUP signal either so the log entries starting at:
Jun 12 15:17:07 node061 automount[1910]: master_do_mount: mounting /users
are probably the tail end of the startup rather than the result of a
signal to re-read the map.

The gaps in time stamps in the log make me suspicious that we're not
getting the whole story. Is that really the case?

Ian
