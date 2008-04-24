From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 14:21:40 -0400
Message-ID: <x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	(Darren Young's message of "Thu, 24 Apr 2008 13:10:37 -0500")
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
To: "Young, Darren" <Darren.Young@chicagogsb.edu>
Cc: autofs@linux.kernel.org

"Young, Darren" <Darren.Young@ChicagoGSB.edu> writes:

> Getting there, have this one now:
>
> Apr 22 09:14:09 gsbtestfilervm automount[7775]: do_sasl_bind: Error
> parsing response to sasl_bind request: Authentication method not
> supported.
> Apr 22 09:14:09 gsbtestfilervm automount[7775]: do_sasl_bind: The LDAP
> server indicated that the LDAP SASL bind was incomplete, but did not
> provide the required data to proceed. LDAP SASL bind with mechanism
> LOGIN failed.
> Apr 22 09:14:09 gsbtestfilervm automount[7775]: sasl_bind_mech: sasl
> bind with mechanism LOGIN failed
> Apr 22 09:14:09 gsbtestfilervm automount[7775]: lookup_init:
> lookup(ldap): cannot initialize authentication setup
>
> LDAP is Sun directory 5.2 and I thought it supported SASL. Tried PLAIN
> and LOGIN methods, same thing. Anonymous bind is disabled on our LDAP
> hosts.

First, can you do an authenticated search from the client machine
outside of autofs?  For example, can you come up with an incantation of
ldapsearch that returns results for you?

If you can, then we can figure out how to configure your
/etc/autofs_ldap_auth.conf file.

-Jeff
