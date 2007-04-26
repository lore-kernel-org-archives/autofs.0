From: Jimmy Dorff <jdorff@phy.duke.edu>
Subject: Re: FC6 automounter stops mounting NFS mounts
Date: Thu, 26 Apr 2007 10:00:14 -0400
Message-ID: <4630B06E.3060205@phy.duke.edu>
References: <462E1A30.3090002@phy.duke.edu>
	<1177516964.3381.7.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1177516964.3381.7.camel@raven.themaw.net>
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

Ian Kent wrote:
> Provide a debug log.
> Provide your maps including the master map.
> See http://people.redhat.com/jmoyer for more information about how to do
> this.
> 
> In order to resolve problems like this I need to be able to reproduce
> them. Any information you can provide on this would be useful.

Thanks for the info.  I'll setup a test system with the additional 
debugging and see if I can reproduce this at will.

> Things such as:
> how long is it before you see this happen?
Systems are fine for weeks.

> does it always happen to the same mount?
No.

> is the mount part of a multi-mount map entry?
Nope.

> What revision of util-linux, nfs-utils and nfs-utils-lib are you using?

util-linux-2.13-0.46.fc6
nfs-utils-1.0.10-7.fc6
nfs-utils-lib-1.0.8-7.2

Thanks,
Jimmy
