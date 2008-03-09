From: "Colin Simpson" <Colin.Simpson@iongeo.com>
Subject: Re: Debug of autofs 5.0.2-27
Date: Sun, 09 Mar 2008 17:58:45 +0000
Message-ID: <1205085525.20863.17.camel@cowie.iouk.ioroot.tld>
References: <1204628905.26396.48.camel@cowie.iouk.ioroot.tld>
	<1204984653.4451.2.camel@raven.themaw.net>
	<1204996041.30569.14.camel@cowie.iouk.ioroot.tld>
	<1204997239.4451.8.camel@raven.themaw.net>
	<1204997376.19321.1.camel@raven.themaw.net>
	<1204997597.30569.19.camel@cowie.iouk.ioroot.tld>
	<1204998824.4502.1.camel@raven.themaw.net>
	<1204999782.30569.34.camel@cowie.iouk.ioroot.tld>
	<1205000622.4502.16.camel@raven.themaw.net>
	<1205045314.2950.11.camel@raven.themaw.net>
Reply-To: Colin.Simpson@iongeo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1205045314.2950.11.camel@raven.themaw.net>
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

That seems happier, it starts up now without the SEGV!

So far all I've done testing wise is to take SRPRM for F8 and patched.
It rebuilt the lookup_ldap.so, I took an unstripped version of that and
put it in /usr/lib/autofs. 

Will this also fix the autofs Kerberos ticket expiring? Or is that
something else? I guess I'll find out in 10 hours time.

I still need the minssf=0 (fails to work with minssf=128) in the
sasl-secprops option in openldap's slapd.conf

Thanks again

Colin

On Sun, 2008-03-09 at 06:48 +0000, Ian Kent wrote:
> 
> On Sun, 2008-03-09 at 03:23 +0900, Ian Kent wrote:
> > >
> > > In this version 5.0.2-27 in order to get autofs to bind to ldap
> with
> > > gssapi we had to change in slapd.conf on the openldap server:
> > >
> > > sasl-secprops  noplain,noactive,noanonymous,minssf=128
> > > to
> > > sasl-secprops  noplain,noactive,noanonymous,minssf=0
> > >
> > > But for some reason autofs-5.0.2-16.i386.rpm is happy with
> > > minssf=128 and binds fine, and works fine until the kerberos
> ticket
> > > expires.
> >
> > I'll investigate.
> > But the debug stuff appears to imply that the library callbacks
> aren't
> > set, which is odd, maybe there's something unusual about the way the
> > shared library data segments are handled.
> 
> After looking at the sasl library code these global callbacks
> shouldn't
> go away until the sasl library is unloaded, which would be a bit
> strange
> since we are using it at the time this happens. Additionally, this
> could
> be caused by to many calls to sasl_done() which autofs didn't call at
> all.
> 
> Anyway, autofs isn't doing things quite right, not that that should
> lead
> to this issue. The patch below shouldn't resolve this but it would be
> good if you could try it in case I'm not understanding something about
> shared library local data handling.

This email and any files transmitted with it are confidential and are intended solely for the use of the individual or entity to whom they are addressed.  If you are not the original recipient or the person responsible for delivering the email to the intended recipient, be advised that you have received this email in error, and that any use, dissemination, forwarding, printing, or copying of this email is strictly prohibited. If you received this email in error, please immediately notify the sender and delete the original.
