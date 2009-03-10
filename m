From: Ian Kent <raven@themaw.net>
Subject: Re: autofs updating ghost direcotry for removable devices
Date: Tue, 10 Mar 2009 09:43:44 +0900
Message-ID: <49B5B7C0.8050907@themaw.net>
References: <20090309225352.GA22229@SamZwo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090309225352.GA22229@SamZwo>
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
To: Nathan Huesken <autofs@lonely-star.org>
Cc: autofs@linux.kernel.org

Nathan Huesken wrote:
> Hi,
> 
> I am using autofs with the ghost parameter.
> What I would like is autofs to update the "ghost directories" according
> to removable devices plugged in or removed.
> I found this:
> http://code.google.com/p/hal-autofs/
> 
> This python program rewrites the autofs config file when a device is
> plugged in or removed. Very good.
> Now I need to figure out how to make autofs aware of these changes.
> I could just restart autofs (I first need to refresh my python to do
> that).
> 
> I wonder:
> 
> Could I get into trouble when restarting autofs while a autofs
> managed device is mounted?

Possibly, depends if a mount is in use.

> 
> Does anybody have a better Idea of how to do what I want to do?

man automount(8), snd it a HUP signal.

> 
> Thanks!
> Nathan
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
