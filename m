From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5: unable to locate ldap master map
Date: Sun, 2 Jul 2006 03:11:54 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>
References: <44A25311.2040501@inria.fr>
	<1151554184.2929.45.camel@raven.themaw.net>
	<44A3B6CD.5030403@inria.fr> <1151585997.3915.36.camel@raven.themaw.net>
	<44A4E38D.7020004@inria.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44A4E38D.7020004@inria.fr>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 30 Jun 2006, Guillaume Rousse wrote:

> Ian Kent wrote:
> >>>> nss-based master map lookup use the line 'automount' in
> >>>> /etc/nsswitch.conf, and may use at least the following values (from
> >>>> autofs4 init script):
> >>>> - file
> >>>> - ldap
> >>>> - nis
> >>> nisplus should also work but I'm unable to test this.
> >>> Anyone care to try this?
> >> And please document them also... what file will be looked for by nss if
> >> 'file' option is used there ?
> > 
> > Don't understand the question?
> 'file' option for nss user service means 'look for /etc/passwd'. What
> does it means for nss automount service ?

There must always be a map name given.
So it looks for this map name in the configured autofs map dir.

> 
> And how do you avoid loops if you can make nss look for a file, and a
> file trigger nss lookup ?

Maybe you are talking about plus included maps.
autofs won't include a map of the same name as the one it's reading.
There's a limit on the depth of plus included maps.

> 
> >>>> Explanations about how behave each of those option is missing, but I
> >>>> expect ldap value to behave as previously, meaning automagically using
> >>>> openldap libraries.
> >>> It does and it uses the configured defaults to the extent that the
> >>> openldap library calls do.
> >>>
> >>>> So, to use a an ldap master map, I could either
> >>>> 1) used file-based master map lookup, by using "/usr/sbin/automount
> >>>> /etc/autofs/auto.master" (or just "/usr/sbin/automount" as it is the
> >>>> default value), and insert something as:
> >>>> +ldap:ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
> >>> or just have +auto.master and autofs will know not to look for a file
> >>> based master map of the same name if files is listed as a nss source.
> >> As automount argument or as master map file content ?
> >>
> >> I guess the second, as that's also the content of the sample master map
> >> file given. However, I really find its meaning obscure: from man page
> >> explanations about this syntax ("+ [map-type,format:]map[options]"), it
> >> seems to be a map name without type, which doesn't have default value.
> > 
> > no default => try map sources in nsswitch.
> So basically, it is:
> - a way to trigger nss master map lookup even if using file master map
> lookup primarily

There's only ever one master map possibly with plus included sections.
There's still only one.
It is never "looked up" it's read and parsed.

Map (not the master map) keys are "looked up" and the filesystem locations 
they correspond to are then used to attempt to mount the filesystem.

> - a specific syntax not described in auto.master man page

The master map syntax is described in auto.master(5).
Map entry (not master map) format is described in autofs(5).

Read the litrature for a general understanding of automount if the man 
pages aren't enough.

I'll never include the detail that's in books such as
Managing NFS and NIS, Eisler & Labiaga, chapter 9 or
NFS Illustrated, Callaghan, chaper 11.

You may also find
http://www.themaw.net/autofs_linux_kongress
useful although some of the description is now out of date.

The man pages will only ever attempt to describe the formats and give 
information about differences in a relatively basic way.

> 
> >>> I'm not sure I've tested the ldap spec (no server present) above with
> >>> the recent fixes. I'll check that.
> > 
> > Functions as expected.
> > 
> >>>> 2) using nss-based master map lookup, by using "/usr/sbin/automount
> >>>> name-without-path", and insert a "ldap" value in "automount" line in
> >>>> "/etc/nsswitch.conf"
> >>> Yep. Or just use the default name which is auto.master.
> >> Right (according to include/default.h), but then man page template has
> >> to be corrected: it gives "@autofsmapdir@@/auto.master" as default.
> > 
> > Oops. I'll fix that.
> > 
> >>> The default name can be set in the autofs config by uncommenting the
> >>> line:
> >>>
> >>> DEFAULT_MASTER_MAP_NAME="auto.master"
> >>>
> >>> and changing auto.master to what you require.
> >> I'm still not sure however what is this file meant for: is this
> >> automount daemon configuration file (aka read by it whatever way you
> >> launch it) or the init script configuration file (aka read by the shell
> >> init script to give additional configurations options, such as
> >> command-line arguments) ?
> > 
> > Is used whichever way you launch it.
> > Except for the OPTIONS variable which is only used in the init script to
> > pass command line options.
> > 
> >> >From your answer, it seems it is both, which make me feels unconfortable.
> > 
> > Why.
> > Don't you like having the same configuration whether you launch autofs
> > from the init script or the command line.
> First, it is unusual and unexpected, hence my surprise.
> 
> Second, it mix issues. As developer, you should only deal about software
> itself, and you let packager deal with initscripts, that belongs to
> specific distribution customisation. For instance, I use a mandriva
> specific init script to deal with specific mandriva requirements, such
> as parallel init system. If I want to achieve a standard setup, I have
> to use:
> - --configdir %sysconfdir/autofs option just to make automount use
> standard configuration location
> - and delete the unused OPTIONS from the example file

A third party packager can do what ever they wish.
They don't have to use the init script in the package.
The fact is this stuff has to go somewhere because autofs needs it.
The sensible place for it it in the expected configuration directory.

Your example above won't work.
Have you actually read the INSTALL file which tells you what options 
autofs configure understands?

Fact is that for configuration to be at all usefull autofs has to 
understand it and cooperate with it. The only reason I added these 
configure options was in an effort to make it easier for those who wish to 
use different locations to customise them. If it doesn't meet with your 
approval then I'm sorry but I like it and it works well for me. And I 
don't see any patch submissions from you for discussion so I guess you'll 
just have to live with it.

> 
> You can't handle distribution diversity from developper point of view,
> it is not scalable. But separating concerns make life easier for people
> doing this task.
> 
> >>>> However, the only way I found to force nss-based master map lookup was
> >>>> "/usr/sbin/automount +auto.master" (where description says: name has no
> >>>>  path), or to add +auto.master in auto.master file (where documentation
> >>>> says: + [map-type,format:]map[options]) and use file-based lookup.
> >> Which makes me still wonder:
> >> - what does mean description by "name has no path" ? No / inside ?
> >> - what the meaning of this name, if it is just a boolean trigger to use
> >> nss to locate master map ? it could as well be "foobar" then
> > 
> > Mmm .. it should be illegal to pass "+<mapname>" on the command line.
> > Plus included maps are "only legal in file maps".
> > I'll check that.
> > 
> > "name has no path" should mean that the name has no "/"s
> > 
> > Don't follow the rest of this question.
> If I use "usr/sbin/automount foobar", will it trigger nss master map
> lookup also ? Will it pass foobar as argument ?

Basically yes.

auto.master(5).

The parameter is the master map.
If it is not file, ie. starts with a "/", then we use nsswitch to 
attempt to locate it.

> > 
> > Perhaps you could craft a patch that would clear this up?
> As soon as I will get sure I understand things correctly, sure :)
> 
> >> [..]
> >>>> - what are precedence with system configuration for openldap libraries ?
> >>> Don't understand what you mean here?
> >>>
> >>> If you specify a server name it will be used.
> >>> If not the LDAP default will be used.
> >>> If you specify a map only like:
> >>>
> >>> ldap:auto.master
> >>>
> >>> This should use the the LDAP default base and autofs default or
> >>> configured schema.
> >>>
> >>> Otherwise you must use a full dn such as:
> >>>
> >>> ldap:ou=auto.master,ou=autofs,dc=village,dc=inria,dc=fr
> >>>
> >>> consistent with requirements of LDAP utility commands.
> >> I was purely speaking of LDAP connection parameters, not LDAP content
> >> handling.
> >>
> >> I have no idea about openldap librarie API or usage in C, so I may be
> >> absolutly wrong here, but basically, openldap library configuration
> >> (classicaly, /etc/openldap/ldap.conf) already handle everything needed
> >> to contact (including secure connection parameters) LDAP server. So what
> >> is the use of distinct LDAP configuration for autofs, and additional
> >> SSL/TLS support there ?
> > 
> > Again I'm not clear on which configuration you are talking about.
> > Can you be specific as to the configuration options that are duplicated?
> Here is my current openldap configuration:
> BASE            dc=village,dc=inria,dc=fr
> URI             ldaps://yquem.inria.fr ldaps://julien.inria.fr
> TLS_CACERT      /etc/ssl/ca.pem
> TLS_REQCERT     demand
> TIMELIMIT       3
> 
> It has everything needed for openldap clients to contact servers,
> including the need to use SSL connection. I just realized however it
> doesn't allow to start encrypted communication on standard port, so I
> guess that's the reason you need an additional configuration file if you
> want to use TLS, right ?

