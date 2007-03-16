From: Erich Weiler <weiler@soe.ucsc.edu>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Fri, 16 Mar 2007 08:16:08 -0700
Message-ID: <45FAB4B8.7060908@soe.ucsc.edu>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>	<1174008860.3397.9.camel@raven.themaw.net>	<45FA996D.2080606@redhat.com>	<1174055083.3397.11.camel@raven.themaw.net>	<45FAABA3.8060608@redhat.com>
	<x494polck3t.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x494polck3t.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

> You misunderstood.  Each time a lookup occurs the name service switch
> is consulted.

If it is consulted each time a lookup occurs, then why do ldap lookups 
fail if ldap is listed *after* files in nsswitch.conf?  It looks to me 
like when the automounter daemon starts it looks at nsswitch.conf once, 
loads the first options on the automount line (and the second if the "+" 
option is used) and that's it, nsswitch.conf is never consulted again. 
Looking in /proc/mounts shows automounters listening for specific 
requests only, not simply a name service switch query able type thing. 
Am I misunderstanding the behavior I am seeing?

-erich
