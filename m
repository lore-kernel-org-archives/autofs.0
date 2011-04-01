From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: stat -L triggering mount (behavior change starting
	with 2.6.38-rc1)
Date: Fri, 1 Apr 2011 09:13:18 -0300
Message-ID: <AANLkTiknzUmU-UNfK9j7yFheg=BQJBp8QZECwUR2SB4O@mail.gmail.com>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
	<1301632733.2880.14.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=OCvMaOIzGLnI8OLFmOHtxS19+64FA32NfZCag0W+EwE=;
	b=pmrq/c8kOp222kst7VGgj4+RXNfWhMYC6D9jWqn7AhJZBpXHCB6rD+3wLUbU+CuMVI
	Td9l8VplbvFdKFuihzBoSvnWFPC78ichwZD98OnoVDxL2KftQBLr/e/sIG8bZX/ZluFG
	pA0/yd8MT9o+ozWqPpfJx+inPqbhjPC/Ud77o=
In-Reply-To: <1301632733.2880.14.camel@perseus>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>

On Fri, Apr 1, 2011 at 1:38 AM, Ian Kent <raven@themaw.net> wrote:
> On Mon, 2011-03-28 at 19:53 -0300, Leonardo Chiquitto wrote:
>>
>> Bisecting the changes between 2.6.37 and 2.6.38, I found that 2.6.38-rc1
>> exhibits the new behavior already. I went as near 2.6.37 as I could and verified
>> that commit b650c858c2 (autofs4: Merge the remaining dentry ops tables) also
>> shows the new behavior. I tried to bisect the remaining ~18 commits
>> but everything
>> I tested/built ended up unbootable.
>>
>> I also tested mainline and verified that the problem is still there.
>
> I suspect it will but does it also happen with 2.6.39-rc1?

Yes, still reproducible with 2.6.39-rc1-vanilla+ (commit ecb78ab6f3).

Leonardo
