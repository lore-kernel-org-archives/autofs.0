From: Ian Kent <raven@themaw.net>
Subject: Re[2]: [NFS] nfs or autofs related hangs
Date: Mon, 9 Feb 2004 23:13:09 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402092254390.5821@raven.themaw.net>
References: <E1AqCKn-0002dW-00.ia6432-inbox-ru@f22.mail.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1AqCKn-0002dW-00.ia6432-inbox-ru@f22.mail.ru>
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
To: =?koi8-r?Q?=22?=Peter Lojkin=?koi8-r?Q?=22=20?= <ia6432@inbox.ru>
Cc: =?koi8-r?Q?=22?=autofs mailing list=?koi8-r?Q?=22=20?= <autofs@linux.kernel.org>, nfs@lists.sourceforge.net

On Mon, 9 Feb 2004, [koi8-r] "Peter Lojkin[koi8-r] "  wrote:

> > Was this with the same kernel module ie
> > autofs4-2.4.22-20031201.patch
> i can confirm that we had such hangs with at least this
> configurations:
> 2.4.22 + trond 2.4.22 + stock autofs4 + autofs-3.9.99-4.0.0pre10-1
> 2.4.22 + trond 2.4.22 + stock autofs4 + autofs-3.9.99-4.0.0pre10-16
> 2.4.22 + trond 2.4.22 + stock autofs4 + autofs-4.1.0
> 2.4.23-rc4 + trond 2.4.23-rc1 + stock autofs4 + autofs-3.9.99-4.0.0pre10-1
> 2.4.23-rc4 + trond 2.4.23-rc1 + stock autofs4 + autofs-4.1.0
> 2.4.23aa1 + autofs4-2.4.22-20031201 + autofs-3.9.99-4.0.0pre10-1
> 2.4.23aa1 + autofs4-2.4.22-20031201 + autofs-4.1.0
> 

Thanks.

As I said I'm not sure what is causing this. I can't duplicate the error 
here but that doesn't mean much as I'm sure you realise.

I'm working on the assumtion that autofs4 is the cause of this. I have 
seen something like this with autofs4 on 2.6. It was caused by a 
simultaneous expire and mount. I was unable to resolve this at the time. 
The patch I presented is an entirely different approach.

The info I am looking for here is the usage pattern of autofs. Stuff like, 
how many entries are in the master map, how many in the maps, are they all 
indirect, are some direct or multi-mount, what are the usage patterns in 
terms of mount frequency, particularly if there are situations that 
trigger many mounts at once etc.

Any info may be a clue.

Of course it's possible this is an NFS issue.
Anyone else care to comment?

Ian
