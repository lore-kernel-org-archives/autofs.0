From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter losing track of mounts...
Date: Thu, 14 Aug 2008 13:16:43 +0800
Message-ID: <1218691003.27280.92.camel@raven.themaw.net>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
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


On Wed, 2008-08-13 at 09:42 -0700, Stephen Biggs wrote:
> I am running Linux kernel version 2.6.24 and automounter 5.0.3 with all
> patches from the kernel.org repository as of 29 June 2008 (Actually 30
> June 2008 due to international date issues with Ian being in Australia
> and me in the USA).
> 
> We came across a strange issue where the automounter seems to report an
> automounted mount point being expired and unmounted without problems and
> the directory is removed, but the next time it tries to remount it, the
> remount fails because it says it's already mounted... But the directory
> isn't there.  "umount -a" clears up this problem.
> 
> FWIW, there is also this error:
> "spawn_mount: mount failed with error code 16, retrying with the -f
> option"
> 
> This seems to indicate failure to lock /etc/mtab (??) and then failing
> to retry correctly, but setting its mount table as if it succeeded.

It does imply that.
It means that the mount(8) claimed that the mtab wasn't updated during
the mount so we retry the mount with the "-f" option to give mount(8) a
chance to do the update.

But if the mtab lock is really failing you should be seeing messages in
the log from mount(8).

The other possibility is a kernel bug where a second mount request comes
in immediately following a successful mount. I can provide an updated
kernel patch that should resolve that.

Are you using any additional autofs kernel patches with your kernel?

Ian
