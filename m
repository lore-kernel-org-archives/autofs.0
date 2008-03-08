From: Ian Kent <raven@themaw.net>
Subject: Re: Authenticated LDAP changed or broken in F8 5.0.2-27?
Date: Sat, 08 Mar 2008 12:27:57 +0900
Message-ID: <1204946877.3000.15.camel@raven.themaw.net>
References: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
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


On Tue, 2008-03-04 at 11:08 +0000, Colin Simpson wrote:
> Hi,
> 
> Did something change that has broken the authenticated LDAP
> functionality in the last update pushed to Fedora? I would have pushed
> this downstream but the upstream and downstream with Fedora seem very
> close for this project.

Yes, quite a bit has changed.

> 
> Did I see someone saying that hardly anyone was using this
> functionality? We thought we'd test this functionality and try and move
> towards getting rid of anonymous binds from our LDAP servers. It seems
> the right thing to do.
> 
> We were using a setup like this:
> 
> <autofs_ldap_sasl_conf
>         usetls="yes"
>         tlsrequired="yes"
>         authrequired="yes"
>         authtype="LOGIN"
> />

How does this get a user and secret?

> 
> But this seemed to break when we last upgraded our Fedora systems to
> 5.0.2-26 to 5.0.2-27. So we thought we'd really do it properly and use
> GSSAPI and our Kerberos setup. 
> 
> <?xml version="1.0" ?>
>          <autofs_ldap_sasl_conf
>                  usetls="yes"
>                  tlsrequired="yes"
>                  authrequired="yes"
>                  authtype="GSSAPI"
>                  clientprinc="tstpr@UNIXION.UK"
>          />
> 
> But on starting it gets so far then it seg faults (the debug is below).

We will need output from gdb.
Install the debuginfo package and post output from
gdb> thr a a bt

> 
> So we downgraded to the base version 5.0.2-16 (it's was the easiest one to get hold of). This works!!
> But it seems to let the kerberos ticket expire and not grab a new one. Are we doing something wrong or is 
> this just a bug too? (output below):
> 
> Mar  4 09:52:33 cog automount[21657]: attempting to mount entry /user/tstock
> Mar  4 09:52:33 cog automount[21657]: GSSAPI Error: Unspecified GSS failure.  Minor code may provide more information (Ticket expired)
> Mar  4 09:52:33 cog automount[21657]: sasl_bind_mech: sasl_client start failed with error: SASL(-1): generic failure: GSSAPI Error: 
> Unspecified GSS failure.  Minor code may provide more information (Ticket expired)

Interesting.

Ian
