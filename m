From: Ian Kent <raven@themaw.net>
Subject: Re: Replicated Mounts for autofs4
Date: Tue, 23 Dec 2008 15:07:07 +0900
Message-ID: <1230012427.3043.1.camel@zeus.themaw.net>
References: <20081217075308.1E7FE688@resin18.mta.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20081217075308.1E7FE688@resin18.mta.everyone.net>
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
To: simon@woolsgrove.com
Cc: autofs@linux.kernel.org

On Wed, 2008-12-17 at 07:53 -0800, Simon Woolsgrove wrote:
> When using autofs (4.1.3.x) on RHEL with replicated mounts, how can you show a user your using a replicated mount without digging back through the autofs config files e.g. mount just shows the file system that got selected rather than the list of available replicated mounts. In Solaris say mount or df will show the mount is replicated with the list of possible servers available,  using nfsstat -m <mnt> will show the actual server your using. 
> 
> Also is failover supported with replicated mounts e.g. if a mount no longer responds after a timeout period.  I read from a previous post that its not is this still the case.
> 
> Does any of the above change with autofs5 or more recent kernels

No, mount fail over isn't supported in Linux NFS client and passing
multiple location mount strings to mount(8) on Linux will cause a syntax
error failure.

Ian
