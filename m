From: Frank Thommen <fthommen@embl.de>
Subject: Indirect mounts with map on automounted filesystem and
	--fstype=autofs
Date: Fri, 19 Feb 2010 00:26:18 +0100
Message-ID: <4B7DCC9A.9030508@embl.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi,

(I'm sure this has already been discussed on this list but somehow I 
seem unable to find the right thread or otherwise an answer on the web...)

I need to automount subdirectories of an automounted filesystem by using
an indirect map which lies itself on an automounted filesystem:

/base/sub1/        <- mounted via auto.master and indirect map
/base/sub1/sub2/a  <- mounted via indirect a map in /base/sub1

'sub2' is a "physically" existing directory in /base/sub1 
(server1:/export/sub1, in example below).


I managed to do it with the following:


/etc/auto.master
----------------
/base  file:/etc/auto.base --ghost


/etc/auto.base
--------------
sub1   /     server1:/export/sub1 \
        /sub2 -fstype=autofs file:/main/sub1/my.map


/base/sub1/my.map
----------------------
a   servera:/export/a
b   serverb:/export/b
...



My two questions are:

a) Is this the right and recommended way to use an indirect map which is 
located on an automounted filesystem or are the better/more 
efficient/faster ways to do it?

b) is the -fstype=autofs option an official option that will stay or 
rather an unofficial option that might disappear in the future?  The 
manpages don't mention this kind of filesystem 
(autofs-5.0.1-0.rc2.131.el5_4.1 on CentOS 5.4), so I'm unsure about it's 
status.


Thank you for any hint or referral to other online documentation.

    frank
