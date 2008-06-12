From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 00/12] Series short description
Date: Thu, 12 Jun 2008 13:45:41 +0800
Message-ID: <1213249542.4994.86.camel@raven.themaw.net>
References: <20080612033446.12261.15769.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612033446.12261.15769.stgit@raven.themaw.net>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs mailing list <autofs@linux.kernel.org>


Another false start.

On Thu, 2008-06-12 at 11:40 +0800, Ian Kent wrote:
> The following series implements...
> 
> ---
> 
> Ian Kent (9):
>       autofs4 - fix pending mount race.
>       autofs4 - use lookup intent flags to trigger mounts
>       autofs4 - don't release directory mutex if called in oz_mode
>       autofs4 - use rehash list for lookups
>       autofs4 - don't make expiring dentry negative
>       autofs4 - revert - redo lookup in ttfd
>       autofs4 - fix mntput, dput order bug
>       autofs4 - fix sparse warning in waitq.c:autofs4_expire_indirect()
>       autofs4 - check for invalid dentry in getpath
> 
> Jeff Moyer (3):
>       autofs4 - use struct qstr in waitq.c
>       autofs4 - fix incorrect return from root.c:try_to_fill_dentry()
>       autofs4 - fix execution order race in mount request code
> 
> 
>  fs/autofs4/autofs_i.h |   12 +-
>  fs/autofs4/expire.c   |   26 ++---
>  fs/autofs4/inode.c    |   29 +++---
>  fs/autofs4/root.c     |  249 +++++++++++++++++++++++++++++++++----------------
>  fs/autofs4/waitq.c    |  203 ++++++++++++++++++++++++++--------------
>  5 files changed, 334 insertions(+), 185 deletions(-)
> 
