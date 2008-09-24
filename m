From: Ian Kent <raven@themaw.net>
Subject: Re: autofs & system libnss* libraries
Date: Wed, 24 Sep 2008 20:16:59 +0800
Message-ID: <1222258619.1280.31.camel@raven.themaw.net>
References: <48DA0F09.9090602@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48DA0F09.9090602@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

On Wed, 2008-09-24 at 11:57 +0200, Ondrej Valousek wrote:
> Hi List,
> 
> I have a question - is there any plan for autofs to use the system
> libnss* libraries instead of implementing their own?

No!

> For example: If I wanted to use LDAP server to hold user accounts &
> autofs maps, I would have 2 config files to configure:
> - /etc/ldap.conf for libnss_ldap library
> - /etc/autofs_ldap_auth.conf for automounter
> It is quite confusing and it will be much more elegant to have just a
> single configuration file for both services.
> Is there any plan to do this in the future?

No!

I considered that at the outset of version 5 development and decided
against it after working on integrating the outdated code that was
included in the nss_ldap distribution. Unless the situation changes
significantly then I'm not likely to change my mind on this.

I would have to write the nss code for "all" the possible sources
against a an API that is difficult to write for, partly because the
interface documentation is lousy. Not to mention that I'd then be at the
mercy of nss_ldap changes and bugs, and autofs would depend on a
configuration file that it doesn't control.
 
Ian
