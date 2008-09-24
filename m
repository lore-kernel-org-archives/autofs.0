From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs & system libnss* libraries
Date: Wed, 24 Sep 2008 09:31:12 -0400
Message-ID: <x493ajp7jrz.fsf@segfault.boston.devel.redhat.com>
References: <48DA0F09.9090602@s3group.cz>
	<1222258619.1280.31.camel@raven.themaw.net>
	<48DA36C8.4040403@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48DA36C8.4040403@s3group.cz> (Ondrej Valousek's message of "Wed, 
	24 Sep 2008 14:47:04 +0200")
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

Ondrej Valousek <webserv@s3group.cz> writes:

>>
>> No!
>>
>> I considered that at the outset of version 5 development and decided
>> against it after working on integrating the outdated code that was
>> included in the nss_ldap distribution. Unless the situation changes
>> significantly then I'm not likely to change my mind on this.
>>   
> Does it mean that the nss_ldap is heavily outdated then?
>> I would have to write the nss code for "all" the possible sources
>> against a an API that is difficult to write for, partly because the
>> interface documentation is lousy. Not to mention that I'd then be at the
>> mercy of nss_ldap changes and bugs, and autofs would depend on a
>> configuration file that it doesn't control.
>>   
> My primary concern was why should we (linux distro maintainers) support
> 2 things essentially doing the same?
> I did not mean you specifically. Maintaining the libnss* libraries
> should be (probably) job for someone else - you keep focused on the
> autofs-specific tasks.
> And if you think your nss_ldap is better, why should not it serve other
> purposes (like gathering user info from LDAP repository), too?
>
> I mean, from the longer perspective, I believe we should merge these
> things. It is neither elegant nor transparent for normal sysadmins.

You have to understand that nss doesn't actually support the interfaces
autofs needs.  We would have to extend the API and get that approved by
the libc folks (which they have actually agreed to do, should we choose
that route).

Now, the reason autofs doesn't use the SASL and TLS configuration
options from the ldap.conf file is simply that autofs has no business
parsing that file.  Autofs *does* use the ldap library, so whatever
you've configured in /etc/openldap/ldap.conf should work for autofs.

I hope this helps.

Cheers,

Jeff
