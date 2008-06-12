From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 0/5] Series short description
Date: Thu, 12 Jun 2008 14:15:52 +0800
Message-ID: <1213251352.4994.98.camel@raven.themaw.net>
References: <20080612045316.26687.61963.stgit@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080612045316.26687.61963.stgit@raven.themaw.net>
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
Wish I could tell StGIT to cancel the send when I decide I don't want to
proceed when editing the cover mail.

On Thu, 2008-06-12 at 12:54 +0800, Ian Kent wrote:
> The following series implements...
> 
> ---
> 
> Ian Kent (5):
>       autofs-5.0.3 - fix submount shutdown handling.
>       autofs-5.0.3 - don't abuse the ap->ghost field on NFS mount
>       autofs-5.0.3 - mount thread create condition handling fix
>       Fix incorrect pthreads condition handling for mount requests.
>       Another fix for don't fail on empty master map.
> 
> 
>  daemon/automount.c     |   82 ++++++++++++------------
>  daemon/direct.c        |  100 +++++++++++++++++------------
>  daemon/indirect.c      |  164 ++++++++++++++++++++++++++++++++++--------------
>  daemon/lookup.c        |    3 -
>  daemon/state.c         |    5 +
>  include/automount.h    |   19 +++++-
>  lib/master.c           |   63 +++++++++++-------
>  modules/lookup_file.c  |    1 
>  modules/mount_autofs.c |    4 +
>  modules/mount_bind.c   |    2 -
>  modules/mount_nfs.c    |   11 ---
>  11 files changed, 277 insertions(+), 177 deletions(-)
> 
