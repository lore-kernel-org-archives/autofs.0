From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: Please help - cleanup
Date: Thu, 06 May 2004 09:30:28 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <409A4C04.1060604@freescale.com>
References: <Pine.LNX.4.58.0405022201480.25614@donald.themaw.net>
	<Pine.LNX.4.58.0405042233560.17014@donald.themaw.net>
	<16535.44980.475389.900686@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0405042308070.17014@donald.themaw.net>
	<16537.26586.135188.997029@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16537.26586.135188.997029@segfault.boston.redhat.com>
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

Jeff Moyer wrote:

> Has anyone had the chance to test this?  autofs-4.1.2-5 from my people
> page, or the patch Ian sent to the list?  I'd like to hear feedback, either
> positive or negative as I have to push a package into FC2 before the
> freeze on Friday.

I have a system running it right now and it's behaving as expected, but 
I haven't done any in depth testing of it because of other priorities. 
What would be nice is to have a suite of smoke tests that I could run 
through.  Sometimes I don't see problems with new patches until much 
later, after I thought I had wrung it out pretty well.  ;)

The bigger problem I'm facing right now is mounts dropping and not 
remounting until a HUP signal is sent to the daemon.  I've hacked around 
this by setting up a cron job to send the HUP on an hourly basis, but 
this is far from an elegant solution.

Tom
-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
