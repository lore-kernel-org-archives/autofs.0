From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Autofs weirdness in nsswitch.conf and other stuff...
Date: Fri, 16 Mar 2007 10:56:54 -0400
Message-ID: <x494polck3t.fsf@segfault.boston.devel.redhat.com>
References: <60464.128.114.56.35.1173996300.squirrel@webmail.soe.ucsc.edu>
	<1174008860.3397.9.camel@raven.themaw.net>
	<45FA996D.2080606@redhat.com>
	<1174055083.3397.11.camel@raven.themaw.net>
	<45FAABA3.8060608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <45FAABA3.8060608@redhat.com> (Peter Staubach's message of "Fri,
	16 Mar 2007 10:37:23 -0400")
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
To: Peter Staubach <staubach@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> On Fri, 16 Mar 2007 10:37:23 -0400, Peter Staubach <staubach@redhat.com> said:

Peter> Ian Kent wrote:
Peter> > On Fri, 2007-03-16 at 09:19 -0400, Peter Staubach wrote:
Peter> >   
Peter> >> Ian Kent wrote:
Peter> >>     
Peter> >>> On Thu, 2007-03-15 at 15:05 -0700, weiler@soe.ucsc.edu wrote:
Peter> >>>   
Peter> >>>       
Peter> >>>> Hey all-
Peter> >>>>
Peter> >>>> I'm testing out CentOS 5 (i.e. RedHat 5) and and playing around with
Peter> >>>> autofs 5.0.1 which is the version that ships with it.  I'm noticing three
Peter> >>>> odd things based on what I was seeing in RedHat 4.4 (which has autofs
Peter> >>>> 4.1.3):
Peter> >>>>
Peter> >>>> 1: Before, with autofs 4.1.3, I had in /etc/nsswitch.conf:
Peter> >>>>
Peter> >>>> automount: files ldap
Peter> >>>>
Peter> >>>> And I had some maps in /etc/auto.master that mounted AND I had some maps
Peter> >>>> in LDAP that mounted, both worked OK together.  But in Autofs 5.0.1, the
Peter> >>>> same line in nsswitch.conf only lets me use whatever is first, i.e. if
Peter> >>>> files is listed first it automounts with flat files but not LDAP, or vice
Peter> >>>> versa.  Is there any way to get them BOTH working again, or is this a
Peter> >>>> nifty feature that has been removed?
Peter> >>>>     
Peter> >>>>         
Peter> >>> That's correct.
Peter> >>> That's the behavior of other industry standard automounters.
Peter> >>> Adding a plus include line at the end of /etc/auto.master (as in the
Peter> >>> default configuration) will allow the inclusion of the LDAP master map
Peter> >>> in the above example.
Peter> >>>       
Peter> >> Is this really true?  My impression was that autofs implementations such as
Peter> >> the Solaris version would use the name service switch really as a switch.
Peter> >> It would look for a map following the standard rules which apply to
Peter> >> nsswitch.conf entries.  I can remember using a combination of NIS+ and
Peter> >> flat files for map sources, without having to resort to the "+" tricks.
Peter> >>     
Peter> >
Peter> > Think so.
Peter> > I'll check again.
Peter> > But I think that the first source found (master map in this case) is
Peter> > used.

Peter> Yes, I agree, the first source found is used.  However, if some maps
Peter> are flat files and some maps are stored in other places such as ldap,
Peter> nis, or nis+, then when a reference to them occurs, they should be
Peter> looked for in the name services and directory services in the order
Peter> that the nsswitch.conf contains.

Peter> Or am I misunderstanding the situation and we are actually in
Peter> agreement?  I interpreted the situation originally described as _all_
Peter> maps having to come from the one source, instead of on a per-map
Peter> basis.

You misunderstood.  Each time a lookup occurs the name service switch
is consulted.

-Jeff
