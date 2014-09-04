From: Ian Kent <raven@themaw.net>
Subject: Re: Mount point permission
Date: Thu, 04 Sep 2014 09:16:15 +0800
Message-ID: <1409793375.2558.7.camel@perseus.themaw.net>
References: <1409770624.8847.7.camel@deiu.bydeiu.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=FzDlf32IWqBTy22BnkqmcOOb3FM=; b=Y06sZZ0f9MZlBncYVeKMgb+MOJtK
	jbgLSOfy5lX1riHx4vT/tZzHNidjZtFG+1/jk3EJ6oeYLTZLeyR4Ldws9vtONrO7
	nTrOxZhLTrPJnQ0yg4Tt7INdoif9QoRMx0AHhcJM7T3uEaBWTNTjhFf8CzrbiwkD
	gV3/rpZhxJOES4M=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=FzDlf32IWqBTy22BnkqmcO
	Ob3FM=; b=BmF+jNzefJB9UBJZyoJZfnuaCpqy5OKDaECi51YZo2TLa5DJBwrN+t
	Y5hrnwocgHziInBeVujDIqNjKHfM8XnTI2bj0UyFQw+LPGFIHDo+3NGjEzOsXII/
	AHl5dEe6a5oXd5B3ecoGo+iZKdnDj3lrp8DfQtNyY/wZ8k69e02ms=
In-Reply-To: <1409770624.8847.7.camel@deiu.bydeiu.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Amuraritei Andrei <sirdeiu@Bydeiu.net>
Cc: autofs@vger.kernel.org

On Wed, 2014-09-03 at 21:57 +0300, Amuraritei Andrei wrote:
> Hello, 
> 
> I'm using autofs 5.0.7 on Fedora 20 and have a question regarding the
> mount point permissions.
> 
> Specifically if autofs creates a direct or indirect mount point, for
> example /share (which holds the storage nfs exported folder), I can't
> seem to create another folder in /share.
> 
> So mkdir /share/storage/dir1 works. But mkdir /share/dir1 doesn't. I
> guess it's by design(?) but couldn't find anything specific about this.
> 
> Permissions are root:root 0755 for /share from filesystem. But when
> trying mkdir /share/dir (while it's mounted by autofs),  and as root, I
> get permission denied.

If there is a mount on top of /share, NFS for example, then permissions
are managed by NFS. If you can't create a directory in this case then
investigate possible NFS permissions problems.

> 
> Is this because of autofs needing to unmount /share when not used (with
> timeout) or is it just some bug ?

Processes other than the one managing the automount point are not
supposed to be able to create directories within an autofs file system.
It's far to easy to break the kernel detection of directories that are
mount points by creating directories within an autofs file system.
Perhaps mountpoints could be detected differently but that isn't as
simple to do as it sounds.

Ian

