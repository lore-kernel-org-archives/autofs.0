From: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Subject: Re: Autofs TLS and binddn/bindpw patch.
Date: Mon, 4 Apr 2005 09:40:50 +0200
Message-ID: <20050404074050.GB1010@uranos.quantum.physik.uni-potsdam.de>
References: <424B6F70.8060802@ad2u.gr>
	<Pine.LNX.4.62.0504031757570.1663@donald.themaw.net>
	<424FF392.6070300@ad2u.gr>
	<Pine.LNX.4.58.0504041029450.27508@wombat.indigo.net.au>
Reply-To: Timo Felbinger <timo.felbinger@physik.uni-potsdam.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504041029450.27508@wombat.indigo.net.au>
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

On Mon, Apr 04, 2005 at 10:44:28AM +0800, Ian Kent wrote:
> 
> On Sun, 3 Apr 2005, mzozd wrote:
> 
> > Dear Raven,
> > 
> > please DISREGARD MY PREVIOUS PATCH. I have created two seperate patches
> > to address this issue more seriously.
> > 
> > I am attaching the patches in this e-mail and i am going to give you a
> > short explanation of what is changed and why:
> > 
> > The problem is that if an ldap server is NOT allowing anonymous binds,
> > there is no way for autofs to acquire the information from the autofs
> > schema in ldap. Thus, it is also impossible to query for the schema if
> > the ldap server ENFORCES a TLS only authenticatiion.

Hmm, autofs over TLS works well for me with anonymous binds (only the
server is authenticated, the client remains unauthenticated).
Client authentication in the TLS layer (via client certificates) should
also be possible (and probably the most convenient form of client
authentication) but I never tried this seriously (I don't consider
automount information to be highly sensitive).

> > The attached two patches address that issue by doing the following:
> > 
> > a) Open /etc/ldap.conf to read any rootbinddn option.
> > b) Open /etc/ldap.secret to read any password if the rootbinddn option
> > is in the conf.
> > c) Try to initiate TLS with the server (assuming the path to the
> > certifacte(s) is defined in /etc/openldap/ldap.conf).
> 
> We shouldn't need care about the certificate. This should be taken care of 
> with an API call either succeeding or failing.
> 
> > d) Bind with rootdn and password defines in the configuration files.
> 
> All this stuff is openldap specific.
> 
> Can we do this via an LDAP API?
> How much of this can be done using a generalised dn?
> 
> This may already be the case as I haven't had a look yet but can we 
> seperate out the LDAP implementation specific stuff to a seperate module?
> 
> > 
> > I have successfully tested this patch with the latest autofs and
> > openldap autofs schema and it works. It may be needed some minor
> > adjustments. I have tried, and as far as i tested succeed, to maintain
> > the previous behaviour of the program but other people should verify
> > that via testing.
> 
> I have another patch that generalises the dn format and cleans up the LDAP 
> module. It looks quite good but is very much out of date. The LDAP module 
> is quite ugly and certainly needs work.

I might be the author of this other patch. Last year I posted an older
version (for 4.1.3) to the list. I believe the current version has not
been mentioned yet: It's at
   http://timof.qipc.org/autofs
and it patches (only) the lookup_ldap-module of the current 4.1.4-beta
version of autofs.  It can already do TLS, and takes map names in a more
flexible format than before. In particular, it supports the "extension"-
field of ldap urls, which would be a natural place to implement a binddn
(IIRC, some rfc even recommends this as a "standard" extension). It is
currently not there but adding binddn to the patch should not be hard.
Where to take the password from is a different thing: maybe an extension
naming a file to read the password from?

This patch only addresses regular lookups, not master maps. So far, it
works well for me, but it would be good if others could test it, too.

Regards,

Timo Felbinger


-- 
Timo Felbinger                  <Timo.Felbinger@physik.uni-potsdam.de>
Quantum Physics Group           http://www.quantum.physik.uni-potsdam.de
Institut fuer Physik            Tel: +49 331 977 1793      Fax: -1767
Universitaet Potsdam, Germany
