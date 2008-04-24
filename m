From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: LDAP Server
Date: Thu, 24 Apr 2008 15:19:59 -0400
Message-ID: <x49lk33giw0.fsf@segfault.boston.devel.redhat.com>
References: <07A371D457B501478C1DB3C3DE8372D701783790@GSBHEX2V.gsb.uchicago.edu>
	<x49wsmngmjq.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D7017837DC@GSBHEX2V.gsb.uchicago.edu>
	<x49skxbgll7.fsf@segfault.boston.devel.redhat.com>
	<07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <07A371D457B501478C1DB3C3DE8372D70178387D@GSBHEX2V.gsb.uchicago.edu>
	(Darren Young's message of "Thu, 24 Apr 2008 13:59:09 -0500")
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

> Yep, sure can.
>
> ldapsearch -x -h <ldap_host> -D "cn=Directory Manager" -b
> "o=gsb,dc=uchicago,dc=edu" -w <password>' uid=dyoung2 cn

The "-x" option tells ldapsearch to use simple authentication (not
SASL).  Can you specify a SASL mechanism (using -Y)?  To get a list of
supported mechanisms, you can look for 'supportedSASLMechanisms' in your
directory root.

Cheers,

Jeff
