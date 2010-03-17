From: Ian Kent <raven@themaw.net>
Subject: Re: sloppy mount and lockd
Date: Wed, 17 Mar 2010 10:39:25 +0800
Message-ID: <1268793565.2256.6.camel@localhost>
References: <dc3ecf561003161132v323efa21u8d7fc8a4e3d53f03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=j/+Pca5CwJ2bSjgLaag8giEUieI=;
	b=F5RTKUqgX4Mh4XGLrZ7+AKvLg5rpAhw50Tr6DTZiE5DHC84gAWKIjgeY6ZINSAl1bjDGYZSRrSf+5vUQ4Dti1JsWwzXB22UT9yZRCVrCfmu7lEm3nI0dLUQwTGRdAwP5pByv5XlEFOlt/XbDe/D17oFyksjYdpxVcNxct4uZdLc=
In-Reply-To: <dc3ecf561003161132v323efa21u8d7fc8a4e3d53f03@mail.gmail.com>
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
To: Techie <techchavez@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2010-03-16 at 11:32 -0700, Techie wrote:
> Hi Ian,
> 
> I get these in the kernel log
> svc: failed to register lockdv1 RPC service error no. 97
> I have no idea why but using fstab does not produce these errors so
> just curious if they are troublesome or if you have seen this before.
> I have had autofs die a couple of times and wondering if its related
> to this in any way.

Haven't heard of this before.
Don't know enough about the problem so can't say if it is related.
 
> 
> Also if you have an idea why the mounts show as "sloppy" for my Autofs
> mounts but not fstab mounts?. I read that it is to support
> unrecognized options from the NFS servers such as -nobrowse. Is there
> a way to prevent this or can it be safely ignored?

Not quite.
autofs pseudo options like nobrowse usually don't to actual nfs mounts.
In the past there have been commonly used mount options that were not
supported by Linux mount and the sloppy option is used to tell mount to
ignore invalid options rather than fail. You should be able to ignore
this.

Ian
