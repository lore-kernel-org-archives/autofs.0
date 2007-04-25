From: Ian Kent <raven@themaw.net>
Subject: Re: FC6 automounter stops mounting NFS mounts
Date: Thu, 26 Apr 2007 00:02:44 +0800
Message-ID: <1177516964.3381.7.camel@raven.themaw.net>
References: <462E1A30.3090002@phy.duke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <462E1A30.3090002@phy.duke.edu>
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
To: Jimmy Dorff <jdorff@phy.duke.edu>
Cc: autofs@linux.kernel.org

On Tue, 2007-04-24 at 10:54 -0400, Jimmy Dorff wrote:
> Hi,
> 
> I have a number of FC6 workstations that intermittently have a problem 
> with automount, where it simply stops mounting filesystems.  If you 
> attempt to access a directory which automount would normally mount your 
> command simply hangs.  The automount process is running and still writes 
> logs from the "verbose" option, but the logs don't indicate any problem. 
>   The logs just show the "mount still busy" messages from previously 
> mounted filesystem(s).  On the NFS server I don't see any mount requests 
> from the afflicted client.
> 
> To "fix" the problem, I simply restart automount via "service autofs 
> restart" and everything works as expected.
> 
> We have been seeing this problem intermittently throughout our use of 
> FC6.  I don't have any clue what makes it happen.  Any info on how I can 
> prevent this or gather more debug info is welcomed!

Provide a debug log.
Provide your maps including the master map.
See http://people.redhat.com/jmoyer for more information about how to do
this.

In order to resolve problems like this I need to be able to reproduce
them. Any information you can provide on this would be useful.

Things such as:
how long is it before you see this happen?
does it always happen to the same mount?
is the mount part of a multi-mount map entry?

What revision of util-linux, nfs-utils and nfs-utils-lib are you using?

Ian
