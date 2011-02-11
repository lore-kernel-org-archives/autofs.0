From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.5 non-expiring mounts
Date: Fri, 11 Feb 2011 11:10:34 +0800
Message-ID: <1297393834.2757.5.camel@perseus>
References: <4D510D53.7010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=B28ZbSLOMStuHtWkdygieHdIkvo=;
	b=ALQEw4OP5/XOpl4K8o8TW/HuH7YL8VtXGFD7/usuYSLjAFG31CFBH1ppTBMgVm9BSpCyhNX92ezWQ05c4PeQ8f+CEyAlaLjeGvWp/4Y129pD9J3f+8gjpv9ZN3Mc8oOXTSYjmyDTMXoq1mE+MK2cv4pL9Gtswnz24TwrVfcB9iE=
In-Reply-To: <4D510D53.7010507@gmail.com>
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
To: "Philip Ong Jr." <pongjr@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 2011-02-08 at 01:30 -0800, Philip Ong Jr. wrote:
> I've pulled down the 5.0.5 tree and all patches.
> 
> I've set the logging level to debug and can see messages of expiring 
> mounts in /var/log/messages...but when I check /etc/mtab or /proc/mounts 
> or df, i can still see them there. Any ideas if this is a known issue or 
> if I can give more info than below?

You will need to post a full debug log somewhere.
Make sure that syslog is capturing daemon.* to the syslog so that you
get all the debug log messages.

> 
> 
> Linux sc-sim-208-144 2.6.29.4 #8 SMP Tue May 25 14:00:33 PDT 2010 x86_64 
> x86_64 x86_64 GNU/Linux
> # automount -V
> 
> Linux automount version 5.0.5
> 
> Directories:
>          config dir:     /etc/sysconfig
>          maps dir:       /etc
>          modules dir:    /usr/lib/autofs
> 
> Compile options:
>    DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS LIBXML2_WORKAROUND
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
