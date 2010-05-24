From: Ian Kent <raven@themaw.net>
Subject: Re: Indirect multi-mount map sometimes needs client reboot
 after update
Date: Mon, 24 May 2010 09:36:58 +0800
Message-ID: <1274665018.2410.6.camel@localhost>
References: <510030.76217.qm@web65411.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=y75eXTFVaJrfSwHx3VFBmD1p26c=;
	b=EOAMAVBA+cJS7Za5/JnWRRhzuNAvrIP7zHm4lVaJdtHjN0FyrcxaSW86ZFHmlsYIOiHIwv/tnPInAXFvBmiuE5mmq5QCOMpADBGi5IzT7BPwbkzO7Fk2rMmXzMJ/i6GfEAuzVSUv21Xjbq9m7+5ftpE/w38Y2n7Qk5vN9tDKNrE=
In-Reply-To: <510030.76217.qm@web65411.mail.ac4.yahoo.com>
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
To: Andrew Klaassen <clawsoon@yahoo.com>
Cc: autofs@linux.kernel.org

On Fri, 2010-05-21 at 13:12 -0700, Andrew Klaassen wrote:
> I've got indirect multi-mount and single-mount maps set up in NIS like
> so:
> 
> auto.master:
> 
> /test auto.test --ghost
> 
> auto.test:
> 
> foo /    -tcp,intr server1:/foo \
>     /bar -tcp,intr server2:/bar
> abc      -tcp,intr server1:/abc
> 
> Changes to single-mount maps are picked up immediately by clients.
> 
> Changes to multi-mount maps are picked up:
> 
> 1. Immediately if nothing under the key is currently mounted.
> 
> 2. Only after an autofs restart - or sometimes even a reboot - after
> anything has been mounted under the key.
> 
> Is it possible to make #2 go away?  Having to reboot every single one
> of hundreds of client machines after a single change is a downer.

These multi-mount map entry keys should be updated, if they have
changed, after all the dependent mounts in the tree have been umounted.
They can't be updated while subordinate mounts are active because the
information about the mount tree (and dependencies within the tree) is
used during operation.

Are you sure the mount tree goes away and isn't updated at the next
mount?

Ian
