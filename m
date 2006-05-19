From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS Problems with Laptops
Date: Fri, 19 May 2006 21:36:37 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605192133390.4364@raven.themaw.net>
References: <20060519081703.10370.qmail@web36805.mail.mud.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060519081703.10370.qmail@web36805.mail.mud.yahoo.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Qarras <dqarras@yahoo.com>
Cc: autofs@linux.kernel.org

On Fri, 19 May 2006, Daniel Qarras wrote:

> Hi!
> 
> This is probably very easy but I can neither figure it out or use
> Google.. Anyway, this is what I want to achieve:
> 
> Our local network (10.0.0.0) server exports /home and /work directories
> and desktop workstations with static IPs can mount them all ok over
> NFS. I have a laptop that is using DHCP and autofs. In our local
> network autofs mounts work all ok with the config below.
> 
> However, when I go out to a different network where those directories
> are not available, I would like autofs to figure that out and not to
> try mount them and cause jams. What should the script output if those
> mounts are available?
> 
> I am asking this because I've tried almost everything and I am just
> getting bizarre results like directory /var/autofs/(null)/home,
-------------------------------------------------------^
You'd be running FC5 then.
Can't track this down, we shouldn't be getting mount requests from the 
kernel with no name.

> /var/autofs/hithere/work, etc. I want to mount available mounts under
> /var/autofs so that they would be /var/autofs/home and /var/autofs/work
> but that seems not to work.
> 
> The autofs configuration that works perfectly in our local network is
> the following.
> 
> /etc/auto.master:
> 
> /var/autofs /etc/auto.local --timeout=30,--ghost
> 
> And /etc/auto.local:
> 
> home -fstype=nfs,rw,soft,intr 10.0.0.1:/home
> work -fstype=nfs,rw,soft,intr 10.0.0.1:/work

A script should just output the map entry without the key. Like
-fstype=nfs,rw,soft,intr 10.0.0.1:/work

Ian
