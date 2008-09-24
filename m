From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: autofs & system libnss* libraries
Date: Wed, 24 Sep 2008 16:00:53 +0200
Message-ID: <48DA4815.2020806@s3group.cz>
References: <48DA0F09.9090602@s3group.cz>	<1222258619.1280.31.camel@raven.themaw.net>	<48DA36C8.4040403@s3group.cz>
	<x493ajp7jrz.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x493ajp7jrz.fsf@segfault.boston.devel.redhat.com>
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


> You have to understand that nss doesn't actually support the interfaces
> autofs needs.  We would have to extend the API and get that approved by
> the libc folks (which they have actually agreed to do, should we choose
> that route).
>   
Yes, I have heard the libc API needs some extension....
> Now, the reason autofs doesn't use the SASL and TLS configuration
> options from the ldap.conf file is simply that autofs has no business
> parsing that file.  Autofs *does* use the ldap library, so whatever
> you've configured in /etc/openldap/ldap.conf should work for autofs.
>
>   
Ok, let me explain in detail what I was after, actually:

In my company, we use Centrify (www.centrify.com) DirectControl to
integrate Linux RHEL boxes into Win 2003 Active Directory.
Now, in Centrify they did quite an amount of work to make everything
working nicely:
1) they provide the system with their own set of libnss_centrifydc
libraries so you can use them in nsswitch.conf like this:

passwd   centrifydc files
group   centrifydc files

2) The libnss_centrifydc library does all the heck with communicating
with AD. AD is nothing strange, having it extended with RFC 2307
attributes, it behaves like a normal LDAP server. What the
libnss_centrifydc does for you is SASL encrypted channel with the
Windows domain controller - something PAINFUL (if possible) to do with a
plain libss_ldap.
3) The libnss_centrifydc will also provide you with a Kerberos principal
so that SASL is possible for other apps
...
4) That means that I can gather all necessary info securely from AD. But
the automounter. How perfect would it be if I could just add:

automount     centrifydc files

in my nsswitch.conf to add support for automounter, too! I know, both
libc and centrify folks would have to be informed and API changed to
support autofs in general, but the benefit would be massive for me - I
could solely rely on centrifydc_nss and encrypted SASL channel for
everything.

Now, I have to feed automounter via NIS which is something I would like
to get rid of, if possible.

I understand I do not care as much about Centrify, but hopefully it will
give you some explanation why I (and other system integrators too) would
welcome the libc & autofs merge.

Ondrej


> I hope this helps.
>
> Cheers,
>
> Jeff
>   
