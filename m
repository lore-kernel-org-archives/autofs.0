From: raven@themaw.net
Subject: Re: Re: automount and nsswitch.conf
Date: Wed, 14 Jul 2004 22:43:31 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407142238480.1633@donald.themaw.net>
References: <4384.1089744432@ichips.intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4384.1089744432@ichips.intel.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joseph V Moss <jmoss@ichips.intel.com>
Cc: autofs@linux.kernel.org

On Tue, 13 Jul 2004, Joseph V Moss wrote:

> > ==> Regarding Re: automount and nsswitch.conf; Mike Waychison <Michael.Waychison@Sun.COM> adds:
> > 
> > [snip]
> > 
> > >> Ok, my only beef here is that we are not at all honoring the semantics
> > >> of nsswitch.conf.  I attest that this is a design flaw, but given the
> > >> Sun automounter legacy, I see now ay around it.  We'll adhere to what is
> > >> done by all other automounters, even though it's wrong and poorly
> > >> documented.
> > >> 
> > >> So, can I make the assumption that Suns's automounter does not then
> > >> honor the "reaction on lookup result", ala [NOTFOUND=return]?  If so,
> > >> then
> > Michael.Waychison> our job
> > >> is a bit easier, though we are _still_ duplicating a parser, which I
> > >> despise.  (I'll do it, I just won't like it ;)
> > >> 
> 
> H.P.A. was always quite opposed to using nsswitch.conf for autofs (see
> http://www.mail-archive.com/autofs@linux.kernel.org/msg00733.html and other
> messages in that thread, for example), but it does seem like it's a
> defacto standard that linux should be compatible with.

Yes. I can understand his viewpoint. The original autofs has a character 
of its own and was never designed specifically to fit into Solaris type 
automounter environments. But this is something that many people need and 
as you say the Solaris behaviour is the defacto standard that several OSes 
implement so, for coexistence, we probably should as well.

Ian
