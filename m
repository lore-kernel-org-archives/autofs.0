From: Ian Kent <raven@themaw.net>
Subject: Re: unacceptable bug in autofs kernel module
Date: Wed, 29 Dec 2004 09:02:15 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0412290843030.31988@wombat.indigo.net.au>
References: <41D1106C.9070706@intraperson.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41D1106C.9070706@intraperson.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ramana <ramana@intraperson.com>
Cc: autofs@linux.kernel.org

On Tue, 28 Dec 2004, ramana wrote:

> Dear developers,
> 
> Here is the bug in autofs3 module which causing so much pain. It simply 
> stopped me from adding much more interesting features to Autodir 
> http://www.intraperson.com/autodir/

Thanks for this.

You've provided some symptoms but you haven't provided any explanation as 
to why this is a bug.

Can you explain why you need the kernel to honour a lookup for an already 
deleted dentry?

This could be due to the way that autofs does a d_drop instead of a 
d_delete in the directory unlink callback. However, the dentry, for all 
intentional purposes, has already been deleted.

> 
> Taken from Linux kernel 2.4 autofs module source.
> 
> file:            root.c
> function:    autofs_root_lookup.
> protocol:    3
> 
>         /*
>          * If this dentry is unhashed, then we shouldn't honour this
>          * lookup even if the dentry is positive.  Returning ENOENT here
>          * doesn't do the right thing for all system calls, but it should
>          * be OK for the operations we permit from an autofs.
>          */
>                                                                                                  
> 
>         /*
>         if ( dentry->d_inode && d_unhashed(dentry) )
>                 return ERR_PTR(-ENOENT);
>         */
>                                                                                                  
> 
>         if ( dentry->d_inode && d_unhashed(dentry) ) {
>                 printk( "ENOENT for %s\n", dentry->d_name.name );
>                 return ERR_PTR(-ENOENT);
>         }
> 
> I added printk to easily trace it. To my surprise autofs 4 also has 
> similar code.
> 
> Because of this, user space test program reporting like this:
> 
> fail : /test/t944 : No such file or directory
> fail : /test/t4187 : No such file or directory
> fail : /test/t100 : No such file or directory
> fail : /test/t806 : No such file or directory
> fail : /test/t3451 : No such file or directory
> fail : /test/t1790 : No such file or directory
> fail : /test/t3555 : No such file or directory
> fail : /test/t3098 : No such file or directory
> fail : /test/t4085 : No such file or directory
> fail : /test/t3935 : No such file or directory
> 
> with corresponding kernel messages are,
> 
> ENOENT for t944
> ENOENT for t4187
> ENOENT for t100
> ENOENT for t806
> ENOENT for t3451
> ENOENT for t1790
> ENOENT for t3555
> ENOENT for t3098
> ENOENT for t4085
> ENOENT for t3935
> 
> The error rate as taken from months of stress tests -- ie ENOENT; is 
> around 0.002% and increases as system load increases. Even at this rate 
> I do not think it is acceptable in production systems.
> 
> Thanks in advance.
> 
> Regards
> ramana
> 
> -- 
> http://www.intraperson.com
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
