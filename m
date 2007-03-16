From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Fri, 16 Mar 2007 13:21:34 -0400
Message-ID: <x49mz2dayu9.fsf@segfault.boston.devel.redhat.com>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
	<1174008860.3397.9.camel@raven.themaw.net>
	<45FA996D.2080606@redhat.com>
	<1174055083.3397.11.camel@raven.themaw.net>
	<45FAABA3.8060608@redhat.com>
	<x494polck3t.fsf@segfault.boston.devel.redhat.com>
	<45FAB4B8.7060908@soe.ucsc.edu>
	<1174062776.3397.51.camel@raven.themaw.net>
	<Pine.LNX.4.64.0703160951030.11089@simba.math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703160951030.11089@simba.math.ucla.edu> (Jim
	Carter's message of "Fri, 16 Mar 2007 10:09:24 -0700 (PDT)")
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> On Fri, 16 Mar 2007 10:09:24 -0700 (PDT), Jim Carter <jimc@math.ucla.edu> said:

Jim> On Sat, 17 Mar 2007, Ian Kent wrote:
Jim> > Let me see if I can clear this up.
Jim> > ...
Jim> > The first instance of a master map that is found, using nsswitch, is
Jim> > used unless it is explicitly specified, such as "/etc/auto.master",
Jim> > ...
Jim> > The first instance of each autofs managed indirect mount that is found
Jim> > in the master map is used. The corresponding map given in the entry is
Jim> > looked for by using nsswitch specified sources unless the source is
Jim> > explicitly given, such as "/etc/auto.mymap" in which case only that map
Jim> > is used. Additional instances of the same indirect mount point in the
Jim> > configuration are ignored.
Jim> > ...
Jim> > Automount key lookups use the same rules as the lookup of maps above and
Jim> > the first instance of a map key found is used.

Jim> Yes, this does clear it up.  Autofs' philosophy differs from other 
Jim> nsswitchable maps, where a key is looked for in potentially every listed 
Jim> data source until found.  Whereas, autofs identifies the first map that 
Jim> exists, and looks up a key in that map, and if it's absent, you lose.  It 
Jim> doesn't go on to look for the key in subsequent data sources such as LDAP, 
Jim> unless the plus kludge has been used.  (In any case, the first found 
Jim> instance of the key is used and subsequent instances or sources are 
Jim> not looked at.)

Yes, and this was a major point of confusion for me when I first
started working on autofs.  However, we're stuck with it.

-Jeff
