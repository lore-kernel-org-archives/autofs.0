From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Sat, 17 Mar 2007 01:32:56 +0900
Message-ID: <1174062776.3397.51.camel@raven.themaw.net>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
	<1174008860.3397.9.camel@raven.themaw.net>	<45FA996D.2080606@redhat.com>
	<1174055083.3397.11.camel@raven.themaw.net>	<45FAABA3.8060608@redhat.com>
	<x494polck3t.fsf@segfault.boston.devel.redhat.com>
	<45FAB4B8.7060908@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45FAB4B8.7060908@soe.ucsc.edu>
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
To: Erich Weiler <weiler@soe.ucsc.edu>
Cc: autofs@linux.kernel.org

On Fri, 2007-03-16 at 08:16 -0700, Erich Weiler wrote:
> > You misunderstood.  Each time a lookup occurs the name service switch
> > is consulted.
> 
> If it is consulted each time a lookup occurs, then why do ldap lookups 
> fail if ldap is listed *after* files in nsswitch.conf?  It looks to me 
> like when the automounter daemon starts it looks at nsswitch.conf once, 
> loads the first options on the automount line (and the second if the "+" 
> option is used) and that's it, nsswitch.conf is never consulted again. 
> Looking in /proc/mounts shows automounters listening for specific 
> requests only, not simply a name service switch query able type thing. 
> Am I misunderstanding the behavior I am seeing?

Let me see if I can clear this up.

Not withstanding that the nsswitch syntax can itself prevent the lookup
from continuing the following is how this should work.

The first instance of a master map that is found, using nsswitch, is
used unless it is explicitly specified, such as "/etc/auto.master",
either in the autofs configuration or on the command line to the
automount program.

Since the first instance is used there can be only one of source for the
master map. Plus map inclusion is allowed only in file based maps so
additional master maps can be included from a file based master map
only.

The first instance of each autofs managed indirect mount that is found
in the master map is used. The corresponding map given in the entry is
looked for by using nsswitch specified sources unless the source is
explicitly given, such as "/etc/auto.mymap" in which case only that map
is used. Additional instances of the same indirect mount point in the
configuration are ignored.

Multiple direct mount entries can be specified in the master map and the
maps are treated as one large direct mount map. The corresponding map
given in each entry is looked for by using nsswitch specified sources
unless the source is explicitly given, such as "/etc/auto.mymap" in
which case only that map is used.

Plus map inclusion is allowed only in file based maps so additional maps
for both direct and indirect mount maps may be included from a file
based map only. The plus map inclusion knows not to include itself and
so a map of the same name may come from an nsswitch source that follows
"files" in the nsswitch configuration.

Automount key lookups use the same rules as the lookup of maps above and
the first instance of a map key found is used.

At least that what I think I implemented and I believe that the Solaris
automounter does the same thing.

Ian
