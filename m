From: Jack Challen <jack_challen@ocsl.co.uk>
Subject: Re: Autofs 5.0.1-0rc2.102 failing to query LDAP (Windows
 2008	AD)
Date: Fri, 04 Sep 2009 15:16:41 +0100
Message-ID: <4AA12149.6020609@ocsl.co.uk>
References: <4A9EA5C8.8010301@ocsl.co.uk> <4A9F5CE8.7050509@s3group.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A9F5CE8.7050509@s3group.cz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

Hello Ondrej,

On 03/09/09 07:06, Ondrej Valousek wrote:
> There is no problem with autofs - the real problem is, that windoze do
> not follow RFC's in subsequent authentication (which autofs is using).
> I have reported the problem to Microsoft and they agreed (internal
> bugreport was generated).
> The workaround is to use GSSAPI authentication instead - more at
> ondarnfs.blogspot.com

Thanks,

I've been trying to avoid GSSAPI, because I believe it requires the machine to be a fully paid-up member of the AD. In 
my environment that's very tricky to impossible[1].
However, your method appears to work very well (although I had to add MASTER_MAP_NAME="ldap://addns/cn=auto.master,..." 
to my /etc/sysconfig/autofs).

I've now got autofs querying AD for automount information using Microsoft's default "nisMap" schema.

As an aside, some minor comments on your (useful) blog:

1. Some of the longer lines in the quoted files appear truncated. They cut-n-paste fine though.
2. I've found that removing /var/cache/samba/winbind* seems to work for cache clearing.
3. You probably mean "getent passwd" (instead of "password"), and for some reason in my case it still doesn't return the 
AD users (though wbinfo -u does). The users can still authenticate though.

1: Separate issue:
The reason it's so difficult is because these machines (the Linux "clients") are essentially transient. They're 
diskless, often only just created, and as stateless as possible. I haven't yet worked out a way of pre-creating an AD 
computer account such that a dummy user can join the machine to the AD. I can do it manually, but if I use dsadd to 
pre-create the account it requires an Administrative User's password for the "net ads join". Not so handy when we might 
have e.g. 100 machines to add as quickly as possible. [Pointers gratefully received :-) ]

Anyway, thanks for the pointers, and the blog
cheers
jack
