From: Ian Kent <raven@themaw.net>
Subject: Re: VFS: Busy inodes after unmount on 2 way SMP
Date: Wed, 17 Sep 2003 12:56:18 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0309171252400.25153-100000@wombat.indigo.net.au>
References: <3F67C6DD.20901@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F67C6DD.20901@zytor.com>
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
To: Arun Sharma <arun.sharma@intel.com>
Cc: autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Tue, 16 Sep 2003, H. Peter Anvin wrote:

>
> Please don't mix the v3 and v4 stuff (this was a misguided change on
> Linus' part which I still very much disagree with.)
>

Yes.

It should work but if it doesn't it becomes very difficult to support.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
