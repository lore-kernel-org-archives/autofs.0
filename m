From: Ian Kent <raven@themaw.net>
Subject: Re: Segfault on lookups with wildcards
Date: Sat, 06 Mar 2010 14:23:20 +0800
Message-ID: <1267856600.2130.9.camel@localhost>
References: <20100304212310.GA16319@libre.l.ngdn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=E5+bsR8g8DhcqNGRK64+LqpdE3Q=;
	b=OBS4j94QSw80J3VWXbJJkjh+hapf2iavgds2zL1HxPPOcEVRKVuHZgpZy52rqtdyE5HxhPmqukkdPTV9U0v71+uFLpVc95Rlf4aqtW8nnMhIx38eCxrWRG9lySQs2/Kc+yjW0+B0niVpvachekkSyqApzTneuEB9ojaY3G0WSwE=
In-Reply-To: <20100304212310.GA16319@libre.l.ngdn.org>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2010-03-04 at 18:23 -0300, Leonardo Chiquitto wrote:
> Hello,
> 
> There is a problem in AutoFS (5.0.5 plus all patches released so far)
> related to negative caching of keys that start with an '*'.


This is quite strange.

This bug has been in the code for years but in the last few days I've
had three reports of the problem and now you've also seen it.

My initial change used a strcmp for both the tests in your patch but I
need to go right through the code and have a look at all the tests
against '*'. I also thought about whether we should add keys with a
wildcard in them but the hassle is dealing keys that have an escaped '*'
in them and dealing with negative requests so we can avoid unnecessary
mount attempts.

> 
> How to reproduce:
> 
> # cat /etc/auto.master
> /nfs	/etc/auto.nfs
> 
> # cat /etc/auto.nfs
> *	-ro,hard,intr,nolock 10.1.1.4:/export/&
> 
> # stat '/nfs/*foo'
> 
> Automount will segfault (please see logs attached) in lookup_mount()
> (lookup_file.c:1075):
> 
> 1074				me = cache_lookup_distinct(mc, key);
> 1075				me->status = now + ap->negative_timeout;
> 
> (gdb) print me
> $1 = (struct mapent *) 0x0
> 
> Here's the call trace for reference:
> 
> #0  0x00007fc74e22c423 in lookup_mount (ap=<value optimized out>,
> name=<value optimized out>, name_len=<value optimized out>,
> context=<value optimized out>)
>     at lookup_file.c:1075
> #1  0x00007fc74fdbd065 in lookup_name_file_source_instance
> (ap=0x7fc74ffffc00, map=0x7fc74ffffd10, name=0x7fc74fd60ea0 "*foo",
> name_len=4) at lookup.c:707
> #2  0x00007fc74fdbd958 in lookup_nss_mount (ap=0x7fc74ffffc00,
> source=0x0, name=0x7fc74fd60ea0 "*foo", name_len=4) at lookup.c:894
> #3  0x00007fc74fdb3d76 in do_mount_indirect (arg=0x7fc74ffffc00) at
> indirect.c:813
> #4  0x00007fc74f416a3f in start_thread (arg=0x7fc74fd63710) at
> pthread_create.c:297
> #5  0x00007fc74f180ecd in clone () at
> ../sysdeps/unix/sysv/linux/x86_64/clone.S:112
> #6  0x0000000000000000 in ?? ()
> 
> If I understand correctly, the code assumes that "me" will never be
> NULL because cache_update() was called a couple of lines above to insert
> the key into the cache.
> 
> The problem is that cache_update() won't add the key into the cache
> if it starts with an '*', as we can see in lib/cache.c:1067:
> 
> 	me = cache_lookup(mc, key);
> 	while (me && me->source != ms)
> 		me = cache_lookup_key_next(me);
> 	if (!me || (*me->key == '*' && *key != '*')) {	<===
> 		ret = cache_add(mc, ms, key, mapent, age);
> 
> I verified that a patch like this will fix the problem:
> 
> Index: autofs-5.0.5/lib/cache.c
> ===================================================================
> --- autofs-5.0.5.orig/lib/cache.c
> +++ autofs-5.0.5/lib/cache.c
> @@ -719,7 +719,7 @@ int cache_update(struct mapent_cache *mc
>  	me = cache_lookup(mc, key);
>  	while (me && me->source != ms)
>  		me = cache_lookup_key_next(me);
> -	if (!me || (*me->key == '*' && *key != '*')) {
> +	if (!me || (*me->key == '*' && (strcmp(key, "*") != 0))) {
>  		ret = cache_add(mc, ms, key, mapent, age);
>  		if (!ret) {
>  			debug(logopt, "failed for %s", key);
> 
> 
> However, I'm not sure if it is correct. The test "*key == '*'" appears
> in other functions, so I was wondering if it's a good idea to add keys
> with wildcards into the cache after all.
> 
> Thanks!
> Leonardo
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
