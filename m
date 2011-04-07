From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Sanity checks for brackets (escaped or
 otherwise) in server name
Date: Thu, 07 Apr 2011 22:42:52 +0800
Message-ID: <1302187372.2883.27.camel@perseus>
References: <1301649183-8467-1-git-send-email-siddhesh.poyarekar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=IchsPkwKYYIoqhtP+vin6N8G1Jc=;
	b=qizEtAnO3/V0V0eEtLmf5Q1SmCpqkn/5vjlzbDW2Jvn389f4OLn6WhHtfaw0f5bBTEHTcGu+n/5J+wNnrWREXs4HmSe0QLbedd+vRJZsQVix35B5Dv/ZYpKWJxigBdv9jZvAFd3OybW5Qcu+fo5FH6LtZOkyt2uIP0rjpWCBTNc=
In-Reply-To: <1301649183-8467-1-git-send-email-siddhesh.poyarekar@gmail.com>
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
To: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 2011-04-01 at 14:43 +0530, Siddhesh Poyarekar wrote:
> When autofs is configured as follows:
> 
> * -nodev,nosuid,intr,soft,retry=10,proto=tcp &:/tmp1
> 
> One could make a mount request as follows:
> 
> df /autom/tmp1/som\(efile
> 
> and crash automount, since automount tries to parse the brackets to
> get the weight for the server. Automount should not parse these
> brackets if they're escaped.
> 
> Also throw a syntax error in case of mismatched brackets instead of
> crashing. Sample configuration for this:
> 
> * -nodev,nosuid,intr,soft,retry=10,proto=tcp foo(2:/tmp1
> 
> Signed-off-by: Siddhesh Poyarekar <siddhesh.poyarekar@gmail.com>

Thanks for being through, but it's already in the commit queue, due to
the RHEL and Fedora bugs you logged. The patch remains attributed to
you, of course.

Can't say when the bunch of patches I have in the queue will be
committed and posted. Also, I've still got a couple of must fix bugs
before I roll them up into the next release and I'm also quite busy.

Ian