The bug below means that LDAP auth config may not be installed.
A patch, coming soon, makes the defaults in this file more sensible and 
adds explanations of each possible entry.

The only configuration in autofs for TLS is a "yes" I want to use it 
(which implies you have setup your certificates in your LDAP 
configuration) or "no" don't use it.

Other configuration is such things as authentication type like DIGEST-MD5 
and a userid and secret if required. These things aren't in the LDAP 
config either.

The default values are used by the LDAP library if they are not 
otherwise specified. What if your map is several more levels deep in the 
tree. In this case, as is the case with LDAP utilities, you need to 
specify the full dn in your specification. LDAP doesn't seem at all good at 
filling in parts of a specification. Anuway that's my impression.

autofs needs to know what LDAP objects and attributes your map data is 
held in. This is also not in the default LDAP configuration.

I'm still not clear which parts of the configuration you think shouldn't 
be present?

> 
> >
> >> [..]
> >>>> - are they supposed to be exported in environment before launching
> >>>> automount, passed to it through a bunch of -Dkey=value ?
> >>> Not needed.
> >>> The values in the config are read at startup by /usr/sbin/automount.
> >>> They may be overridden by values that are exported in the environment
> >>> prior to running /usr/sbin/automount.
> >> See my previous comment about distinction between program configuration
> >> and init script configuration. Only init script configuration should use
> >> /etc/sysconfdir (which happens to be /etc/default under Debian), and
> >> program configuration should use plain /etc or /etc/autofs location.
> > 
> > And /etc/default should be used by configure on a Debian system
> > and /etc/conf.d on a Gentoo system.
> > 
> > I think the division is OK myself.
> Those directories are generally made for storing init parameters only,
> not plain configuration, wich belongs to /etc directly (or /etc/autofs
> eventually). And you would save yourself some troubles (such as a
> configure switch) if you let this kind of issues to packagers (that's
> their work, not yours).
> 
> I just used beta6, it seems to work. However:
> - I have to explicitely define a LDAP dn in auto.master file, otherwise
> it doesn't work. it seems a bit logic, but it worked without
> automagically with autofs 4 :)

No you don't.

> - as I have to use a master file, I can't use nss master map lookup, as

No you don't.
In the configuration uncomment 
DEFAULT_MASTER_MAP_NAME="your_ldap_object_name"
and ensure that either the nsswitch.conf "automount:" entry doesn't have 
files in it or there is no file of the same name in the map directory.

> I didn't found how to define this base in autofs configuration

If there is nothing else but a map name alone then LDAP configured 
defaults are used.

There are some examples in the samples directory of the tarball.
They should be present in the normal doc directory if you built an rpm.

An example of an ldap master map might be:

DEFAULT_MASTER_MAP_NAME="nisMapName=auto_master,dc=themaw,dc=net"

Then the LDAP configured hosts should be used for the connection.

> - automount -d -v doesn't produce any sensible output

Configure syslog to send deamon.* somewhere.
The output is meant for debuging purposes and is possibly not that 
meaninful to most. You will be expected to provide it you have a 
bug that you would us to try and fix.

> - error message in logs for missing ldap configuration is a bit
> excessive for an optional file:
> parse_ldap_config: lookup(ldap): stat(2) failed with error No such file
> or directory.

That bug should have been fixed in beta6.
You will need to provide appropriate information if I'm to understand 
what's wrong and hopefully fix it.

This problem, as it seems it still exists, will stop autofs from 
working with LDAP almost completely, as you have seen.

This works OK for me so unless I get more information I can't fix it.

> 
> I made some tests with strace, it seems automount scan all existing
> process at startup, is it normal ?

It's checking to see if another instance is already running.
I will be adding a command line option at some point to optionally disable 
the check.

Ian
