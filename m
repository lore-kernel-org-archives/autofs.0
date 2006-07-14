From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] Code cleanup
Date: Fri, 14 Jul 2006 21:28:47 +0800
Message-ID: <1152883727.27851.19.camel@raven.themaw.net>
References: <20060714021338.GL29064@mail.iSKUNK.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060714021338.GL29064@mail.iSKUNK.ORG>
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
To: "Daniel Richard G." <skunk@iskunk.org>
Cc: autofs@linux.kernel.org

On Thu, 2006-07-13 at 22:13 -0400, Daniel Richard G. wrote:
> Hello hello,
> 
> First off, is there a public CVS/SVN repository for autofs?

There is a CVS repo but I'm going to stop updating it soon.
Use the git repo under http://www.kernel.org/git/

> 
> I grabbed the -rc1 tarball, figured I'd try building it with my usual devel 
> CFLAGS, and... wow. This code's got _issues_, maaan....

Nasty young man!
So you've forced me to go through the cleanup exercise.
Had to be done sooner or later anyway.

> 
> See the attached omnibus patch. Commentary follows, in patch order (more or 
> less). Of course, not all these changes need to go in as-is, but they 
> should at least bring attention to some spots that could really use it.
> 
> 
> (various files):
> 
> * Don't use "#if WITH_FOO", as this produces a warning if WITH_FOO is 
>   undefined. Use "#ifdef".

Oops.

> 
> daemon/automount.c:
> 
> * 'mc' is used many times as a local variable in this file; rename the 
>   global instance to 'mrc' to avoid gratuitous shadowing
> 
> * 'mrc' (nee 'mc') is not needed outside of this file; declare as static
> 
> * Two fields in struct master_readmap_cond were not specified in the 
>   initializer for 'mrc' (nee 'mc')
> 
> * 'sc' is used many times as a local variable in this file; rename the 
>   global instance to 'suc' to avoid gratuitous shadowing

Yep. Ugly fixed.

> 
> include/automount.h:
> 
> * Disable the OpenBSD syslog.h #include with a cpp conditional, not a 
>   comment. This is a bit safer.

Not relevant, that stuffs going, actually nearly gone.

> 
> * The "extern struct master_readmap_cond mc" declaration is not used
> 
> include/lookup_ldap.h:
> 
> * Added appropriate WITH_KERBEROS and WITH_SASL cpp conditionals, to avoid 
>   breakage when the respective libraries are not used.
> 
>   (Note: WITH_KERBEROS is a new conditional; support for it needs to be 
>   added to the configure script)

Don't think I'll do this.
The SASL code is dependent on the Kerberos stuff so I really need to
make the SASL conditional on it. But currently there aren't any checks
for the Kerberos libs in configure.in so this will have to be done a bit
later.

> 
> * Comment the #endifs if the opening #ifdef is far away

I don't like to do this.

> 
> include/state.h:
> 
> * Removed a superfluous comma

Oops.

> 
> lib/cache.c:
> 
> * Eliminated "implicit cast to unsigned type" warnings
> 
> lib/cat_path.c:
> 
> * Tweaked the _strlen() function: Eliminated the unnecessary de-consting 
>   cast, and rewrote the logic w.r.t. 'max' (this is unsigned, therefore the 
>   max<0 check is pointless; it's not nice to modify your arguments; pointer 
>   arithmetic sucks)
>   
>   P.S.: _strlen() should really have a return type of size_t, but I didn't 
>   care enough to change this.

Now this was a good catch.
Fixed.

> 
> lib/master.c:
> 
> * Eliminated a stray semicolon

Oops.

> 
> * Straightened out some unnecessary variable const-ness
> 
> lib/master_parse.y:
> 
> * #define YYENABLE_NLS and YYLTYPE_IS_TRIVIAL to zero; #ifdefs with these 
>   appear in the generated code, and you get warnings if they are not 
>   defined

Yep and there were similar issues with the Flex modules.
Fixed.

> 
> lib/mounts.c:
> 
> * m_dev and m_ino are 'long unsigned int' values, so cast them to avoid 
>   sscanf() format warnings

Fixed.

> 
> lib/nss_parse.y:
> 
> * Same deal with YYENABLE_NLS and YYLTYPE_IS_TRIVIAL

Ditto above.

> 
> * Aaaarg! C++ comments in C code! Kill 'em! Kill 'em!

Cleaned and sanitized.

> 
> lib/rpc_subs.c:
> 
> * You don't want to use a local variable named 'h_errno'.
> 
> 	fusion:/tmp$ grep h_errno /usr/include/netdb.h
> 	   We use a macro to access always the thread-specific `h_errno' variable. */
> 	#define h_errno (*__h_errno_location ())
> 	...
> 
>   (There were some places that used h_errno without declaring it locally. 
>   I'm assuming that nowhere was this meant to refer to the global netdb.h 
>   h_errno variable.)

Double oops, another good catch.
Fixed.

> 
> modules/lookup_file.c:
> modules/lookup_hosts.c
> 
> * What first caught my attention here was a warning that me->mapent is 
>   being passed in as a format string to sprintf() without further arguments 
>   (lots of fun if there's a "%s" in there somewhere), but that line and the 
>   one before seemed a bit bizarrely written to me. (You call strlen() on a 
>   string, then use sprintf() as an unsafe strcpy() replacement, and grab 
>   the return value to get the length of that same string??) Replaced with 
>   something more straightforward.

Hehe, cleaned.

> 
> lookup_ldap.c:
> 
> * What the heck is '?:' supposed to return if the expression is true? (Not 
>   valid C90, at any rate)

Ya well, I changed it.

> 
> * My OpenLDAP 2.1.30 header does not define LDAP_SCOPE_ONE. It does,
>   however, define LDAP_SCOPE_ONELEVEL.

OK. caught me on that.
Fixed.

> 
> * 'struct mapent me' is unused
> 
> * More mapent/mapent_len silliness

And fixed and cleaned.

> 
> modules/mount_nfs.c:
> 
> * This looks like a bug to me. Does it look like a bug to you?

Definitely, and found another during the process.
Fixed.

> 
> modules/replicated.c:
> 
> * You don't want to use a local variable named h_addr, either.
> 
> 	fusion:/tmp$ grep h_addr /usr/include/netdb.h
> 	  int h_addrtype;               /* Host address type.  */
> 	  char **h_addr_list;           /* List of addresses from name server. */
> 	#define h_addr  h_addr_list[0]  /* Address, for backward compatibility. */

Aggh .. caught me again, yet another good catch.
Fixed.

> 
> 
> There's still a ton of warnings, mostly of variables shadowing other 
> variables, but those affect code clarity more so than correctness.
> 

I'm not quite finished the cleanup yet but clone the repo and have another go at it.

Ian
