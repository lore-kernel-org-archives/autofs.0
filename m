From: Ian Kent <raven@themaw.net>
Subject: Re: autofs mountopints on NFS mounted filesystems
Date: Fri, 13 Jun 2008 20:36:05 +0800
Message-ID: <1213360565.18072.3.camel@raven.themaw.net>
References: <n7xiqwdslwk.fsf@sor.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <n7xiqwdslwk.fsf@sor.suse.de>
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
To: Matthias Koenig <mkoenig@suse.de>
Cc: autofs mailing list <autofs@linux.kernel.org>


On Fri, 2008-06-13 at 11:51 +0200, Matthias Koenig wrote:
> Hi,
> 
> autofs will not create the autofs mountpoint path
> if the filesystem is not a locally mounted filesystem
> (e.g. a NFS mounted filesystem).
> contained_in_local_fs() returns false in this case.
> This might be intentional in most cases.
> 
> But how about if the root filesystem mounted via NFS?
> Do you see any problems adding an exceptional rule for this
> case?

Yeah, sounds sensible.

Ian
