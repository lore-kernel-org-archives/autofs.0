From: Joseph V Moss <jmoss@ichips.intel.com>
Subject: Re: Re: automount and nsswitch.conf
Date: Tue, 13 Jul 2004 11:47:12 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4384.1089744432@ichips.intel.com>
References: <16628.1468.732296.549859@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Tue, 13 Jul 2004 11:54:36 EDT."
             <16628.1468.732296.549859@segfault.boston.redhat.com> 
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

> ==> Regarding Re: automount and nsswitch.conf; Mike Waychison <Michael.Waychison@Sun.COM> adds:
> 
> [snip]
> 
> >> Ok, my only beef here is that we are not at all honoring the semantics
> >> of nsswitch.conf.  I attest that this is a design flaw, but given the
> >> Sun automounter legacy, I see now ay around it.  We'll adhere to what is
> >> done by all other automounters, even though it's wrong and poorly
> >> documented.
> >> 
> >> So, can I make the assumption that Suns's automounter does not then
> >> honor the "reaction on lookup result", ala [NOTFOUND=return]?  If so,
> >> then
> Michael.Waychison> our job
> >> is a bit easier, though we are _still_ duplicating a parser, which I
> >> despise.  (I'll do it, I just won't like it ;)
> >> 

H.P.A. was always quite opposed to using nsswitch.conf for autofs (see
http://www.mail-archive.com/autofs@linux.kernel.org/msg00733.html and other
messages in that thread, for example), but it does seem like it's a
defacto standard that linux should be compatible with.
