From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] nfs or autofs related hangs
Date: Mon, 16 Feb 2004 09:13:55 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402160910300.28358@wombat.indigo.net.au>
References: <20040215222107.7E4382C2D8@lists.samba.org>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040215222107.7E4382C2D8@lists.samba.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: autofs mailing list <autofs@linux.kernel.org>, nfs@lists.sourceforge.net, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, 15 Feb 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.58.0402082326270.5926@raven.themaw.net> you write:
> > +static spinlock_t waitq_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
> 
> Is this __cacheline_aligned_in_smp really required?
> 

I must admit I put this together without much thought with a "cut and 
paste".

But, please tell me. I'm not entirely clear on what conditions I 
should be concerned about blowing the cache.

Ian
