From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: Autofs 5.0.1-0rc2.102 failing to query LDAP (Windows
 2008	AD)
Date: Mon, 07 Sep 2009 11:14:00 +0200
Message-ID: <4AA4CED8.9020001@s3group.cz>
References: <4A9EA5C8.8010301@ocsl.co.uk> <4A9F5CE8.7050509@s3group.cz>
	<4AA12149.6020609@ocsl.co.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AA12149.6020609@ocsl.co.uk>
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
To: Jack Challen <jack_challen@ocsl.co.uk>
Cc: autofs@linux.kernel.org

Hi Jack,

> I've been trying to avoid GSSAPI, because I believe it requires the 
> machine to be a fully paid-up member of the AD. In my environment 
> that's very tricky to impossible[1].
Ok, you might also want to try simple authentication or even anonymous 
access to AD - that should work, too (and would also be easier to deploy 
in your diskless environment) - I just did not cover it in my blog as it 
is insecure. The only thing I know that authentication using 
SASL/DIGEST-MD5 does not work because of the bug I mentioned.
> 1. Some of the longer lines in the quoted files appear truncated. They 
> cut-n-paste fine though.
> 2. I've found that removing /var/cache/samba/winbind* seems to work 
> for cache clearing.
> 3. You probably mean "getent passwd" (instead of "password"), and for 
> some reason in my case it still doesn't return the AD users (though 
> wbinfo -u does). The users can still authenticate though.
Thanks for the hints - I have updated the blog (I know it truncates long 
lines, unfortunately there is nothing I can do with it).
Cheers,

Ondrej
