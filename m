From: Ian Kent <raven@themaw.net>
Subject: Re: auto.master in ldap + simple bind
Date: Sat, 17 Jan 2009 14:03:01 +0900
Message-ID: <1232168581.3072.0.camel@zeus.themaw.net>
References: <49709FA6.1040203@s3group.cz>
	<1232122347.3166.102.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1232122347.3166.102.camel@zeus.themaw.net>
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

On Sat, 2009-01-17 at 01:12 +0900, Ian Kent wrote:
> On Fri, 2009-01-16 at 15:54 +0100, Ondrej Valousek wrote:
> > Hi all,
> > I am trying to configure autofs (RHEL 5.2) to gather all maps from
> > Active Directory using simple bind using proxy user.
> > I have already managed to configure the PADL nss switch to do so using this:
> > 
> > host 192.168.60.172
> > base dc=ad,dc=s3group,dc=cz
> > binddn cn=ldapproxy,cn=Users,dc=ad,dc=s3group,dc=cz
> > bindpw password
> > 
> > Now I am wondering how to do the same with the automounter. Does anyone
> > know?
> > I see lots of options on how to configure TLS or SASL, but I just need a
> > simple bind.
> 
> This might work.
> 
> authrequired="yes"
> user="cn=ldapproxy,cn=Users,dc=ad,dc=s3group,dc=cz"
> secret="password"
> 
> You might also need to play with authtype.

Of course that's contained in /etc/autofs_ldap_auth.conf

> 
> Ian
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
