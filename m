From: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Subject: 'browse mode' issue
Date: Mon, 22 Sep 2008 17:52:24 +0200
Message-ID: <48D7BF38.5020709@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org, sterjan@mandriva.com

Hello list. I've several questions about browse mode option.

First, I have opposite reports about the effects of 'browse mode' option 
in automount configuration. Some times ago, a user reported than setting 
it to 'no' was CPU-unfriendly, so we turned it to 'yes' by default in 
mandriva package:
https://qa.mandriva.com/show_bug.cgi?id=31901

However, I now have another report than allowing browse was harmful on 
large networks, causing lots of IP collisions.

So, I'm curious at what should be a good default value for this option.

Second, having a look at the code, it seems 'yes' is the default in the 
binary, but, but default configuration file set it to 'no', which is 
quite disturbing. If there is a good default value for this option (and 
even if there was not), I'd rather have consistent default values in 
both places.

Last issue, I can't find a correct description on what this option does 
exactly anywhere :)
-- 
Guillaume Rousse
Moyens Informatiques - INRIA Futurs
Tel: 01 69 35 69 62
