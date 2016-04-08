From: Ian Kent <raven@themaw.net>
Subject: Re: Near-simultaneous automount of multiple directories fails
Date: Fri, 08 Apr 2016 16:54:39 +0800
Message-ID: <1460105679.2979.2.camel@themaw.net>
References: <alpine.LRH.2.11.1604080846130.26210@carrot.ant.ipd.priv>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=e8u1Ydh6kKq0Xxx4PzN56zGRWE0=; b=q6Ffzo
	R6mHXE/ajqHC7OMXXUx7W2qxPLih/srNOtPAR1hyPTdq1u8jD5xyjrv5ElEJj6i1
	/h33iwvQkfc3zMBFLmctVEOXTxB8QPVEyXNBUGS6hDJ1IIRFlvmqIuoXcw4Z5k5b
	A+YyEFzzaBZs1HAv028JzulxjGW5KOhBusE5Y=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=e8u1Ydh6kKq0Xxx
	4PzN56zGRWE0=; b=GZWmH+c7poqRHCIo8dL2OjfoXmhAvtCpLp3u8PPqxmzVXVW
	uc0DJ4S1gGQ76w8aPS5PeBcO0CkDfxpWCn00wgJCPb3HhiBj/RpHPYSxvKNxmiSy
	aEGjtDbIdzy74UgscMarpzBDe+b/VR6kD6f3qK6fa9T/auazKW/owMsqcDBU=
In-Reply-To: <alpine.LRH.2.11.1604080846130.26210@carrot.ant.ipd.priv>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Marcel De Boer <marcel.de_boer@nokia.com>, autofs@vger.kernel.org

On Fri, 2016-04-08 at 09:55 +0200, Marcel De Boer wrote:
> Hi!
> 
> I've already reported this on the CentOS bug tracker a while ago, but
> I 
> thought I'd report it here too.
> 
> https://bugs.centos.org/view.php?id=9835
> 
> Summarized (there's more information on the bug report): on one of our
> servers we initially saw that every few days one home directory became
> inaccessible. This happened to two different homedirectories (but only
> one 
> at a time) out of the couple hundred we have. We traced this to 
> simultaneously scheduled cron scripts running out of the affected 
> homedirectories, which caused both directories to be mounted nearly 
> simultaneously.
> 
> A test setup on a different machine (the primary description from the
> bug 
> report, as the server was not stock CentOS) also showed that if we had
> cron simultaneously mount four directories every 10 minutes, only half
> of 
> them would get mounted every time. On this machine an RPM rebuild of 
> autofs made the issue disappear, but it was much more persistent on
> the 
> server.
> 
> Eventually it seems that there is an issue in mount_mount() from 
> mount_nfs.c; to my untrained eye, it looks like it can get called 
> simultaneously from different threads, where they change shared 
> information, probably the 'hosts' or 'tmp' lists.

Whatever the problem is it isn't access to either of these two variables
or the lists they may represent.

They are both local variables of the mount_mount() function and so
cannot be accessed simultaneously by any other function.

Ian
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
