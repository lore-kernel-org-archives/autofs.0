From: Ian Kent <raven@themaw.net>
Subject: Re: get_best_mounts fixes.
Date: Mon, 14 Feb 2005 09:03:23 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502140848520.25578@wombat.indigo.net.au>
References: <4203B1C3.30303@redhat.com>
Mime-Version: 1.0
In-Reply-To: <4203B1C3.30303@redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, 4 Feb 2005, Chris Feist wrote:

> I'm working on a patch to get the get_best_mounts function (in 
> modules/mount_nfs.c) work a little better and handle a few end cases.
> 
> What was the skiplocal variable intended to do?
> 
> It seems that if it is not 0, the only thing that get_best_mount does is 
> check and see if the 'what' string is null & if it isn't return 0.  And 
> the only time the get_best_mounts function is called with skiplocal set 
> to 1. is when it is calling itself when all the hosts have not responded 
> within 100ms.
> 
> Is it reasonable to completely remove this variable?
> 

Looking at the routine I've made a bit of a mess.
I doesn't do quite what I thought I made it do. Never mind.

I don't think that skiplocal should be removed as it should determine 
whether a check to see if the host is equivalent to localhost is done.

I'm still trying to decide, but I think that the skiplocal test in the 
early part of get_best_mount should be removed.
