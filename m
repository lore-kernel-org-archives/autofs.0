From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mount remounted
Date: Fri, 23 Dec 2005 08:15:16 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0512230801170.26240@wombat.indigo.net.au>
References: <20051222092025.GE20280@obs.unige.ch>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20051222092025.GE20280@obs.unige.ch>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cedric BRINER <work@infomaniak.ch>
Cc: autofs@linux.kernel.org

On Thu, 22 Dec 2005, Cedric BRINER wrote:

> hi,
> 
> I've the following situation where /home is managed by autofs and than I'd like to do a:
> mount --bind /home /var/chroot/home
> 
> when I do a: ls /var/chroot/home my machine totaly hangs and have to shut down with the power button :(
> Is there a solution to this or should I just have twice an automounter:
>  - one which manage /home
>  - other which mange /var/chroot/home.

No, the path /var/chroot/home/<some key> doesn't match /home/<some key>. 
Before you ask why not just match the key, because that's the path 
the autofs filesystem is mounted on and the daemon relies on this for 
mounting and umounting filesystems.

Your machine shouldn't hang.
What kernel version and autofs4 kernel version do you have?
A similar issue was fixed not long ago (ie. not to panic the kernel).

I would like to make this process path independent for the new version 
of autofs but as I said above mounting and umounting is heavily dependent 
of the path.

Even if I could do that I have seen that the two directory entries are 
different at the kernel level under a bind mount, as they should be. I'm 
not sure how I can handle that at all.

Ian
