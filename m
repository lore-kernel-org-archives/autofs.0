From: raven@themaw.net
Subject: Re: Infinite loop when trying to access nonexistent
	directory (auto.home '&' substitution)
Date: Sat, 16 Oct 2004 10:49:43 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0410161048440.1363@donald.themaw.net>
References: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410151425360.7091@orion.arlut.utexas.edu>
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
To: Robert Giles <rgiles@arlut.utexas.edu>
Cc: autofs@linux.kernel.org

On Fri, 15 Oct 2004, Robert Giles wrote:

> Hi folks - I'm seeing a really unusual problem when I try to access a 
> nonexistent mount under /home - cd'ing into "/home/asdf" causes the 
> automounter to get stuck in what appears to be an infinite loop (in the 
> example below, something tried to access /home/lock and caused the 
> problem):

Can you confirm that this did not happen on the previous kernel you had 
installed?

Ian
