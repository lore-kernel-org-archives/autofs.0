From: Ian Kent <raven@themaw.net>
Subject: Re: [NFS] nfs or autofs related hangs
Date: Wed, 18 Feb 2004 09:02:06 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0402180855400.11927@wombat.indigo.net.au>
References: <20040215222107.7E4382C2D8@lists.samba.org>
 <Pine.LNX.4.58.0402160910300.28358@wombat.indigo.net.au>
 <20040217183749.490777c5.rusty@rustcorp.com.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040217183749.490777c5.rusty@rustcorp.com.au>
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
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 17 Feb 2004, Rusty Russell wrote:

> On Mon, 16 Feb 2004 09:13:55 +0800 (WST)
> Ian Kent <raven@themaw.net> wrote:
> 
> > On Sun, 15 Feb 2004, Rusty Russell wrote:
> > > Is this __cacheline_aligned_in_smp really required?
> > 
> > I must admit I put this together without much thought with a "cut and 
> > paste".
> > 
> > But, please tell me. I'm not entirely clear on what conditions I 
> > should be concerned about blowing the cache.
> 
> You should usually try to declare the spinlock near the things it protects, in
> the hope that they'll be in the same cacheline.  If we blow 128 bytes for
> every spinlock, things will get slower, not faster.

Thanks. I'll take it out.

Do you mean near to the storage declaration. This lock is used in three 
places in the module within it's declared. Near the begining, the middle 
and near the end.

Ian
