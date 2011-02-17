From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.5 non-expiring mounts
Date: Thu, 17 Feb 2011 15:57:13 +0800
Message-ID: <1297929433.15852.6.camel@perseus>
References: <alpine.LSU.2.00.1102161700370.29435@tux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=vW3iS54tYxJc/pOTaDwzG/EcCXI=;
	b=Tv2hyNM2WG2kRleScUAeNkcRIYhZ+vRKIkq8aIM5tZd7kE47QV5Q7SsrT9q52C3zTV5Oa8LHiLZLrLg4Xwd10A3Nipt2ATJAvcFEjqsPDNfxQfjWaGCzIPnbrMxVRQeLmDZ8PckMviX3Yh8y6rJYNa0dVsZN8orsp+jOWUmEVlA=
In-Reply-To: <alpine.LSU.2.00.1102161700370.29435@tux.qualcomm.com>
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
To: Deke Clinger <dclinger@qualcomm.com>
Cc: autofs@linux.kernel.org

On Wed, 2011-02-16 at 17:08 -0800, Deke Clinger wrote:
> On Wed Feb 16 12:18:15 UTC 2011 Ian Kent wrote:
> 
> > A backtrace generally doesn't do us any good when were trying to find an
> > expire problem, the debug log is where we have to start on these.
> 
> I've got a debug log from a sled10sp3 machine running the Novell autofs
> 5.0.5 update. Ian - could I mail you this personally? I'd rather not have
> this log with usernames, paths, hostnames, etc. on a public archive.

Yes please.

> 
> FWIW, I did do a test with autofs5.0.5 built from source with all the
> patches in the patch order list from kernel.org and it demonstrated the
> same behavior: a USR1 signal unmounted the direct map entries but not the
> indirect. I changed the maps to files, pruned them to a few hundred entries
> and converted the indirect entries to direct and re-ran the
> test. Configured like this all entries unmounted upon a USR1 signal so I do
> believe this has something to do with direct vs indirect mounts. 

There are a couple of possibilities. I'm always working with the current
source and basic testing includes expiring both direct and indirect
mounts as a matter of course and I'm not seeing this. So there has to be
more to it or I have one or other patches already in the queue that
resolve the problem.

Does this happen straight away or start after some time of running?
Do all indirect mounts stop expiring or only some?
What is the for of the indirect map entries, are they multi-mount
entries?

Obviously the debug log will probably answer most of these questions.

Ian
