From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: autofs changes process's current working directory
Date: Mon, 14 Dec 2009 17:22:40 -0200
Message-ID: <c2d0b6ec0912141122k4050a913x142710056a5c3bda@mail.gmail.com>
References: <bd985a450909070436x2ddf0fa8l3b20e908f2f2e3c5@mail.gmail.com>
	<4ACED0F1.9050909@themaw.net>
	<c2d0b6ec0912140928v74a2c03bv6b9fd9ea5990d9cc@mail.gmail.com>
	<4B268068.1030704@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:in-reply-to:references
	:date:message-id:subject:from:to:content-type;
	bh=miCoqOnsbAIb+POXr/p5+6l4tSYoWi36Hp9jYtCfc3c=;
	b=X4HD8yYP7vLsK/9JjZlVpZGOEog+Hf2XxpuWgZeTePa+8AjUXQzxTVmHJwoi+CxICy
	nP66hpdArHGA/nCASd+X7tRhbRNEbTJpN7B6VfR2jhyLwpCh2JNjxEiEadRh+tmc2+wW
	zwZRUwCFMu1H5pFc+6zxlrz+u7LFQfcEECGmc=
In-Reply-To: <4B268068.1030704@themaw.net>
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
To: autofs@linux.kernel.org

>> I'm also getting this problem on 2.6.31 with autofs-5.0.4. Please, do you
>> remember when the fix was committed? Is this related to some (new)
>> configuration option?
>
> Have a look at your init script and the installed autofs configuration.
>
> Basically you need /dev/autofs to exist (created when the autofs4 kernel
> module is loaded) and that's about it. But the init script may be
> removing it because it thinks you don't want to use it.

Thanks, Ian. You're absolutely right. The feature/fix is there since 2.6.28
and AutoFS 5.0.4 but my distribution initscript incorrectly assumes that
the kernel doesn't support the misc device and removes /dev/autofs.

Thanks again,
Leonardo
