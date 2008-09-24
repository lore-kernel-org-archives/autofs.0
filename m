From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: autofs & system libnss* libraries
Date: Wed, 24 Sep 2008 14:47:04 +0200
Message-ID: <48DA36C8.4040403@s3group.cz>
References: <48DA0F09.9090602@s3group.cz>
	<1222258619.1280.31.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1222258619.1280.31.camel@raven.themaw.net>
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
Cc: autofs@linux.kernel.org

>
> No!
>
> I considered that at the outset of version 5 development and decided
> against it after working on integrating the outdated code that was
> included in the nss_ldap distribution. Unless the situation changes
> significantly then I'm not likely to change my mind on this.
>   
Does it mean that the nss_ldap is heavily outdated then?
> I would have to write the nss code for "all" the possible sources
> against a an API that is difficult to write for, partly because the
> interface documentation is lousy. Not to mention that I'd then be at the
> mercy of nss_ldap changes and bugs, and autofs would depend on a
> configuration file that it doesn't control.
>   
My primary concern was why should we (linux distro maintainers) support
2 things essentially doing the same?
I did not mean you specifically. Maintaining the libnss* libraries
should be (probably) job for someone else - you keep focused on the
autofs-specific tasks.
And if you think your nss_ldap is better, why should not it serve other
purposes (like gathering user info from LDAP repository), too?

I mean, from the longer perspective, I believe we should merge these
things. It is neither elegant nor transparent for normal sysadmins.
>  
> Ian
>
>
>   
Ondrej
