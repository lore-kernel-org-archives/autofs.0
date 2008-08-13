From: Ian Kent <raven@themaw.net>
Subject: Re: something changed from 4 to 5
Date: Wed, 13 Aug 2008 10:58:08 +0800
Message-ID: <1218596289.3148.8.camel@raven.themaw.net>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org


On Tue, 2008-08-12 at 09:53 -0700, Joe Pruett wrote:
> i have been using mounts like this:
> 
> auto.master:
> /disks	auto.disks
> /home	auto.home
> 
> auto.disks:
> server.1	server:/disk/1
> server.2	server:/disk/2
> other.1		other:/disk/1
> other.2		other:/disk/2
> 
> auto.home:
> user1		:/disks/server.1/user1
> user2		:/disks/server.2/user2
> user3		:/disks/other.1/user3
> user4		:/disks/other.2/user4
> 
> this is to avoid ending up with 100s or 1000s of nfs mounts and instead 
> just have a few nfs mounts and then lots of bind mounts.  it has been 
> working pretty well until the last few months.  i am using a mix of centos 
> 4 and centos 5 systems, and they all are using the supplied autofs 5 
> binaries (autofs5-5.0.1-0.rc2.55.el4_6.2 and autofs-5.0.1-0.rc2.88).
> 
> what has started happening is that occasionally an automount child will 
> get stuck and all access to /disks/something will stop.  other /disks/ 
> entries are fine.  when i strace the confused child, it shows exit_group
> and then exits and then things are fine.  i think the parameter to 
> exit_group is 4, but i haven't kept a log (i will now).

Install the autofs-debuginfo package and when you see this use gdb to
get a backtrace of the running threads.

gdb -p <automount pid> /usr/sbin/automount
gdb> thr a a bt

> 
> so here are a few questions:
> 
> 1. is there a better way to do this?  in the old sun days, it was like:
> 
> user1	server:/disk/1:user1
> user2	server:/disk/1:user2

When was this syntax used, I don't remember it?
And exactly how is it supposed to work?

> 
> and server:/disk/1 would only get mounted once with symlinks for user1 and 
> user2.
> 
> 2. i see some comments about submounts in the 5.0.3 changelog.  is this a 
> submount?  or is that something different?

It's not a submount.

> 
> 3. is this a known issue?  aside from installing a 5.0.3 version (which 
> i'd like to avoid), might there be a suggested workaround?
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
