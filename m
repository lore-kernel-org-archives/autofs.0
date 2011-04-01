From: Ian Kent <raven@themaw.net>
Subject: Re: stat -L triggering mount (behavior change starting
 with 2.6.38-rc1)
Date: Fri, 01 Apr 2011 12:55:42 +0800
Message-ID: <1301633742.2880.25.camel@perseus>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
	<1301632038.2880.11.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=CqSKcLM4Wv+kbWg9XWs3ElM+zl0=;
	b=djZUWYovLEEp4fuHau6aKh7K+Q6nVjWnn7filp1ox1Coet1aLHMwgTwqAz0+9dueortiH+Z5EySta9Wz5R6N7avxst79hBrK+8eXAHCoESOX5GyYTdieXLxdmJVzRBKRJrXquNICemeCArcXGKyzm1JdDlMiYTX1FCNZAvNoWYU=
In-Reply-To: <1301632038.2880.11.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>

On Fri, 2011-04-01 at 12:27 +0800, Ian Kent wrote:
> On Mon, 2011-03-28 at 19:53 -0300, Leonardo Chiquitto wrote:
> 
> There where two significant patch series merged in 2.6.38 which were to
> similar parts of the VFS. One was the vfs-scale series and the other was
> the vfs-automount series. So 2.6.38 had significant autofs changes.
> 
> I think the mount storm your seeing would be due to this check not
> catching lstat(2) calls, but AFAICS it should catch this case:
> 

Oh, hang on, we have this comment in the VFS code!

         /* We want to mount if someone is trying to open/create a file of any
          * type under the mountpoint, wants to traverse through the mountpoint
          * or wants to open the mounted directory.
          *
          * We don't want to mount if someone's just doing a stat and they've
          * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
          * appended a '/' to the name.
          */
>         if (!(flags & LOOKUP_FOLLOW) &&
>             !(flags & (LOOKUP_CONTINUE | LOOKUP_DIRECTORY |
>                        LOOKUP_OPEN | LOOKUP_CREATE)))
>                 return -EISDIR;
> 

But "stat -L" says de-reference (a stat(2) call, not an lstat(2) call)
the symlink so AT_SYMLINK_NOFOLLOW is not set and consequently
LOOKUP_FOLLOW will be set. Since automounting modules no longer see the
lookup flags autofs doesn't know about this.

I missed this case, oops!

I'm not even sure what we can do about it either since this code is
shared by other file systems than autofs that don't need to tell lies
when stat()ing a directory to prevent mount storms.

mmm ...
