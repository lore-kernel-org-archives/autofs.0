From: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Subject: Re: Autofs TLS and binddn/bindpw patch.
Date: Tue, 5 Apr 2005 17:43:44 +0200
Message-ID: <20050405154344.GE1010@uranos.quantum.physik.uni-potsdam.de>
References: <424B6F70.8060802@ad2u.gr>
	<Pine.LNX.4.62.0504031757570.1663@donald.themaw.net>
	<424FF392.6070300@ad2u.gr>
	<Pine.LNX.4.58.0504041029450.27508@wombat.indigo.net.au>
	<20050404074050.GB1010@uranos.quantum.physik.uni-potsdam.de>
	<Pine.LNX.4.62.0504042053290.8927@donald.themaw.net>
Reply-To: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504042053290.8927@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

On Mon, Apr 04, 2005 at 08:57:43PM +0800, raven@themaw.net wrote:
> >
> >Hmm, autofs over TLS works well for me with anonymous binds (only the
> >server is authenticated, the client remains unauthenticated).
> >Client authentication in the TLS layer (via client certificates) should
> >also be possible (and probably the most convenient form of client
> >authentication) but I never tried this seriously (I don't consider
> >automount information to be highly sensitive).
> 
> That's been said before and I agree however if the server also has 
> sensitive info and will only allow secured connections for this reason 
> we probably need to cater for it.

Ok, I see. I played with SASL/TLS a while ago in a different client and
got it working, so I decided to give it a try and simply put pretty much
the same code into autofs.
The interface for using SASL with OpenLDAP is still pretty undocumented
(afaik), so much of the code is copied-and-pasted from the sample clients
in the OpenLDAP source package. Nevertheless, it seems to work quite well,
and I have put a new patch on
  http://timof.qipc.org/autofs
which can do authenticated lookups with either
- LDAP simple authentication (with arbitrary binddn and password),
  or
- SASL authentication.

So far, the only SASL mechanism I have tried is "external", which is
IMO the easiest one to set up (and it's non-interactive, which is good
in this case: we probably don't want the automounter to hang, displaying
a "password:" prompt on some terminal...).

The whole SASL part is pretty experimental; it works for me but it would
be good if others could test it and report problems. The patch should
apply cleanly to autofs-4.1.4-beta2. Except for minor changes to the
Makefiles and configure script, only the lookup_ldap module is affected,
so it should not interfere with non-LDAP stuff. To actually use SASL, you
must configure --with-sasl (in addition to --with-openldap).

Greetings,

Timo


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany
