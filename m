From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: make an executable map rerun.
Date: Wed, 25 Mar 2009 09:07:19 -0400
Message-ID: <x498wmtkayg.fsf@segfault.boston.devel.redhat.com>
References: <49C9F7A0.80603@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49C9F7A0.80603@bononline.nl> (Stef Bon's message of "Wed, 25 Mar
	2009 10:21:36 +0100")
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

Stef Bon <stef@bononline.nl> writes:

> Hello,
>
> I've been working on a solution to make networkresources available via 
> autofs on a dynamic way. After login with help
> from ConsoleKit a mountpoint is added to the master file of the 
> automounter. This mountpoint is in the homedirectory of the user logging in.
>
> This way I've a browseable network map in my home directory for Windows 
> Networks (via cifs), FTP (via curlftpfs/FUSE) and SSH (with sshfs/FUSE). 
> Others, like Novell should be possible.

This sounds like interesting work.  Do you have it posted somewhere?

> It works with executable maps. Now for some reasons I would like some 
> control over rerrunning the executable map, to make the automounter 
> refresh the autofs data. Now I do not see how to do that. I reload 
> signal does not do that.
>
> Is there a way to do this?

No caching is done for program maps.  They are consulted for every
single lookup, so you shouldn't have to do anything special.  Is this
not the behaviour you are observing?

Cheers,
Jeff
