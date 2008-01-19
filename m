From: Ian Kent <raven@themaw.net>
Subject: Re: mount options can not be parsed in auto.master
	with	ldap map
Date: Sat, 19 Jan 2008 11:47:03 +0900
Message-ID: <1200710823.3103.1.camel@raven.themaw.net>
References: <m3hchbdqxc.fsf@dynamo.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <m3hchbdqxc.fsf@dynamo.mandriva.com>
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
To: Olivier Blin <blino@mandriva.com>
Cc: autofs@linux.kernel.org


On Fri, 2008-01-18 at 17:44 +0100, Olivier Blin wrote:
> Hello,
> 
> Since the "LDAP base dns with spaces" patch series has been applied,
> automount can't parse anymore the mount options in auto.master.
> It looks like it includes the mount options after the space when
> parsing the base dn.
> 
> Here is my auto.master file:
> $ grep -v "^#" /chroot/cooker/etc/autofs/auto.master
> /home   ldap:ou=auto.home,ou=Mounts,dc=mandriva,dc=com rw,nosuid,nodev,soft,intr,relatime
> 
> It fails this way:
> # automount -d -f
> Starting automounter version 5.0.3, master map auto.master
> using kernel protocol version 5.00
> lookup_nss_read_master: reading master files auto.master
> parse_init: parse(sun): init gathered global options: (null)
> lookup_read_master: lookup(file): read entry /home
> syntax error in map near [ nosuid ]
> no mounts in table

Yep, I've had trouble with satisfying that requirement along the way.
I'll check.

Ian
