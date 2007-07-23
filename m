From: Jim Summers <jsummers@bachman.cs.ou.edu>
Subject: Re: AutoFS and LDAP
Date: Mon, 23 Jul 2007 13:26:06 -0500
Message-ID: <46A4F2BE.9070903@cs.ou.edu>
References: <46A10097.1020403@cs.ou.edu>
	<1185203252.3263.6.camel@raven.themaw.net>
Reply-To: autofs@linux.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1185203252.3263.6.camel@raven.themaw.net>
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

Ian Kent wrote:
> On Fri, 2007-07-20 at 13:36 -0500, Jim Summers wrote:
>> Hello All,
>>
>> I have been attempting to get autofs5 to work with my ldap config.  The way I 
>> am set up is:
>>
>> FC6 / FC7 clients and redhat servers.
>> auto.home info for each user is stored in ldap
>> auto.master is stored locally on each client
>>
>> The mounts do not happen.  Here is what I see when starting autofs:
>> ======
>> Jul 20 13:22:53 lch automount[3427]: Starting automounter version 5.0.1-11, 
>> master map auto.master
>> Jul 20 13:22:53 lch automount[3427]: using kernel protocol version 5.00
>> Jul 20 13:22:53 lch automount[3427]: master_error: syntax error while parsing map.
>> Jul 20 13:22:53 lch automount[3427]: mounted indirect mount on /misc with 
>> timeout 300, freq 75 seconds
>> Jul 20 13:22:53 lch automount[3427]: mounted indirect mount on /net with 
>> timeout 300, freq 75 seconds
> 
> Does this patch fix the problem?

Yes, that did the trick.  Now on to figuring out what type of authentication 
autofs4 was using to do the lookups.  All that was config'd before was the 
ldap.conf stuff, so this autofs_ldap_auth.conf is all about.



Thanks again.


> Ian
> 
> ---
> diff --git a/lib/master_tok.l b/lib/master_tok.l
> index 9bfeefa..ff69a24 100644
> --- a/lib/master_tok.l
> +++ b/lib/master_tok.l
> @@ -272,7 +272,7 @@ OPTTOUT		(-t{OPTWS}|-t{OPTWS}={OPTWS}|--timeout{OPTWS}|--timeout{OPTWS}={OPTWS})
>  		return DNSERVER;
>  	}
>  
> -	{DNATTRSTR} {
> +	{DNATTRSTR}/"=" {
>  		strcpy(master_lval.strtype, master_text);
>  		return DNATTR;
>  	}
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
Jim Summers
School of Computer Science-University of Oklahoma
-------------------------------------------------
