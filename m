From: Nail El-Sourani <sourani@math.uni-muenster.de>
Subject: Re: autofs5 duplicate entries
Date: Fri, 27 Jul 2007 16:17:34 +0200
Message-ID: <46A9FE7E.5060909@math.uni-muenster.de>
References: <46A747E0.7070202@math.uni-muenster.de>	
	<1185426784.3329.2.camel@raven.themaw.net>	
	<60626.128.176.181.43.1185447773.squirrel@wwwmath1.uni-muenster.de>	
	<1185452066.3329.7.camel@raven.themaw.net>	
	<39281.128.176.181.43.1185458179.squirrel@wwwmath1.uni-muenster.de>
	<1185509689.3203.22.camel@raven.themaw.net>
Reply-To: support@math.uni-muenster.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185509689.3203.22.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

tried to get your patch working. Using CentOS5 which comes with
autofs5.0.1-0.rc2-43... i needed to upgrade to 5.0.2. though. did this
from http://www.kernel.org/pub/linux/daemons/autofs/v5/, patching all
patches for 5.0.2 as described in patch order, then applied the patch u
sent me....

AND

it works!

thx a lot. Do you think this patch or something similar will make it
into mainline?

*nail

Ian Kent wrote:
> On Thu, 2007-07-26 at 15:56 +0200, sourani@math.uni-muenster.de wrote:
>>>> Actually this is an LDAP mixed environment with solaris and linux. The
>>>> Solaris Automounter will look for %Java by default to ignore
>>>> case-sensitivity. Is there an option on autofs5 to take the first entry
>>>> for a key in case there are duplicate entries? if so, how is it done? i
>>>> am
>>>> seriously in need of some kind of workaround. is there any possibility?
> 
> Can you point me to any official documentation that describes exactly
> how this % hack is supposed to work?
> 
>>> There isn't .
>>> This would conflict with the work that was done to reduce the number of
>>> queries to LDAP servers.
>>>
>>> I wasn't aware of the Solaris % function.
>>> I'll check when I get some time.
>>>
>>> I could try and make a one-off patch to just use the first entry as a
>>> work around for you till we work out what to do about the % thingy.
> 
> Could you try this patch for the work around please.
> Ian
> 
> ---
> --- autofs-5.0.2/modules/lookup_ldap.c.ignore-duplicates	2007-07-27 11:33:59.000000000 +0800
> +++ autofs-5.0.2/modules/lookup_ldap.c	2007-07-27 11:53:45.000000000 +0800
> @@ -1238,7 +1238,15 @@ static int read_one_map(struct autofs_po
>  			/* Check for the "/" and "*" and use as "/" if found */
>  			for (i = 0; i < count; i++) {
>  				/* check for wildcard */
> -				if (bvKey[i]->bv_len != 1)
> +				if (bvKey[i]->bv_len > 1) {
> +					/* Sun % hack workaround */
> +					if (*bvKey[i]->bv_val == '%') {
> +						k_val = bvKey[0]->bv_val;
> +						k_len = bvKey[0]->bv_len;
> +						break;
> +					}
> +					continue;
> +				} else if (bvKey[i]->bv_len != 1)
>  					continue;
>  				if (*bvKey[i]->bv_val != '/' &&
>  				    *bvKey[i]->bv_val != '*')
> @@ -1521,7 +1529,15 @@ static int lookup_one(struct autofs_poin
>  			/* Check for the "/" and "*" and use as "/" if found */
>  			for (i = 0; i < count; i++) {
>  				/* check for wildcard */
> -				if (bvKey[i]->bv_len != 1)
> +				if (bvKey[i]->bv_len > 1) {
> +					/* Sun % hack workaround */
> +					if (*bvKey[i]->bv_val == '%') {
> +						k_val = bvKey[0]->bv_val;
> +						k_len = bvKey[0]->bv_len;
> +						break;
> +					}
> +					continue;
> +				} else if (bvKey[i]->bv_len != 1)
>  					continue;
>  				if (*bvKey[i]->bv_val != '/' &&
>  				    *bvKey[i]->bv_val != '*')
> 
