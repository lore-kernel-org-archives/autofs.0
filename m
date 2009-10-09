From: Ian Kent <raven@themaw.net>
Subject: Re: [rfc][patch] fs: dcache remove d_mounted
Date: Fri, 09 Oct 2009 16:07:24 +0800
Message-ID: <4ACEEF3C.4030005@themaw.net>
References: <20091009025621.GB4287@wotan.suse.de> <4ACECE68.70009@themaw.net>
	<20091009074211.GD2983@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20091009074211.GD2983@wotan.suse.de>
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
To: Nick Piggin <npiggin@suse.de>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org

Nick Piggin wrote:
> I guess you could have a flag in the vfsmount which you could then set
> to have lookup_mnt (and hence follow_mount etc) ignore it.
> 
> Unsetting / decrementing d_mounted I guess works, but I would just
> be worried if other mounts can be attached to the dentry then you
> might ignore that other mount or even follow your autofs mount.i

The other thing worth mentioning is that these mounts are entirely
managed by the user space daemon, no-one else can mount within the
autofs fs (well almost), unless a privileged user space process
deliberately uses ioctls to change that.

Ian
