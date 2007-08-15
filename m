From: Nail El-Sourani <sourani@math.uni-muenster.de>
Subject: Re: autofs5 duplicate entries
Date: Wed, 15 Aug 2007 13:03:23 +0200
Message-ID: <46C2DD7B.5020702@math.uni-muenster.de>
References: <46A747E0.7070202@math.uni-muenster.de>	
	<C9AD2899A176C0499022697035E7625A19CC01@houmbx5.anadarko.com>	
	<1185529315.3203.61.camel@raven.themaw.net>	
	<46A9C4BB.6090208@math.uni-muenster.de>	
	<1185549408.3203.64.camel@raven.themaw.net>	
	<C9AD2899A176C0499022697035E7625A19CC2B@houmbx5.anadarko.com>	
	<1187082727.4963.13.camel@raven.themaw.net>	
	<C9AD2899A176C0499022697035E7625A19CCFE@houmbx5.anadarko.com>
	<1187154006.3249.7.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1187154006.3249.7.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org, "Wolfe, Allan" <Allan.Wolfe@anadarko.com>

Hi Ian,

That hack is indeed present in OpenSolaris. I can confirm the below
patch is working 100%. Will it be merged into autofs5?

Thx,
*nail

Ian Kent wrote:
> On Tue, 2007-08-14 at 17:44 -0500, Wolfe, Allan wrote:
>> Good question.
>>
>> I spent some time testing today.  They only test box I could quickly
>> test on was a Solaris 8 with patch 108993-36 applied that affects
>> autofs, NSS, PAM, ldapclient and associated user utilities (this patch
>> is quite old --> current is 108993-67).
>>
>> The results were quite surprising as I distinctly remember having to
>> insert those delimited cn entries for the benefit of Solaris back 3
>> years ago when we integrated LDAP into our enterprise.  Bottom line, I
>> see that a delimited entry is seemingly no longer needed.  No matter
>> what the test case that was run, the cn as described in the dn prevailed
>> by default to appear as the stub.  Oddly, when accessing a mount
>> directly pathed as an alternate cn, it would mount and appear in that
>> form.  Here are notes from my testing below:
> 
> But you guys confirmed that the % hack is present in OpenSolaris so
> perhaps the patch below will provide the behavior we need.
> 
> Could someone try this patch out please.
> 
> ---
> diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> index de8d515..7cb4e58 100644
> --- a/modules/lookup_ldap.c
> +++ b/modules/lookup_ldap.c
> @@ -1226,34 +1226,50 @@ static int read_one_map(struct autofs_point *ap,
>  		 * value.
>  		 */
>  		count = ldap_count_values_len(bvKey);
> -		if (count > 2) {
> -			error(ap->logopt,
> -			      MODPREFIX
> -			      "key %.*s has duplicate entries - ignoring",
> -			      bvKey[0]->bv_len, bvKey[0]->bv_val);
> -			goto next;
> -		} else if (count == 2) {
> +		if (count > 1) {
>  			unsigned int i;
>  
>  			/* Check for the "/" and "*" and use as "/" if found */
>  			for (i = 0; i < count; i++) {
> -				/* check for wildcard */
> -				if (bvKey[i]->bv_len != 1)
> -					continue;
> -				if (*bvKey[i]->bv_val != '/' &&
> -				    *bvKey[i]->bv_val != '*')
> +				bvKey[i]->bv_val[bvKey[i]->bv_len] = '\0';
> +
> +				/*
> +				 * If multiple entries are present they could
> +				 * be the result of people using the "%" hack so
> +				 * ignore them.
> +				 */
> +				if (strchr(bvKey[i]->bv_val, '%'))
>  					continue;
> -				/* always use '/' internally */
> -				*bvKey[i]->bv_val = '/';
> +
> +				/* check for wildcard */
> +				if (bvKey[i]->bv_len == 1 &&
> +				    (*bvKey[i]->bv_val == '/' ||
> +				     *bvKey[i]->bv_val == '*')) {
> +					/* always use '/' internally */
> +					*bvKey[i]->bv_val = '/';
> +					k_val = bvKey[i]->bv_val;
> +					k_len = 1;
> +					break;
> +				}
> +
> +				/*
> +				 * We have a result from LDAP so this is a
> +				 * valid entry. Set the result to the LDAP
> +				 * key that isn't a wildcard and doesn't have
> +				 * any "%" hack values present. This should be
> +				 * the case insensitive match string for the
> +				 * nis schema, the default value.
> +				 */
>  				k_val = bvKey[i]->bv_val;
> -				k_len = 1;
> +				k_len = bvKey[i]->bv_len;
> +
>  				break;
>  			}
>  
>  			if (!k_val) {
>  				error(ap->logopt,
>  				      MODPREFIX
> -				      "key %.*s has duplicate entries - ignoring",
> +				      "invalid entry %.*s - ignoring",
>  				      bvKey[0]->bv_len, bvKey[0]->bv_val);
>  				goto next;
>  			}
> @@ -1509,34 +1525,48 @@ static int lookup_one(struct autofs_point *ap,
>  		 * value.
>  		 */
>  		count = ldap_count_values_len(bvKey);
> -		if (count > 2) {
> -			error(ap->logopt,
> -			      MODPREFIX
> -			      "key %.*s has duplicate entries - ignoring",
> -			      bvKey[0]->bv_len, bvKey[0]->bv_val);
> -			goto next;
> -		} else if (count == 2) {
> +		if (count > 1) {
>  			unsigned int i;
>  
>  			/* Check for the "/" and "*" and use as "/" if found */
>  			for (i = 0; i < count; i++) {
> -				/* check for wildcard */
> -				if (bvKey[i]->bv_len != 1)
> +				bvKey[i]->bv_val[bvKey[i]->bv_len] = '\0';
> +
> +				/*
> +				 * If multiple entries are present they could
> +				 * be the result of people using the "%" hack so
> +				 * ignore them.
> +				 */
> +				if (strchr(bvKey[i]->bv_val, '%'))
>  					continue;
> -				if (*bvKey[i]->bv_val != '/' &&
> -				    *bvKey[i]->bv_val != '*')
> -					continue;
> -				/* always use '/' internally */
> -				*bvKey[i]->bv_val = '/';
> -				k_val = bvKey[i]->bv_val;
> -				k_len = 1;
> +
> +				/* check for wildcard */
> +				if (bvKey[i]->bv_len == 1 &&
> +				    (*bvKey[i]->bv_val == '/' ||
> +				     *bvKey[i]->bv_val == '*')) {
> +					/* always use '/' internally */
> +					*bvKey[i]->bv_val = '/';
> +					k_val = bvKey[i]->bv_val;
> +					k_len = 1;
> +					break;
> +				}
> +
> +				/*
> +				 * The key was matched by LDAP so this is a
> +				 * valid entry. Set the result key to the
> +				 * lookup key to provide the mixed case
> +				 * matching provided by the "%" hack.
> +				 */
> +				k_val = qKey;
> +				k_len = strlen(qKey);
> +
>  				break;
>  			}
>  
>  			if (!k_val) {
>  				error(ap->logopt,
> -					MODPREFIX "key %.*s has duplicate entries",
> -					bvKey[0]->bv_len, bvKey[0]->bv_val);
> +					MODPREFIX "no valid key found for %.*s",
> +					qKey_len, qKey);
>  				ret = CHE_FAIL;
>  				goto next;
>  			}
> 
