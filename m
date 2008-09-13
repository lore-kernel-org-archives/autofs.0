From: Ian Kent <raven@themaw.net>
Subject: Re: How to use the user mount option
Date: Sat, 13 Sep 2008 11:21:20 +0800
Message-ID: <1221276080.2965.12.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0809121259080.30744@rray.drdc.mstc.ms.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0809121259080.30744@rray.drdc.mstc.ms.gov>
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
To: Richard Ray <rray@mstc.state.ms.us>
Cc: autofs@linux.kernel.org

On Fri, 2008-09-12 at 13:08 -0500, Richard Ray wrote:
> I feel this must be a simple thing but it is not working for me.
> In auto.misc I have
> 
> flash -fstype=auto,rw,sync,flush,user    :/dev/sdb1
> 
> In auto.master I have
> 
> /misc file:/etc/auto.misc
> 
> If I cd /misc/flash the device will mount but all files belong to root
> If I add uid= to auto.misc the files belong to me
> Should not the user option do that without specifying a uid

The "user" option is an fstab only option.

So, since autofs specifies the device and the mount point mount(8)
doesn't consult the fstab.

The only option you have is something like:
flash -fstype=auto,rw,sync,flush,uid=$UID,gid=$GID    :/dev/sdb1

As long as the requester is a valid user on the system it should mount
as that user.

> 
> Name        : autofs
> Version     : 5.0.2
> Release     : 27
> 
> Fedora 8
> kernel: 2.6.24.4-64.fc8
> 
> Thanks
> Richard Ray
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
