From: raven@themaw.net
Subject: Re: get_best_mounts fixes.
Date: Sat, 5 Feb 2005 12:42:39 +0800 (WST)
Message-ID: <Pine.LNX.4.61.0502051235580.1673@donald.themaw.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Chris Feist <cfeist@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, 4 Feb 2005, Chris Feist wrote:

> I'm working on a patch to get the get_best_mounts function (in 
> modules/mount_nfs.c) work a little better and handle a few end cases.

Sounds great.

I really appreciate having Jeff and yourself helping out so much.
It's so much better to have people to challenge your thinking and 
contribute stuff to get the old grey matter wheels turning.

>
> What was the skiplocal variable intended to do?

Good question. I'll have a look and get back.

I don't want to escape the blame for this but ...

When I first got that patch it looked fine but was badly broken. I've 
reworked the code a good number of times now so there's bound to be 
oddities in it that I've missed.

>
> It seems that if it is not 0, the only thing that get_best_mount does is 
> check and see if the 'what' string is null & if it isn't return 0.  And the 
> only time the get_best_mounts function is called with skiplocal set to 1. is 
> when it is calling itself when all the hosts have not responded within 100ms.
>
> Is it reasonable to completely remove this variable?

I'll have a look.

Ian
