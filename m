From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] Busy inodes after unmount followed by Oops
Date: Sat, 10 Jan 2004 03:13:27 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0401100258370.21972-100000@wombat.indigo.net.au>
References: <3FFE8B28.1E645E4E@moving-picture.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FFE8B28.1E645E4E@moving-picture.com>
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
To: James Pearson <james-p@moving-picture.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Fri, 9 Jan 2004, James Pearson wrote:

> I have the same problem with a large number of dual CPU machines running
> 2.4.20 and above that make heavy use of autofs (v4.0.0pre10).
>
> We get a:
>
> VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice
> day...
>
> mesasage, followed some time later by Oops's from kswapd, umount or some
> other user application.
>
> Is there a 'fix' for this problem?

I would very much appreciate if you would use 4.1.0 (on kernel.org). This
may help with the problem. I'm interested to hear how it goes against the
stock autofs4 module.

I have a patch set for 2.6 but, from a recent discussion, it may be faulty.

Ian
