From: Ian Kent <raven@themaw.net>
Subject: Re: Understanding direct mounts & ghosting
Date: Fri, 12 Mar 2004 09:26:47 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403120918120.7863@wombat.indigo.net.au>
References: <404FEEBD.70507@angalon.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <404FEEBD.70507@angalon.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matt <matt@angalon.org>
Cc: autofs@linux.kernel.org

On Wed, 10 Mar 2004, matt wrote:

> 
> So the automount does appear to be working; but not as I expect a direct 
> mount to work based on my experience with Solaris (and HPUX).  My 
> expecataion is that I should see /mnt/local as the automount point (i.e. 
> "automount(pid27238) on /mnt/local type autofs ...") instead of /mnt. 
> Is this the expected behavior or am I missing something?

Unfortuneatly, this is the way it is now.

It's been done like that largely because of the limitation on the number 
of anonymous mounts (ie. autofs, NFS etc.) in the kernel.

It is possible to enhance the kernel module to provide this functionality 
but is a large piece of work so don't expect it any time soon.

Further, there are people working on alternate designs but I have no idea 
how those efforts are going.

> 
> With regards to ghosting, I have another map (auto.nfs) that's mounted 
> on /nfs and, as I understand ghosting, I should be able to do:
>      ls /nfs
> and see a list of mountable directories (i.e. the contents of the 
> auto.nfs map) as a result.  I don't.  All I see is . and .. (presuming 
> of coure that I haven't cd'd to any of the mount-points).

At the moment the default is for directories not to be browsable so you 
need to request it as an option in either the start script or in the 
master map.

Ian
