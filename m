From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: autofs unmount don't work with symbolic links
Date: Tue, 2 Nov 2004 17:38:42 +0200
Message-ID: <200411021738.43084.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
	<1099387308.2199.28.camel@IAPonomarenko.isd.dp.ua>
	<Pine.LNX.4.58.0411021956001.2952@raven-wl.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0411021956001.2952@raven-wl.themaw.net>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>, Alexander Ponomarenko <apon@isd.dp.ua>
Cc: autofs mailing list <autofs@linux.kernel.org>

> > > > I can confirm that bug is still there in 4.1.3:
> > > > 
> > > > # automount /mnt/auto
> > > > 
> > > > (/mnt is a symlink) does not expire mounts:
> > > > 
> > > > 13:23:47 * Initializing
> > > > 13:23:48 * Starting: automount -f -s -v --timeout 15 /mnt/auto program /root/bin/mapper.sh
> > > > 13:23:48 starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /root/bin/mapper.sh
> > > > 13:23:48 using kernel protocol version 3.00
> > > 
> > > Does this occur with the autofs4 module.
> > > We want to see 4.05 instead of 3.00.
> 
> Which autofs4 kernel module?
> Does the log say 4 or 4.05?
> In other words, are you running the latest kernel module code.

Yes, it was an old module (I had stale line on /etc/modules.conf).
I fixed it, but new module does the same:

16:53:47 * Initializing
16:53:47 * Starting: automount -f -s -v --timeout 15 /mnt/auto program /root/bin/mapper.sh
16:53:47 starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /root/bin/mapper.sh
16:53:47 using kernel protocol version 4.05
16:53:47 using timeout 15 seconds; freq 4 secs
16:53:53 attempting to mount entry /mnt/auto/hda1
16:53:53 >> /usr/bin/mount: illegal option -- s
16:54:12 expired /mnt/auto/hda1
16:54:28 expired /mnt/auto/hda1
16:54:45 expired /mnt/auto/hda1
16:55:13 expired /mnt/auto/hda1

/mnt/auto/hda1 is still mounted...
--
vda
