From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Sat, 10 Apr 2004 21:06:05 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404102054510.5094@raven.themaw.net>
References: <OF602ECAC6.8CFD3CF1-ON85256E71.004B70E0-04256E71.004E8C14@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OF602ECAC6.8CFD3CF1-ON85256E71.004B70E0-04256E71.004E8C14@us.ibm.com>
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
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Fri, 9 Apr 2004, Raymond Prach wrote:

> Thanks so much for your ongoing help. I will try to answer your questions 
> as best as I'm able...
> 
> I'm curious. Does the AIX 5 automounter still polute the mount table with 
> heaps of entries if you have a large direct mount table (as it did in AIX 
> 4)?
> 
> Not sure. The AIX systems in question are using the am-utils automounter, 
> which leaves the mount table tidy but, at least for us, has a habit of 
> blowing up every so often, taking the machine down with it....

OK.

> 
> First, the version of mount that I'm using doesn't seem to hang the way it 
> 
> used to. What version of util-linux (or mount) are you using? I have 
> 2.11y.
> 
> Second thing I notice is that autofs-4.1.2 discovers the bogus mount very 
> quickly (<1 sec) and so even with a stop watch I can't get the mount to 
> be active at the same time as the expire.
> 
> Mount is 2.11y as well. I will upgrade the userspace automounter to 4.1.2 
> and see if it helps. But I don't understand how autofs can possibly decide 
> that the remote host is down or unavailable and quit attempting the mount 
> in that short (<1 sec) time period. The remote hosts in question have 
> valid DNS names, they're just powered off or otherwise unavailable. Hence 
> the mount attempt taking some time is perfectly reasonable... right? Or am 
> I being an idiot? I feel like I've been unclear in describing the 
> situation...

Good. Same version of mount.

Good question.

I merged a patch in 4.1.1 that provided replicated server type behaviour.
The point bieng that it needs to deal with host specs like 
host1(10),host2(5),host3 and so on. The point of it is to select the best 
available host to mount from. To do this we have an rpc_ping function. It 
is set to time out fairly quickly. All the mount requests pass through 
this code and if none (one in this case) is not available it return a fail 
and doesn't attempt the mount.

This situation is quite interesting as your script could show up a bug in 
that, even though the mount may be significantly less the problem may 
still arise from time to time.

Lets see how it goes first.

> 
> Oh yes: the kernel version is 2.4.26-pre3, though 2.4.25 exhibits the same 
> behavior.
> 
> I will update the userspace automounter. Do I need to load autofs4 instead 
> of autofs as well?

The init script should do this for you.

In the past it you needed to add a line like

alias autofs autofs4

to your modules.conf.

Ian
