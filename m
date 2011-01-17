From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4_d_automount() can change path->dentry param
Date: Mon, 17 Jan 2011 08:07:11 +0800
Message-ID: <1295222831.2795.5.camel@perseus>
References: <18985.1295089862@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=KAqF040rMnR3A8b8ESyAjeLjlSo=;
	b=R0Wp07AH1kC4qUYcnypWqppKT1TRciUlPmMD7DxhX9w6/lhUFEQuZEeYg/l5wrmfT/ujGH4BrMVXCyCn9B02WhtOIM/UnF/hvZS/kB9y3RxKk8pPafNgwhirWjHAFvWmwUTPrBL2EqY6Xjk+OU8Vle0gaxhxSxXoWLARCHbpIas=
In-Reply-To: <18985.1295089862@redhat.com>
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
To: David Howells <dhowells@redhat.com>
Cc: autofs@linux.kernel.org, viro@zeniv.linux.org.uk

On Sat, 2011-01-15 at 11:11 +0000, David Howells wrote:
> Hi Ian,
> 
> I've just noticed that autofs4_d_automount() can change the dentry pointer in
> the path parameter (via autofs4_mountpoint_changed()).  Is this just doing a
> straight substitution of one dentry for its equivalent?  I don't think it'll
> be a problem for follow_automount() and follow_managed(), provided the dentry
> stays in the same namespace - but if we eliminate the vfsmount pointer and
> just pass the dentry pointer in to d_automount(), you won't be able to do this
> anymore.  Would it work to simply return NULL here and hope the recheck picks
> up the substitution?

I don't think so.

It happens if the mount point dentry is removed and recreated during a
callback to the daemon so a d_lookup() then returns the replacement
dentry. If the vfsmount isn't available we would need to be able to
return the new dentry in much the same as ->lookup() will use a
replacement dentry if it is returned. I guess that's still a problem if
we need to return a vfsmount or ERR_PTR or NULL.

Ian
