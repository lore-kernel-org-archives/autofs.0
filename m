From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to	other	automount points
Date: Sat, 26 Aug 2006 01:25:07 +0800
Message-ID: <1156526707.31377.14.camel@raven.themaw.net>
References: <3239342301.18668365@mail.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3239342301.18668365@mail.q7.com>
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
To: Joe Pruett <joey@clean.q7.com>
Cc: autofs@linux.kernel.org

On Fri, 2006-08-25 at 09:18 -0700, Joe Pruett wrote:
> The ability to have automount point to automount is something I use heavily as well.  Otherwise I end up with many hundreds of nfs mounts on the server at a time. having hundreds of bind mounts on the client is preferrable. The old sun method of doing this was:
> host:/path/name:dir
> which would mount host:/path/name and then symlink dir.  Now we' d use bind/loopback mounts.  But that syntax has been gone a long time.
> 
> It doesn't seem like threading should inherently cause a problem.  Each request should be a new thread and wait for the underlying mount (which might be recursive) to finish.
> 

It does cause a problem.
The process group is used by the kernel module to prevent the daemon
itself from triggering mounts. In the threaded environment there is
currently one program group so one thread cannot cause another thread to
trigger a mount.

I'll have to fix it.

Ian
