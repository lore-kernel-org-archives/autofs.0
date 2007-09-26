From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] 5.0.0_beta1: use PATH in execXX()
Date: Wed, 26 Sep 2007 23:11:02 +0800
Message-ID: <1190819462.12109.5.camel@raven.themaw.net>
References: <200709261100.54397.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200709261100.54397.vda.linux@googlemail.com>
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
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-09-26 at 11:00 +0100, Denys Vlasenko wrote:
> Hi Ian,
> 
> I want automount to use PATH when it tries to run e.g. "mount",
> because I want it to work regardless where my mount binary is
> (/bin or /usr/bin or...). I do have different system with different
> paths to some binaries, and it is pain in the ass - I have
> no way to explain to automount binary that it needs to look
> in another directory.

Yes, people have asked for this fairly often.
I've resisted so far but perhaps I'm just wrong to do so.
I'll have a look at this and think about it for a little while.

> 
> I am trying to make automount using 'short' names it by passing
> variables to configure:
> 
> MOUNT="mount" \
> UMOUNT="umount" \
> E2FSCK="fsck.ext2" \
> E3FSCK="fsck.ext3" \
> ./configure ............
> 
> I think it's reasonably safe since automount is started by root
> and root is expected to set PATH sanely.
> 
> And it still doesn't work, because you are using execv(), not execvp().
> 
> This patch replaces execv() with execvp().
> 
> It should change nothing for 'normally' configured automount since
> it passes fully qualified names ("/bin/mount") to exec and PATH
> is not used in this case.
> 
> Please consider applying.
> --
> vda
