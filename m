From: Ian Kent <raven@themaw.net>
Subject: Re: "Use bind instead of nfs if host is localhost" feature
 is broken? removed?
Date: Sun, 13 Mar 2011 09:32:15 +0800
Message-ID: <1299979935.2906.5.camel@perseus>
References: <20110310235943.GA19588@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=uo+8+4m/O779GN34vtChKSELphU=;
	b=p3v6F0RDHWEOwcvhD28ANTvnkfMf9F18YwRlNGRsiJVw5nIUNUo0GLcnlyGIdxlE6Zv320zkrn+wMBbJE74+pfNfUa66x6KjsLpHzktMh0xV6RqI+ADGfUOXQfMVatEUKJmYUH/6Tz7QaPnDqmYsBqmYWrd3TtPB6+zjK72V1+4=
In-Reply-To: <20110310235943.GA19588@mrv.com>
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
To: Nye Liu <nyet@mrv.com>
Cc: autofs@linux.kernel.org

On Thu, 2011-03-10 at 15:59 -0800, Nye Liu wrote:
> I have been relying on the behavior that
> 
> foo	host:/export/foo
> 
> uses 'bind' if host is localhost, and 'nfs' otherwise...
> 
> i.e. if i am on the machine "host", /export/foo is mounted on /mnt/foo using
> bind, but if i am not on "host", host:/export/foo is mounted on /mnt/foo
> using nfs.
> 
> But the latest version of autofs no longer does that.

What latest version?

> 
> Do i have to use this everywhere now?
> 
> foo	(1),host(2):/export/foo
> 
> The behavior is more like what I expect, but it seems wasteful.
> 
