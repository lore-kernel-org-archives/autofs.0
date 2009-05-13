From: Ian Kent <raven@themaw.net>
Subject: Re: HOST expansion with autofs+LDAP
Date: Wed, 13 May 2009 12:25:48 +0800
Message-ID: <4A0A4BCC.4030702@themaw.net>
References: <20090512154529.9FC3313ED0@wsnyder.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20090512154529.9FC3313ED0@wsnyder.org>
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
To: Wilson Snyder <wsnyder@wsnyder.org>
Cc: autofs@linux.kernel.org

Wilson Snyder wrote:
> I have a suse10.3 system which includes autofs-5.0.2-30.2
> 
> I'd like an LDAP entry that makes an autofs mountpoint that
> includes the local host's name.  If this wasn't under LDAP I
> believe "/net/$HOST" would work - creating a
> "/net/{name-of-hostname}" mountpoint.
> 
> However, if I add a mountpoint with cn=$HOST
> 
> cn=$HOST,nismapname=auto.net,dc=company,dc=com
> 
> The automounter nicely makes a "/net/$HOST" mount -
> *literally* /net/$HOST, that is it doesn't expand $HOST to
> the hostname.
> 
> Same thing if I use cn=${host}
> 
> Any hints?  Thanks! 

Oddly enough I think that $HOST should be expanded but I have no idea
how you think this is supposed to work because you haven't provided any
information about the LDAP entry, other than the dn, or provided any
debug log information.

Ian
