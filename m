From: "Colin Simpson" <Colin.Simpson@iongeo.com>
Subject: Re: Authenticated LDAP changed or broken in F8 5.0.2-27?
Date: Sat, 08 Mar 2008 17:10:10 +0000
Message-ID: <1204996210.30569.17.camel@cowie.iouk.ioroot.tld>
References: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
	<1204946877.3000.15.camel@raven.themaw.net>
	<1204990385.29708.4.camel@cowie.iouk.ioroot.tld>
	<1204995440.4451.3.camel@raven.themaw.net>
Reply-To: Colin.Simpson@iongeo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204995440.4451.3.camel@raven.themaw.net>
Content-Class: urn:content-classes:message
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


On Sat, 2008-03-08 at 16:57 +0000, Ian Kent wrote:
> 
> On Sat, 2008-03-08 at 15:33 +0000, Colin Simpson wrote:
> > On Sat, 2008-03-08 at 03:27 +0000, Ian Kent wrote:
> > >
> > >
> > > > Did I see someone saying that hardly anyone was using this
> > > > functionality? We thought we'd test this functionality and try
> and
> > > move
> > > > towards getting rid of anonymous binds from our LDAP servers. It
> > > seems
> > > > the right thing to do.
> > > >
> > > > We were using a setup like this:
> > > >
> > > > <autofs_ldap_sasl_conf
> > > >         usetls="yes"
> > > >         tlsrequired="yes"
> > > >         authrequired="yes"
> > > >         authtype="LOGIN"
> > > > />
> > >
> > > How does this get a user and secret?
> > >
> > Does it not come from bind info in /etc/ldap.conf ?
> 
> That config file belongs to nss_ldap, and has nothing to do with
> openldap or autofs.
> 
> Ian

I also had a binddn and bindpw in /etc/openldap/ldap.conf.

Thanks

Colin


-- 
Colin Simpson
Manager of Information Technology Europe
ION 
[direct]  +44 131 200 4788 
[office]  +44 131 557 5595 

www.iongeo.com    

This email and any files transmitted with it are confidential and are intended solely for the use of the individual or entity to whom they are addressed.  If you are not the original recipient or the person responsible for delivering the email to the intended recipient, be advised that you have received this email in error, and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. If you received this email in error, please immediately notify the sender and delete the original.
