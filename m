From: Ian Kent <raven@themaw.net>
Subject: Re: stat -L triggering mount (behavior change starting
 with 2.6.38-rc1)
Date: Fri, 01 Apr 2011 12:38:53 +0800
Message-ID: <1301632733.2880.14.camel@perseus>
References: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=WkF3+T9tth2CyQ6i/+Gqa1tyfgk=;
	b=uNo6TQJ6OKwc8baCMCDRmQ1RSsTG6agbUhOOeAdL0YdiE8eCG1QW5R+wzNivx3VgMUhqPZo+AHmlefDk/nllr/av24zXoohVP60AOf2JyRoqus67zVZbFoFy3JjxFjrX2u0zzGTmwt46WR9Enbv7H0hkCa2lhXzVDr9hUXZdI74=
In-Reply-To: <AANLkTi=FfdPyVB5oiSFPbgms9Nej8LW8yfGMiYmufSCu@mail.gmail.com>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org, David Howells <dhowells@redhat.com>

On Mon, 2011-03-28 at 19:53 -0300, Leonardo Chiquitto wrote:
> 
> Bisecting the changes between 2.6.37 and 2.6.38, I found that 2.6.38-rc1
> exhibits the new behavior already. I went as near 2.6.37 as I could and verified
> that commit b650c858c2 (autofs4: Merge the remaining dentry ops tables) also
> shows the new behavior. I tried to bisect the remaining ~18 commits
> but everything
> I tested/built ended up unbootable.
> 
> I also tested mainline and verified that the problem is still there.

I suspect it will but does it also happen with 2.6.39-rc1?

Ian
