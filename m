From: "Daniel Richard G." <skunk@iskunk.org>
Subject: Re: [PATCH] More autofs cleanup
Date: Mon, 14 Aug 2006 12:21:13 -0400
Message-ID: <20060814162112.GK1695@mail.iSKUNK.ORG>
References: <20060811023733.GC26249@mail.iSKUNK.ORG>
	<x4964gv7br4.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x4964gv7br4.fsf@segfault.boston.devel.redhat.com>
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
To: autofs@linux.kernel.org

On Mon, 2006 Aug 14 08:17:03 -0400, Jeff Moyer wrote:
>  		pthread_cleanup_push(cache_lock_cleanup, mc);
> -		mapent = alloca(strlen(me->mapent) + 1);
> -		mapent_len = sprintf(mapent, me->mapent);
> +		mapent_len = strlen(me->mapent);
> +		mapent = alloca(mapent_len + 1);
> +		strcpy(mapent, me->mapent);
>  		pthread_cleanup_pop(0);
> -		mapent[mapent_len] = '\0';
>  	}
>  done:
>  	cache_unlock(mc);
> 
> This is just a refactoring of code with no real gain.  The previous usage
> was correct.

Well, there were some problems with the previous code...

1. It passes a variable format string to sprintf()---the cause of the 
   original warning, and a potential crash/security bug. (What happens if 
   me->mapent contains instances of "%s"?)

2. It takes the length of me->mapent twice. (Not something I addressed,
   but if you're okay with it, you could change that strcpy() into a 
   memcpy())

3. In general, it was less clear/straightforward than it could have been. 
   There are times when it's useful to grab the return value of sprintf(), 
   but here, it's pointless (and unsafe...)


> As Ian mentioned before, posting patches inline makes it easier to quote in
> the reply (at least for my arcane mailer.  ;).

Understood. My experience has been that things in the main body tend to get 
mangled, but here I see that's not a problem.

> The rest up to this point looks pretty good to me.  Thanks a bunch for
> doing this!

Sure thing :)


--Daniel


-- 
NAME   = Daniel Richard G.       ##  Remember, skunks       _\|/_  meef?
EMAIL1 = skunk@iskunk.org        ##  don't smell bad---    (/o|o\) /
EMAIL2 = skunk@alum.mit.edu      ##  it's the people who   < (^),>
WWW    = http://www.******.org/  ##  annoy them that do!    /   \
--
(****** = site not yet online)
