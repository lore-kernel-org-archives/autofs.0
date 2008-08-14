From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter losing track of mounts...
Date: Fri, 15 Aug 2008 01:42:24 +0800
Message-ID: <1218735745.3216.13.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
	<1218691003.27280.92.camel@raven.themaw.net>
	<A2ECBF49F352C24F9DF65BB529DCBC70187A58C9@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58C9@hqemmail01.nvidia.com>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org


On Thu, 2008-08-14 at 10:14 -0700, Stephen Biggs wrote:
> > -----Original Message-----
> > From: Ian Kent [mailto:raven@themaw.net] 
> > Sent: Wednesday, August 13, 2008 10:17 PM
> > To: Stephen Biggs
> > Cc: autofs@linux.kernel.org
> > Subject: Re: [autofs] Automounter losing track of mounts...
> > 
> > 
> > On Wed, 2008-08-13 at 09:42 -0700, Stephen Biggs wrote:
> > > I am running Linux kernel version 2.6.24 and automounter 5.0.3 with 
> > > all patches from the kernel.org repository as of 29 June 2008 
> > > (Actually 30 June 2008 due to international date issues 
> > with Ian being 
> > > in Australia and me in the USA).
> > > 
> > > We came across a strange issue where the automounter seems 
> > to report 
> > > an automounted mount point being expired and unmounted without 
> > > problems and the directory is removed, but the next time it 
> > tries to 
> > > remount it, the remount fails because it says it's already 
> > mounted... 
> > > But the directory isn't there.  "umount -a" clears up this problem.
> > > 
> > > FWIW, there is also this error:
> > > "spawn_mount: mount failed with error code 16, retrying with the -f 
> > > option"
> > > 
> > > This seems to indicate failure to lock /etc/mtab (??) and 
> > then failing 
> > > to retry correctly, but setting its mount table as if it succeeded.
> > 
> > It does imply that.
> > It means that the mount(8) claimed that the mtab wasn't 
> > updated during the mount so we retry the mount with the "-f" 
> > option to give mount(8) a chance to do the update.
> > 
> > But if the mtab lock is really failing you should be seeing 
> > messages in the log from mount(8).
> 
> Perhaps. It could even be a bug in the mount userland software. But, in
> any case, the automounter should handle this correctly and not update
> its tables if the mount doesn't succeed for any reason. That seems to be
> the real problem here.

What tables?
Keeping the mtab up to date in mounts' job not autofs.

> 
> Is the automounter checking the failure of the "mount -f" spawn also and
> dealing with its tables accordingly?
> 
> > 
> > The other possibility is a kernel bug where a second mount 
> > request comes in immediately following a successful mount. I 
> > can provide an updated kernel patch that should resolve that.
> 
> I don't think that we can use a kernel patch for this due to us having a
> few versions of the kernel on lots of systems.  
> 
> > 
> > Are you using any additional autofs kernel patches with your kernel?
> 
> No patches to the kernel - straight vanilla, sorry for any confusion in
> how I worded it above; only daemon patches and those as of 29 June 2008.
> 
> There are no kernel patches provided in the tarball 'patch' directory
> for kernel versions after version 2.6.23.
> 
> > 
> > Ian
> > 
> > 
> > 
> -----------------------------------------------------------------------------------
> This email message is for the sole use of the intended recipient(s) and may contain
> confidential information.  Any unauthorized review, use, disclosure or distribution
> is prohibited.  If you are not the intended recipient, please contact the sender by
> reply email and destroy all copies of the original message.
> -----------------------------------------------------------------------------------
