From: Ion Badulescu <lists@news.cs.columbia.edu>
Subject: Re: Re: [NFS] VFS: Busy inodes after unmount on 2 way SMP
Date: Mon, 15 Sep 2003 19:42:51 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309151941550.18622-100000@moisil.badula.org>
References: <3F663C5F.80207@zytor.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F663C5F.80207@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arun Sharma <arun.sharma@intel.com>, autofs@linux.kernel.org, nfs@lists.sourceforge.net

On Mon, 15 Sep 2003, H. Peter Anvin wrote:

> Arun Sharma wrote:
> >>
> >> Oh yeah, easily. Kill the automounter while some things are mounted,
> >> unmount everything by hand but do not rmdir the mountpoints. When you
> >> unmount the autofs filesystem itself, you will get the self destruct
> >> message.
> > 
> > Thanks. This reproduces the problem I'm chasing very well. I think this
> > is clearly an unacceptable kernel bug.
> > 
> Indeed.  This is on autofs 3?

Both 3 and 4, at least as far as the "self-destruct" message goes.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
