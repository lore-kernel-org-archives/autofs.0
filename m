From: raven@themaw.net
Subject: Re: Autofs picking first server from the automounter map
 all the time
Date: Sat, 1 May 2004 12:15:20 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405011212050.5768@donald.themaw.net>
References: <D85B695BF793684EA72C8E481FB1D9A1225096@nycmgexm004.leh.lbcorp.lehman.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <D85B695BF793684EA72C8E481FB1D9A1225096@nycmgexm004.leh.lbcorp.lehman.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Patel, Rahulkumar [NJ]" <rahul@lehman.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

On Fri, 30 Apr 2004, Patel, Rahulkumar [NJ] wrote:

> Hi,
> I have following entry defined in the automounter map.
> But, when I try to access it all the time it pick last server defined for
> that mount.
> 
> perl -ro,soft,nosuid,noquota,intr server1:/vol/vol1/software/perl
> server2:/vol/vol1/software/perl.
> 
> 
> When I cd /home/perl --> All the time I connect to server2.
> 
> I am running autofs-3.1.7-21.
> 
> Does anyone has idea why this is happening ?
> 

I'm not sure if this should work in v3.

It should work in 4.1.1 and above but it seems that I have broken that 
behaviour when I merged the patch for it. I'll have to fix it.

However an entry like:

perl -ro,... server1,server2:/vol/vol1/software/perl

works as expected.

Ian
