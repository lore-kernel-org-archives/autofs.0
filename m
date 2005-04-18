From: Max Matveev <makc@sgi.com>
Subject: Re: sgi IRIX-6.5 autofs
Date: Mon, 18 Apr 2005 19:16:06 +1000
Message-ID: <16995.31446.632122.928444@kuku.melbourne.sgi.com>
References: <1027927388@toto.iv>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1027927388@toto.iv>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

>>>>> "ian" == Ian Kemp (ian@themaw.net) wrote:


 ian> On Tue, 12 Apr 2005, Greg Bradner wrote:

 >> Let me explain: I have one NAS1 server that has a large number of 
 >> links to another NAS2.  When I run a specific program, an in house 
 >> tool, it stats the links; which in turn tries to mount NAS2.  With the 
 >> large number of links, the program will stat one, get 'permission 
 >> denied', and moves to the next.  On IRIX, autofs tries to mount with 
 >> each stat.

That's exactly as designed - stat(2) follows the symlink, if you want
the information about the directory or file which symlinks points to,
it would have to mount first to do NFS' getattr call to get the info
which stat would return. So you should expect a mount attempt for each
stat.

 ian> autofs on Linux shouldn't mount at all on stat unless the target is
 ian> contained within (not the mount point itself) the filesystem.

Why? IMO stat(2), as opposed to lstat(2), must prove the info about
the node of the remote filesystem regardless of whatever it's the
trigger point or a file inside the trigger point.

max
