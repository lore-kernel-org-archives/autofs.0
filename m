From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 09:23:34 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404090917300.4861@raven.themaw.net>
References: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
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
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Thu, 8 Apr 2004, Raymond Prach wrote:

> 4. Eventually, the script attempts to mount a home directory from a 
> workstation that is down or has been removed from the network, so it waits 
> around for a long time for the mount attempt to time out

How stupid of me.

I may already have already added someting that will help with this in 
4.1.1. I gad to deal with this when I merged a patch to deal with 
replicated server mounts. Like when the mount refers to multiple 
weighted servers and needs to choose the best one. I added an rcp_ping 
function which appears to timeout much more quickly than an attempted 
mount (order of 10 seconds).

This may help you somewhat but the problem you report still needs to be 
fixed as the situation you describe could easily still happen.

Ian
