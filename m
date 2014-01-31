From: Ian Kent <raven@themaw.net>
Subject: Re: autofs linux 3.8.13 and "Too many levels of symbolic links"
Date: Fri, 31 Jan 2014 11:31:20 +0800
Message-ID: <1391139080.2486.19.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=R79AIjnTR1HClM5mZZO6zLHsLT4=; b=NCy8BIphA4sTXd6Q97aaQzhBSmhs
	0aXSGHGBHWn3b8cbxhZq3Xbj25VyI5OASb6cDNSo0SX1b1rEnLWNp6VgOSmj+mb7
	b9fqA9NdhXW3eo8tvCCGnOtbgPLWQ2GaZYfd29VeP7snITBOFftH4C5iEF6BFgUA
	U+vooHEXtE9zX0w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=R79AIjnTR1HClM5mZZO6zL
	HsLT4=; b=NAkHwh8YXFVtibhEeM4baWuCyD+BGAwRqimLlFAQMD/yFVEp027TJj
	N8kd8xPeSEmFGhrBH5ynWrX4qHMcJfhXyjX+wMbAYnrGEq3u27KkY2MvJi5EcDgp
	iq9dPUUtCv7kxp98bWVx4PR2kzBLLIhMJsz7XsIecldL9LTOt/vew=
In-Reply-To: <52E92627.9050801@molgen.mpg.de>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>

On Wed, 2014-01-29 at 17:02 +0100, Donald Buczek wrote:
> Hello,
> 
> we are trying to switch from amd to autofs. After successfully testing 
> and rolling it out to the first several machines, from time to time we 
> get directories stuck with "Too many levels of symbolic links" on a path 
> which should be automounted via an indirect map.
> 
> linux 3.8.13
> autofs 5.0.8
> 
> As an example, here is data from a system where the path /scratch/tmp is 
> stuck:
> 
> http://www.molgen.mpg.de/~buczek/autofs-demo/
> 
>    auto.master    # master map
>    auto.scratch    # indirect map for /scratch
>    autofs            # from /etc/defaults
>    typescript       # shows the problem and a bit of gdb dump of kernel 
> structures
>    typescript.l     # same with line numbers for reference
>    gdb-macros     # macros used in the gdb session
> 
>  From typescript.l , line 122ff it is clear, that /scratch/tmp is not 
> currently mounted. On the other hand, the gdb session finds the dentry 
> of /scratch/tmp which has d_flags 0x70080 (line 99,120). This is 
> DCACHE_MANAGE_TRANSIT+DCACHE_NEED_AUTOMOUNT+DCACHE_MOUNTED+DCACHE_RCUACCESS 
> with DCACHE_MOUNTED indicating that there should be something mounted 
> there(?). I think, this state is faulty and necessarily leads to ELOOP 
> during path walk. Probably the situation is known by the gurus here?

Yes, I can see how DCACHE_MOUNTED being set would lead to ELOOP in this
case. But, having been there before too, I couldn't see any way the
DCACHE_MOUNTED would not be cleared on umount. Also, DCACHE_MOUNTED is
only changed within the VFS and isn't changed very often. It can't see
how a code path that should lead to one of those changes doesn't go
there.

I'll have another look .....

Ian

