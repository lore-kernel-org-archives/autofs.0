From: Ian Kent <raven@themaw.net>
Subject: Re: autofs unmount don't work with symbolic links
Date: Tue, 2 Nov 2004 19:58:51 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0411021956001.2952@raven-wl.themaw.net>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua> 
 <200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua> 
 <1099300553.19050.241.camel@IAPonomarenko.isd.dp.ua> 
 <200411011332.06171.vda@port.imtp.ilyichevsk.odessa.ua> 
 <Pine.LNX.4.58.0411020719151.7571@wombat.indigo.net.au>
 <1099387308.2199.28.camel@IAPonomarenko.isd.dp.ua>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1099387308.2199.28.camel@IAPonomarenko.isd.dp.ua>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Ponomarenko <apon@isd.dp.ua>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Tue, 2 Nov 2004, Alexander Ponomarenko wrote:

> On 02 November 2004, Ian Kent wrote:
> 
> > On Mon, 1 Nov 2004, Denis Vlasenko wrote:
> > 
> > > Please use "reply before quote" style.
> > > 
> > > On Monday 01 November 2004 11:15, Alexander Ponomarenko wrote:
> > > > I use Debian Linux (testing) and version of automount there is
> > > >         Linux automount version 4.0.0
> > > > But I think this bug is not known and so is not fixed yet even in new
> > > > versions (I didn't find any subject on this question in Internet).
> > > 
> > > I can confirm that bug is still there in 4.1.3:
> > > 
> > > # automount /mnt/auto
> > > 
> > > (/mnt is a symlink) does not expire mounts:
> > > 
> > > 13:23:47 * Initializing
> > > 13:23:48 * Starting: automount -f -s -v --timeout 15 /mnt/auto program /root/bin/mapper.sh
> > > 13:23:48 starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /root/bin/mapper.sh
> > > 13:23:48 using kernel protocol version 3.00
> > 
> > Does this occur with the autofs4 module.
> > We want to see 4.05 instead of 3.00.

Which autofs4 kernel module?
Does the log say 4 or 4.05?
In other words, are you running the latest kernel module code.

> 
> 
> I saw the same with autofs (3) and autofs4 modules.
> 
> /etc/auto.master is
> 
> /var/autofs/local       /etc/auto.local         --timeout=30
> /usr/var/autofs/remote  /etc/auto.remote        --timeout=300
> /usr/var/autofs/mks     /etc/auto.mks           --timeout=300
> 
> where /var is simbolic link to /usr/var. All mounts from /etc/auto.local
> don't unmounts on expiration time but mounts from /etc/auto.remote and
> /etc/auto.mks works fine (unmounts on expiration time). The situation is
> the same as for the version 3 of autofs kernel module, as for the
> version 4. I can add syslog logs if needed (too mach for posting).
> 
> 
> --
> Alexander Ponomarenko
> ISD Configuration Management Team
> E-mail: apon@isd.dp.ua
> 
