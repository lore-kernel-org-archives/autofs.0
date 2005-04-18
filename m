From: raven@themaw.net
Subject: Re: sgi IRIX-6.5 autofs
Date: Mon, 18 Apr 2005 21:35:28 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504182128250.14946@donald.themaw.net>
References: <16995.31446.632122.928444@kuku.melbourne.sgi.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16995.31446.632122.928444@kuku.melbourne.sgi.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Max Matveev <makc@sgi.com>
Cc: autofs@linux.kernel.org

On Mon, 18 Apr 2005, Max Matveev wrote:

>>>>>> "ian" == Ian Kemp (ian@themaw.net) wrote:
>
>
> ian> On Tue, 12 Apr 2005, Greg Bradner wrote:
>
> >> Let me explain: I have one NAS1 server that has a large number of
> >> links to another NAS2.  When I run a specific program, an in house
> >> tool, it stats the links; which in turn tries to mount NAS2.  With the
> >> large number of links, the program will stat one, get 'permission
> >> denied', and moves to the next.  On IRIX, autofs tries to mount with
> >> each stat.
>
> That's exactly as designed - stat(2) follows the symlink, if you want
> the information about the directory or file which symlinks points to,
> it would have to mount first to do NFS' getattr call to get the info
> which stat would return. So you should expect a mount attempt for each
> stat.
>
> ian> autofs on Linux shouldn't mount at all on stat unless the target is
> ian> contained within (not the mount point itself) the filesystem.
>
> Why? IMO stat(2), as opposed to lstat(2), must prove the info about
> the node of the remote filesystem regardless of whatever it's the
> trigger point or a file inside the trigger point.

Equally by design.

Colour ls will mount everything when you list an autofs directory and 
this (the mount storm on large autofs directories) was seen as undesirable 
for lazy mounting in a browsable tree.

But I'm open to suggestions and ideas.

Ian
