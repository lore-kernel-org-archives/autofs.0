From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Building autofs 5.0.3 on Debian Etch
Date: Fri, 06 Jun 2008 16:00:09 +0200
Message-ID: <1212760809.3160.17.camel@vesuv.TechFak.Uni-Bielefeld.DE>
References: <1212684111.3160.12.camel@vesuv.TechFak.Uni-Bielefeld.DE>
	<1212721768.3035.22.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1212721768.3035.22.camel@raven.themaw.net>
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

Hi,

Thanks to autofs and kernel rebuilds I'm getting quite confident in
packaging and patching debian and ubuntu packages :)

> > LDAP_CONTROL_PAGEDRESULTS seems to have been introduced somewhere in
> > between openldap 2.1.30-13.3, which debian etch uses, and 2.4.7, which
> > Ubuntu Hardy uses. On Hardy, autofs5 5.0.3 compiles just fine.
> 
> Caught by a missing definition.
> It must have been defined in the version of Openldap I originally used,
> even though the page control functions weren't present.

Openldap is/was very scary, at least it runs quite stable since quite a
while now. But it's very promising to replace our NIS/YP in the coming
(weeks/months/years/whatever) with something that's more manageable :)
 
> It may be enough to add the definition but it's also possible that calls
> I've used in the functions (when configure finds they are missing)
> aren't present in older openldap installs either.
> I'll check it out soon as I can.
> 
> >From /usr/include/ldap.h.
> 
> /*      non-standard track controls */
> #define LDAP_CONTROL_PAGEDRESULTS       "1.2.840.113556.1.4.319"   /* RFC 2696 */

I introduced this via ifndef in lookup_ldap.c, where it was used, and at
least it compiles on Debian etch. Haven't yet tested it, though :)

Thanks for looking on this.

> Ian

-- 
Lukas
