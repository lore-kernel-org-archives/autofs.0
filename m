From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5: unable to locate ldap master map
Date: Thu, 29 Jun 2006 20:59:57 +0800
Message-ID: <1151585997.3915.36.camel@raven.themaw.net>
References: <44A25311.2040501@inria.fr>
	<1151554184.2929.45.camel@raven.themaw.net> <44A3B6CD.5030403@inria.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44A3B6CD.5030403@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 2006-06-29 at 13:17 +0200, Guillaume Rousse wrote:
> Ian Kent wrote:
> > On Wed, 2006-06-28 at 11:59 +0200, Guillaume Rousse wrote:
> >> I just tested autofs5 (beta5), and I'm a bit confused about using
> >> LDAP-defined master map... Especially when eveything worked out of the
> >> box with autofs 4 :)
> > 
> > Yes.
> > 
> > I had an incorrect LDAP test database and so this was somewhat broken.
> > There are a number of patches for beta5 on kernel.org and at least a
> > couple more coming. Have you applied them all.
> > 
> > There's a patch_order-5.0.0_beta5 which gives the order they need to be
> > applied.
> Ouch, 17 patches :(

Just missed I think.
I consolidated to beta6 just now.

> 
> >> First, how the master map is located is still a bit obscure for me...
> >> >From the man page, it seems they are two different way to find it:
> >> - file based
> >> - nss based
> >> The first occurs when automount argument or default value for this
> >> argument is an explicit filename, the second occurs otherwise
> >>
> >> nss-based master map lookup use the line 'automount' in
> >> /etc/nsswitch.conf, and may use at least the following values (from
> >> autofs4 init script):
> >> - file
> >> - ldap
> >> - nis
> > 
> > nisplus should also work but I'm unable to test this.
> > Anyone care to try this?
> And please document them also... what file will be looked for by nss if
> 'file' option is used there ?

Don't understand the question?

> 
> >> Explanations about how behave each of those option is missing, but I
> >> expect ldap value to behave as previously, meaning automagically using
> >> openldap libraries.
> > 
> > It does and it uses the configured defaults to the extent that the
> > openldap library calls do.
> > 
> >> So, to use a an ldap master map, I could either
> >> 1) used file-based master map lookup, by using "/usr/sbin/automount
> >> /etc/autofs/auto.master" (or just "/usr/sbin/automount" as it is the
> >> default value), and insert something as:
> >> +ldap:ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
> > 
> > or just have +auto.master and autofs will know not to look for a file
> > based master map of the same name if files is listed as a nss source.
> As automount argument or as master map file content ?
> 
> I guess the second, as that's also the content of the sample master map
> file given. However, I really find its meaning obscure: from man page
> explanations about this syntax ("+ [map-type,format:]map[options]"), it
> seems to be a map name without type, which doesn't have default value.

no default => try map sources in nsswitch.

> 
> > I'm not sure I've tested the ldap spec (no server present) above with
> > the recent fixes. I'll check that.

Functions as expected.

> > 
> >> 2) using nss-based master map lookup, by using "/usr/sbin/automount
> >> name-without-path", and insert a "ldap" value in "automount" line in
> >> "/etc/nsswitch.conf"
> > 
> > Yep. Or just use the default name which is auto.master.
> Right (according to include/default.h), but then man page template has
> to be corrected: it gives "@autofsmapdir@@/auto.master" as default.

Oops. I'll fix that.

> 
> > The default name can be set in the autofs config by uncommenting the
> > line:
> > 
> > DEFAULT_MASTER_MAP_NAME="auto.master"
> > 
> > and changing auto.master to what you require.
> I'm still not sure however what is this file meant for: is this
> automount daemon configuration file (aka read by it whatever way you
> launch it) or the init script configuration file (aka read by the shell
> init script to give additional configurations options, such as
> command-line arguments) ?

Is used whichever way you launch it.
Except for the OPTIONS variable which is only used in the init script to
pass command line options.

