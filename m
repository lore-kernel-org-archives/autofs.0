From: Ian Kent <raven@themaw.net>
Subject: autofs4 bug fix - 1st attempt
Date: Tue, 23 Mar 2004 23:46:09 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403232330230.4953@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: autofs mailing list <autofs@linux.kernel.org>, Michael Blandford <mlblandf@sedona.ch.intel.com>


Hi Michael and autofs list,

I have a first attempt at a patch for the autofs4 kernel module to fix the 
problem you reported regarding the cd -> touch problem. Could you please 
test when you get a chance.

I need some other people to test it as well. Anyone who does give it a 
try, please let me know, successful or otherwise.

The patch(s) can be found at:

http://www.kernel.org/pub/linux/kernel/people/raven/autofs4-2.4-testing

The patches are for either vanilla kernels and the RedHat9 kernels. If 
there are problems applying them let me know. I'm not sure which 
other versions of kernel sources they will apply against but I seem to 
remember a change about 2.4.18. If additional patches against earlier 
kernels are needed, again let me know.

I will be merging these changes into a re-organized 2.6 patch set in 
the next day or so. I'll need this tested as well. I hope I can get some 
interest and feedback on this as I don't want to present faulty patches, 
asking that they be included in the kernel.

Ian
