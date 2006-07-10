From: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Subject: Re: AFS + LDAP
Date: Mon, 10 Jul 2006 09:23:56 +0200
Message-ID: <20060710072356.GF27033@uranos.quantum.physik.uni-potsdam.de>
References: <1152189192.8761.24.camel@raven.themaw.net>
	<20060706194023.GG32706@mail.iSKUNK.ORG>
	<1152236488.2922.19.camel@raven.themaw.net>
	<20060707170919.GI32706@mail.iSKUNK.ORG>
	<1152336210.2814.23.camel@raven.themaw.net>
	<20060708075345.GA7333@mail.iSKUNK.ORG>
	<1152373694.2814.54.camel@raven.themaw.net>
	<20060709053504.GF7333@mail.iSKUNK.ORG>
	<20060709125924.GC27033@uranos.quantum.physik.uni-potsdam.de>
	<20060710022731.GG7333@mail.iSKUNK.ORG>
Reply-To: Timo Felbinger <Timo.Felbinger@physik.uni-potsdam.de>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060710022731.GG7333@mail.iSKUNK.ORG>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org
Cc: "Daniel Richard G." <skunk@iSKUNK.ORG>

On Sun, Jul 09, 2006 at 10:27:31PM -0400, Daniel Richard G. wrote:
> 
> Hmm... so this lets you encode information that would otherwise go into 
> autofs.conf (DEFAULT_{MAP,ENTRY,VALUE}_ATTRIBUTE et al.) and ldap.conf in 
> the ldap:// URL itself, eh? I take it the real power comes when you pull 
> the map entry itself via LDAP, so that you can effectively reconfigure a 
> large number of machines with a single database commit.

Yes, that's what I have ultimately in mind (not using it yet, though,
but hopefully soon)
:-)

> > If I understand this correctly (I'm not familiar with AFS), this is pretty
> > much the reason why I started to patch lookup_ldap.c in the first place:
> > to pull automount information from user account entries (rather than from
> > an independent hierarchy), with the "uid" attribute used as the autmountKey,
> > when mounting user directories. Seems the natural way of doing it to me.
> 
> Oh, absolutely. In fact, I'd been thinking of having non-user volumes live 
> in the database as user-like entities, to avoid the separate table, and 
> acknowledge the parallels between the two. (Non-user volume records would, 
> for the most part, just have a subset of a user's attributes.)
> 
> Isn't it possible to do what you describe, however, just by remapping the 
> appropriate LDAP attributes in /etc/libnss-ldap.conf? I've haven't tried 
> this yet, but I believe you could specify something like
> 
> 	nss_map_attribute automountKey uid

Yes and no: the problem with system-wide configuration files is that
they are, well, per system. I want finer granularity, with the ability
to specify filters and attribute names on a per-map basis:
On a typical workstation, I want (at least) these two maps:
- one that handles user home directories and looks below
    ou=people,ou=physik,...
  and filters for accounts valid on this host, and
- another one that looks below
    ou=hosts,ou=physik,...
  and filters for the hostname and handles local stuff like /media/usb, ...
Forcing both to use identical schemas (or identical filters) would
require some counter-intuitive tour-de-force, and I don't want to do that;
the great thing about LDAP is that it allows me to store information in
a natural structure.

Greetings,

Timo


-- 
Timo Felbinger                  http://www.felbinger.net
Quantum Physics Group           Phone:  +49 331 977 1793   Fax: -1767
Institut fuer Physik            Mobile: +49 177 735 1936
Universitaet Potsdam, Germany   PGP key-id: E92567B2
