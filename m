From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Re: [NFS] VFS: Busy inodes after unmount on 2 way SMP
Date: Fri, 12 Sep 2003 17:34:48 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3F626628.9040000@zytor.com>
References: <Pine.LNX.4.44.0309121957040.9830-100000@moisil.badula.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309121957040.9830-100000@moisil.badula.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ion Badulescu <lists@news.cs.columbia.edu>
Cc: autofs@linux.kernel.org

Ion Badulescu wrote:
> 
> I don't know if it's the same issue, but I've seen it many many times 
> while testing amd's autofs functionality. It occurs when a non-empty 
> autofs filesystem is unmounted, e.g. if it has some leftover 
> subdirectories from previous mounts. Therefore I'd say it's quite 
> clearly an autofs issue, at least in my case.
> 
> Do you see it when shutting down the automounter, or in other cases as 
> well?
> 

This happens when *any* filesystem allows itself to be unmounted without
proper cleanup.  If it happens in normal operation, it is more likely an
NFS problem.  If it happens on automounter shutdown, it's likely an
autofs problem.

	-hpa
