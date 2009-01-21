From: Ian Kent <raven@themaw.net>
Subject: Re: auto.master in ldap + simple bind
Date: Wed, 21 Jan 2009 22:22:38 +0900
Message-ID: <1232544158.3931.40.camel@zeus.themaw.net>
References: <49709FA6.1040203@s3group.cz>
	<1232122347.3166.102.camel@zeus.themaw.net>
	<1232168581.3072.0.camel@zeus.themaw.net>
	<4608.82.208.2.231.1232305306.squirrel@webmail.s3group.com>
	<1232332943.3136.28.camel@zeus.themaw.net>
	<4976ECB9.6090207@s3group.cz>
	<1232542998.3931.37.camel@zeus.themaw.net>  <49771F04.102@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49771F04.102@s3group.cz>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Wed, 2009-01-21 at 14:11 +0100, Ondrej Valousek wrote:
> Ian,
> To recap:
> Win2k8 comes with RFC2307 compliance so I wanted to try to connect
> autofs (all maps) to it.
> I did not want to play with GSSAPI - it is too complicated. But neither
> I wanted simple anonymous bind - too insecure. So I see Win2k8 supports
> SASL/DIGEST-MD5, verified with ldapsearch that it works, I also see
> autofs5 supports it - so I wanted to use it.
> Unfortunately it is broken at the autofs side (see my previous post).

What is the actual SASL user dn?
Does your ldapsearch work without the -b option?

> Ondrej
> 
> > Have you tried GSSAPI, doesn't Windows require Kerberos auth by default?
> > Are you sure that the Windows server is allowing simple binds (that was
> > what you wanted right)?
> >
> > Ian
> >
> >
> >   
> 
