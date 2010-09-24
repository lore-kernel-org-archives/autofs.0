From: Ian Kent <raven@themaw.net>
Subject: Re: autofs miscellaneous device
Date: Fri, 24 Sep 2010 22:17:21 +0800
Message-ID: <1285337841.2967.40.camel@localhost>
References: <4A961A51CBE84C429C56E5734477BD1F2CBAAA1AA0@EXCHAMRS03.na.blkint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=5YsyGBDAD76v2vxTqP8D/3jV49g=;
	b=m+BhXdKnMeTnUqSQ/xwNbU18zMC2Hy59sENdN+cAo5EQZGsobgu3sieVKD9Y8CoVIM1XZSf3fg3SVLyVRyFiG8q5FKuq9sCTTCxiQjRIAgYNB+eb6R3fui66AMqFNbgiMsH2qfWgxi81THop7wYW7/MJAGRlucJQJE9+y9awolI=
In-Reply-To: <4A961A51CBE84C429C56E5734477BD1F2CBAAA1AA0@EXCHAMRS03.na.blkint.com>
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
To: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

On Thu, 2010-09-23 at 11:36 -0400, Breitman, Jason wrote:
> USE_MISC_DEVICE=boolean
>     A boolean to enable (yes) or disable (no) using the autofs miscellaneous device. For example: 
> 
> Can someone explain to me what this option does?
> What are the pros and cons of having USE_MISC_DEVICE=yes?
> I am not able to find details online.

It provides access to the new ioctl interface.
There is a description of what it does, why it has been done and how it
can be used in the kernel source tree:
Documentation/filesystems/autofs4-mount-control.txt

Probably the biggest impact of using this, if it is available, is that
autofs can check if a path is a mount without scanning and file based
table. Clearly, if you don't have a lot of mounts it may not give any
real improvement.

It is also needed to allow automount to "re-connect" to mounts that were
busy and left mounted during a restart. Previously processes using these
mounts would forget their working directory because of the lazy umount
that was done to clear them at startup.

> 
> 
> Jason Breitman
> jason.breitman@blackrock.com
> 
> THIS MESSAGE AND ANY ATTACHMENTS ARE CONFIDENTIAL, PROPRIETARY, AND MAY BE PRIVILEGED.  If this message was misdirected, BlackRock, Inc. and its subsidiaries, ("BlackRock") does not waive any confidentiality or privilege.  If you are not the intended recipient, please notify us immediately and destroy the message without disclosing its contents to anyone.  Any distribution, use or copying of this e-mail or the information it contains by other than an intended recipient is unauthorized.  The views and opinions expressed in this e-mail message are the author's own and may not reflect the views and opinions of BlackRock, unless the author is authorized by BlackRock to express such views or opinions on its behalf.  All email sent to or from this address is subject to electronic storage and r
 eview by BlackRock.  Although BlackRock operates anti-virus programs, it does not accept responsibility for any damage whatsoever caused by viruses being passed.
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
