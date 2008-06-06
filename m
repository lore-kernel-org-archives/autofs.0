From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Building autofs 5.0.3 on Debian Etch
Date: Fri, 06 Jun 2008 19:40:04 +0200
Message-ID: <1212774004.6687.8.camel@eldorado>
References: <1212684111.3160.12.camel@vesuv.TechFak.Uni-Bielefeld.DE>
	<1212721768.3035.22.camel@raven.themaw.net>
	<1212760809.3160.17.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1212760809.3160.17.camel@vesuv.TechFak.Uni-Bielefeld.DE>
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

Hi again,

> > /*      non-standard track controls */
> > #define LDAP_CONTROL_PAGEDRESULTS       "1.2.840.113556.1.4.319"   /* RFC 2696 */
> 
> I introduced this via ifndef in lookup_ldap.c, where it was used, and at
> least it compiles on Debian etch. Haven't yet tested it, though :)

It works on our debian/etch mailserver with (lots of) automounted homes
as well as on a Hardy Desktop system (Sunray Server), but we don't touch
any of the ldap code yet 'cause of still using nis.

> Thanks for looking on this.
> 
> > Ian

-- 
Lukas