> 
> >From your answer, it seems it is both, which make me feels unconfortable.

Why.
Don't you like having the same configuration whether you launch autofs
from the init script or the command line.

> 
> >> However, the only way I found to force nss-based master map lookup was
> >> "/usr/sbin/automount +auto.master" (where description says: name has no
> >>  path), or to add +auto.master in auto.master file (where documentation
> >> says: + [map-type,format:]map[options]) and use file-based lookup.
> Which makes me still wonder:
> - what does mean description by "name has no path" ? No / inside ?
> - what the meaning of this name, if it is just a boolean trigger to use
> nss to locate master map ? it could as well be "foobar" then

Mmm .. it should be illegal to pass "+<mapname>" on the command line.
Plus included maps are "only legal in file maps".
I'll check that.

"name has no path" should mean that the name has no "/"s

Don't follow the rest of this question.

Perhaps you could craft a patch that would clear this up?

> 
> [..]
> >> - what are precedence with system configuration for openldap libraries ?
> > 
> > Don't understand what you mean here?
> > 
> > If you specify a server name it will be used.
> > If not the LDAP default will be used.
> > If you specify a map only like:
> > 
> > ldap:auto.master
> > 
> > This should use the the LDAP default base and autofs default or
> > configured schema.
> > 
> > Otherwise you must use a full dn such as:
> > 
> > ldap:ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
> > 
> > consistent with requirements of LDAP utility commands.
> I was purely speaking of LDAP connection parameters, not LDAP content
> handling.
> 
> I have no idea about openldap librarie API or usage in C, so I may be
> absolutly wrong here, but basically, openldap library configuration
> (classicaly, /etc/openldap/ldap.conf) already handle everything needed
> to contact (including secure connection parameters) LDAP server. So what
> is the use of distinct LDAP configuration for autofs, and additional
> SSL/TLS support there ?

Again I'm not clear on which configuration you are talking about.
Can you be specific as to the configuration options that are duplicated?

> 
> 
> [..]
> >> - are they supposed to be exported in environment before launching
> >> automount, passed to it through a bunch of -Dkey=value ?
> > 
> > Not needed.
> > The values in the config are read at startup by /usr/sbin/automount.
> > They may be overridden by values that are exported in the environment
> > prior to running /usr/sbin/automount.
> See my previous comment about distinction between program configuration
> and init script configuration. Only init script configuration should use
> /etc/sysconfdir (which happens to be /etc/default under Debian), and
> program configuration should use plain /etc or /etc/autofs location.

And /etc/default should be used by configure on a Debian system
and /etc/conf.d on a Gentoo system.

I think the division is OK myself.

> 
> > The -D option cannot be used to set these values.
> > This option is used for macro substitution in mount map entries not to
> > set program defaults.
> OK.
> 
> >> The only hints I was able to collect were those error messages in the logs:
> >> Jun 28 11:45:13 alceste automount[4191]: get_server_SASL_mechanisms: No
> >> SASL authentication mechanisms are supported by the LDAP server.
> >> Jun 28 11:45:13 alceste automount[4191]: lookup_init: lookup(ldap):
> >> cannot initialize auth setup
> > 
> > I believe there may still be a problem with this bit of the LDAP code.
> > Sorry, I'm aware of it.
> I've just applied available patches, I'll test ASAP.

Sorry.
Just missed with beta6.

> 
> >> If this matter, I build autofs with --with-mapdir=/etc/autofs as
> >> argument, on x86_64 running mandriva cooker. And i'm running a 2.6.17
> >> kernel.
> > 
> > 2.6.17 is good.
> > 
> > You will find 2 additional kernel patches on kernel.org.
> > You may need them as well but possibly not, depending on the map types
> > used.
> > 
> > I'm planing to update the kernel patches in the distribution soon.
> I have no hand on the distribution kernel, unfortunatly, and I'm even
> using a contributed kernel for those test, not the official mandriva one :/

2.6.17 should be fine.

Ian
