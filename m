From: Ian Kent <raven@themaw.net>
Subject: Re: continued instability in autofs v3
Date: Tue, 9 Mar 2004 12:20:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403091155540.32189@wombat.indigo.net.au>
References: <1078619658.22401.11.camel@desktop.init4.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1078619658.22401.11.camel@desktop.init4.org>
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
To: Andy Grimm <ag381597@ohio.edu>
Cc: autofs@linux.kernel.org


Speaking from the autofs v4 viewpoint.

On Sat, 6 Mar 2004, Andy Grimm wrote:

> Hello, all.  I'm writing about a problem discussed in a thread back in
> September under the subject "[NFS] VFS: Busy inodes after unmount on 2
> way SMP".  I have been experiencing these issues on an increasing number

There was an NFS patch discussed on the NFS list that may relate to this.
I've yet to verify if it helps. This is likely to take quite a while as I 
get the message infrequently.

> of servers, and was wondering if any progress had been made in either
> autofs3 or autofs4.  I'm currently working with the RH 2.4.20-28.7smp
> kernel.  Unfortunately, I am not in control of the NFS servers, and I
> have to deal with the fact that they get rebooted on the weekends
> sometimes, and that sometimes processes on my servers are in the middle
> of accessing the mounts when they go away.  Is there any way to make the
> system stable again after this event occurs, or is rebooting the only
> answer?

This can only be an issue if:

1) You try and automount something during the server reboot.
   This will probably be OK after the reboot is complete.

2) Something is already mounted and it expires during the
   reboot. autofs should handle this OK but probably needs
   work.

3) You have an automounted filesystem which is already mounted
   and remains mounted during the server reboot but is not accessed.
   Should work and is an NFS issue.

4) You are accessing an automounted NFS filesystem when the server
   is rebooted. An NFS issue and I don't like your chances of
   improving this.

So this is something that needs work but is heavily reliant on NFS 
behaving.

Ian
