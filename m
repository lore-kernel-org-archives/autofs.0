From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS expire/timeout semantics
Date: Tue, 26 May 2009 21:42:55 +0800
Message-ID: <4A1BF1DF.6020000@themaw.net>
References: <c2d0b6ec0905250608w159e5630xf77c470d192c09e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c2d0b6ec0905250608w159e5630xf77c470d192c09e4@mail.gmail.com>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

Leonardo Chiquitto wrote:
> Hello,
> 
> I'm running some tests against AutoFS 5 and when I set a mount
> point with a short expire timeout (let's say 2 minutes), I'm observing
> the following behavior:
> 
> - Keeping an open file in the mount point will prevent it to expire.
>   This is expected, of course, as the file system is busy.
> - Setting a cron job to run "ls" or read some file from the mount point
>   won't prevent the file system to expire and be unmounted after
>   the 2 minutes timeout. This comes a bit as a surprise to me, as
>   I was expecting every access to files in the mount point to reset
>   the expire timeout.
> 
> Question is: what operations (if any) resets the expiration timeout?

It's not operations that cause the counter to be updated.
It isn't possible to update the counter based on specific operations.
It isn't possible to update the counter for all mount types based upon
access only, such as listing a directory.

The counter is updated during each expire check and is updated if the
file system covering (for direct or offset mounts), or within (indirect
mounts) the autofs file system has an elevated reference count. So, if
there are open files or process working directories, or a path lookup is
in progress at the time of the check, that is sufficient for the mount
to be considered busy and the counter updated.

Ian
