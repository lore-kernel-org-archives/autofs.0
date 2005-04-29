From: Ian Kent <raven@themaw.net>
Subject: Re: memory leak in autofs-4.1.3-114 on FC3/i386?
Date: Fri, 29 Apr 2005 10:14:46 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504291006390.4749@wombat.indigo.net.au>
References: <20050429012054.GA17598@neu.nirvana>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050429012054.GA17598@neu.nirvana>
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
To: autofs@linux.kernel.org

On Fri, 29 Apr 2005, Axel Thimm wrote:

> Hi,
> 
> an updated FC3/i386 box with mail server functionality accesses
> O(1000) accounts over NFS (NFS server is a dated Tru64 Unixcluster).
> 
> The automount process consumes memory until we have to kill it, or the
> machine starts oom-killing us. Here is a graph:
> 
> 	http://www.physik.fu-berlin.de/~dreger/memusage.png
> 
> (We have also seen bad behaviour of rpc.idmapd in the past, and 200MB
> looks a bit too much for mapping 1000 accounts)
> 
> As a side note: Even though there are only 1000 accounts on this
> system, mounts are attempted on each forged incoming address,
> e.g. there is a multitude of failing mount requests, perhaps that's
> causing the large rpc.idmapd process space and automount's memory
> consumption?

I'm not sure I understand what's going on here.
Can you provide a debug log please.

> 
> Anything else we can provide for debugging? Thanks.

Jeff Moyer has a 4.1.4 rpm on his people page. Can you give that a try 
please.

Ian
