From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.5 non-expiring mounts
Date: Tue, 15 Feb 2011 20:28:53 +0800
Message-ID: <1297772933.13007.28.camel@perseus>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus> <1297741021.13007.12.camel@perseus>
	<20110215052857.GV27735@sunapee.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=rEfgQX7PO0PBNd/0sFprNEVVcyE=;
	b=iTn1A5HDk1zrAjIt/P2E1Jb3QlYMbwcOtao2Ot3YbgvmJA291S0GlaLpIM/00Cp3rMzq9KVQmZUnUYLbM7GR/9OWwH1wMQrhQQI4X9qlPUwWnaNKQkBBcv/RRmvEO2bI5fGxTTQGnguhH6wfxbQU9MX59H4wgpis7VCzi1FyQtA=
In-Reply-To: <20110215052857.GV27735@sunapee.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Mon, 2011-02-14 at 21:28 -0800, Mike Marion wrote:
> On Mon, Feb 14, 2011 at 07:37:01PM -0800, Ian Kent wrote:
> 
> > That is kernel revision and autofs revision?
> 
> 2.6.16.60-0.59.1 (Sles10 sp3 with an updated, but not bleeding edge, patch).
> autofs 5.0.5 with most of the patches up to a couple months ago.  It's hard to
> get exacts because it's a PTF from Novell (we really pushed them to upgrade to
> 5.0.5) but it should be pretty much equal to the patch they just released for
> sle 11 sp1 that they're recommending as they default going forward.

That make it hard, as you know.

But I wouldn't mind spending a bit of time on it, if you can also.

Let's assume that it's a user space problem for now.
Could you post a debug log somewhere and the current sles patched source
somewhere. If you could spend a little time trying to compare the
patches in the sles package to the ones in the Rawhide autofs repo that
would be a big help too.

Ian
