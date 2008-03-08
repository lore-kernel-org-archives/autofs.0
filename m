From: Ian Kent <raven@themaw.net>
Subject: Re: Authenticated LDAP changed or broken in F8 5.0.2-27?
Date: Sun, 09 Mar 2008 02:25:48 +0900
Message-ID: <1204997148.4451.6.camel@raven.themaw.net>
References: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
	<1204946877.3000.15.camel@raven.themaw.net>
	<1204990385.29708.4.camel@cowie.iouk.ioroot.tld>
	<1204995440.4451.3.camel@raven.themaw.net>
	<1204996210.30569.17.camel@cowie.iouk.ioroot.tld>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204996210.30569.17.camel@cowie.iouk.ioroot.tld>
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
To: Colin.Simpson@iongeo.com
Cc: autofs@linux.kernel.org


On Sat, 2008-03-08 at 17:10 +0000, Colin Simpson wrote:
> On Sat, 2008-03-08 at 16:57 +0000, Ian Kent wrote:
> > 
> > On Sat, 2008-03-08 at 15:33 +0000, Colin Simpson wrote:
> > > On Sat, 2008-03-08 at 03:27 +0000, Ian Kent wrote:
> > > >
> > > >
> > > > > Did I see someone saying that hardly anyone was using this
> > > > > functionality? We thought we'd test this functionality and try
> > and
> > > > move
> > > > > towards getting rid of anonymous binds from our LDAP servers. It
> > > > seems
> > > > > the right thing to do.
> > > > >
> > > > > We were using a setup like this:
> > > > >
> > > > > <autofs_ldap_sasl_conf
> > > > >         usetls="yes"
> > > > >         tlsrequired="yes"
> > > > >         authrequired="yes"
> > > > >         authtype="LOGIN"
> > > > > />
> > > >
> > > > How does this get a user and secret?
> > > >
> > > Does it not come from bind info in /etc/ldap.conf ?
> > 
> > That config file belongs to nss_ldap, and has nothing to do with
> > openldap or autofs.
> > 
> > Ian
> 
> I also had a binddn and bindpw in /etc/openldap/ldap.conf.

That may have been used.
If the LDAP library will use it internally then it would be used.
Generally autofs doesn't use other systems config files, at least not
directly.

Ian
