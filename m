From: "Simon Woolsgrove" <simon@woolsgrove.com>
Subject: Replicated Mounts for autofs4
Date: Wed, 17 Dec 2008 07:53:08 -0800
Message-ID: <20081217075308.1E7FE688@resin18.mta.everyone.net>
Reply-To: simon@woolsgrove.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs@linux.kernel.org


When using autofs (4.1.3.x) on RHEL with replicated mounts, how can you show a user your using a replicated mount without digging back through the autofs config files e.g. mount just shows the file system that got selected rather than the list of available replicated mounts. In Solaris say mount or df will show the mount is replicated with the list of possible servers available,  using nfsstat -m <mnt> will show the actual server your using. 

Also is failover supported with replicated mounts e.g. if a mount no longer responds after a timeout period.  I read from a previous post that its not is this still the case.

Does any of the above change with autofs5 or more recent kernels


Cheers,
Simon.
