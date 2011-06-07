From: Ian Kent <raven@themaw.net>
Subject: Re: bug doing simple stat call to mountpoint
Date: Tue, 07 Jun 2011 12:32:42 +0800
Message-ID: <1307421162.3285.12.camel@perseus.themaw.net>
References: <4DEBB25B.3020509@bononline.nl> <4DEBF6FD.8050407@bononline.nl>
	<4DEC7CC0.5050701@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=s3XX9ugyC0Pxlw9/8JWyl9+ERtQ=;
	b=muDbJpzpI/DgMTi5rllkxB/g8J2ccKlCiHdveQMwVOrAy58sga0Nn/ar1fAWJyBVhd5hlSUl7Z2LeVyo1QNbOw3k/pZDiJRuj/9d8YsurgG66iFIhF808fQZWkg3L1bCYutsIUxhPxrWSvesfLdoN4JIfP5fDF2/JCpPmtg+nUE=
In-Reply-To: <4DEC7CC0.5050701@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Mon, 2011-06-06 at 09:07 +0200, Stef Bon wrote:
> On 06/05/2011 11:37 PM, Stef Bon wrote:
> >  On 06/05/2011 06:44 PM, Stef Bon wrote:
> >>  Hi,
> >>
> >> I'm using autofs 5.0.5, kernel 2.6.38.6.
> >>
> >> In the construction I'm working on I got the following error:
> >>
> >> stat /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
> >> stat: cannot stat 
> >> `/mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1': No such 
> >> file or directory
> >> sbon [ 
> >> /tmp/mount.md5key/users/sbon/cache/0a8805e89f4cc6653185a4ec4335cca1 
> >> ]$ ls /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
> >> <gives contents as expected> 
> >
> > I've tried linux 2.6.39.1, and same behaviour. I'll try an older 
> > kernel (2.6.37....)
> 
> Oef I have found the cause of this. I had to add a trailing slash, like:
> 
>   stat /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca/
> 
> this makes the automount mount.

That's right.

There are significant changes to the kernel automount infrastructure
from 2.6.38, most notably what you saw here. Be aware that 2.6.38 has
some problems and 2.6.39 or later should be used if at all possible.

Hopefully there won't be too many problems resulting from the changes.

For information, the comment in the VFS function
fs/namei.c:follow_automount() is:

        /* We want to mount if someone is trying to open/create a file of any
         * type under the mountpoint, wants to traverse through the mountpoint
         * or wants to open the mounted directory.
         *
         * We don't want to mount if someone's just doing a stat and they've
         * set AT_SYMLINK_NOFOLLOW - unless they're stat'ing a directory and
         * appended a '/' to the name.
         *
         * An exception to this is autofs. It needs to tell lies on stat(2)
         * to prevent mount storms for things like color ls so it can set a
         * dentry flag to provide for this.
         */

Although I think the last paragraph is actually not correct since there
is no distinction between autofs and other execution threads in the test
that follows the comment.

Ian
