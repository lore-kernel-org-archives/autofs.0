From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: autofs changes process's current working directory
Date: Mon, 14 Dec 2009 15:28:15 -0200
Message-ID: <c2d0b6ec0912140928v74a2c03bv6b9fd9ea5990d9cc@mail.gmail.com>
References: <bd985a450909070436x2ddf0fa8l3b20e908f2f2e3c5@mail.gmail.com>
	<4ACED0F1.9050909@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:received:in-reply-to:references
	:date:message-id:subject:from:to:content-type;
	bh=+aKHW2Kwg9xY4rLAKWfPjR0+FdDu6eZNBHuVIGBfTBY=;
	b=RulhGSWsFqZbT22NKFzenJY810nxJ/srkPw91LMsHD+o0QeqX6LwKXWUXI8mXe3kho
	MB0nR/X12cuvW+C5FtTC0/n+W2Xoo0HImRxE5a3TwwWpapV29XSS6wLKNHTGa4OKPxth
	L1x+r+zAutoop6w9xrthrv0w4IdKmjMoymyCw=
In-Reply-To: <4ACED0F1.9050909@themaw.net>
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

>> I'm experiencing a problem with autofs. It seems that when a process
>> is inside an automounted nfs filesystem, if I restart the automount
>> daemon the current working directory of the process is changed and a
>> few leading directory are removed leading to a non-existent cwd.
>
> That's right.
>
> It's because, with older user space and kernel, the mount is detached
> from the mount tree by a "umount -l" at restart when trying to cleanup
> stale mounts.
>
> Note that this is a non-trivial problem and took a long time to fix.
>
> What autofs and kernel are you using?

Ian,

I'm also getting this problem on 2.6.31 with autofs-5.0.4. Please, do you
remember when the fix was committed? Is this related to some (new)
configuration option?

Thanks!
Leonardo
