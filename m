From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: Please help - cleanup
Date: Thu, 06 May 2004 11:04:48 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <409A6220.80403@freescale.com>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
	<16535.44980.475389.900686@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
	<16537.26586.135188.997029@segfault.boston.redhat.com>
	<409A4C04.1060604@freescale.com> <1083858912.5890.411.camel@d158140025182>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1083858912.5890.411.camel@d158140025182>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs mailing list <autofs@linux.kernel.org>

Chris Croswhite wrote:
> I ran this on 40 clients last evening through our normal regression runs
> (9 hours, 1.5T of data, 127 mount points) and found that it behaved as
> expected.

I should clarify, the mount dropping problem I mentioned in my last 
message is not specifically related to testing autofs-4.1.2-5 (or any 
4.1.2, I think).  I've got 4.1.1 rolled out and those systems are the 
ones dropping mounts, at least at this point in time.  My intention is 
to find a autofs release or set of patches that fixes this behavior 
sooner rather than later as it is causing problems for my users.

Just for my sanity, can anyone help me confirm the following "facts" 
about earlier behavior of the autofs-4.1.0pre10 release:

1.  NIS maps were not cached by the automounter daemon
2.  changes made to the maps and pushed out went into effect 
immediately, regardless of whether or not the changes were new key/mount 
entries to an existing map or just changes to existing key/mount pairs 
withing an existing map.

> I also think that it would be nice to have some form of
> regressions/tests to help validate.

I think it's time to start developing some.  Since Red Hat tests their 
software before they ship it, maybe they have a suite already in place 
that they could share? ;)

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
