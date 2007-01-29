From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [Murata,
	Dennis] FW: Advise for multiple directory/multi-map mounts
Date: Mon, 29 Jan 2007 13:26:24 -0500
Message-ID: <x49y7nl3d0v.fsf@segfault.boston.devel.redhat.com>
References: <x4964ap4s5i.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x4964ap4s5i.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
	message of "Mon, 29 Jan 2007 13:14:17 -0500")
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
To: autofs@linux.kernel.org
Cc: DENNIS.MURATA@saic.com

==> On Mon, 29 Jan 2007 13:14:17 -0500, Jeff Moyer <jmoyer@redhat.com> said:

Jeff> From: "Murata, Dennis" <DENNIS.MURATA@saic.com>
Jeff> Subject: FW: Advise for multiple directory/multi-map mounts
Jeff> To: <jmoyer@redhat.com>
Jeff> Date: Mon, 29 Jan 2007 09:57:03 -0800

Jeff> Jeff,

Jeff> I am sorry about sending this directly to you, but I have not been able
Jeff> to post anything to the autofs mailing list in quite awhile.  I think I
Jeff> will unsubscribe then resubscribe.  Would you please post this for me?

Jeff> Thanks
Jeff> Wayne

Jeff> > ______________________________________________ 
Jeff> > From: 	Murata, Dennis  
Jeff> > Sent:	Friday, January 26, 2007 2:06 PM
Jeff> > To:	autofs@linux.kernel.org
Jeff> > Subject:	Advise for multiple directory/multi-map mounts
Jeff> > 
Jeff> > After reading the FAQ and various postings from this group, there are
Jeff> > a couple of options that I need advise with the approved syntax and
Jeff> > any recommendations for either one of the options.
Jeff> > 
Jeff> > auto.master entry:
Jeff> >      /foo     /etc/auto.foo
Jeff> > indirect map auto.foo:
Jeff> >      *   -fstype=nfs,rsize=32768,tcp server1:/foo1/& server2:/foo2/&
Jeff> > 
Jeff> > Server1 and server2 may or may not be the same server, but the server
Jeff> > directories foo1 and foo2 are definitely distinct.  The subdirectories
Jeff> > under foo1 and foo2 do not have overlapping names, but may be moved
Jeff> > from one server foo1, to the other server directory foo2.  I want it
Jeff> > to appear transparently to the client.  Because directories are going
Jeff> > to be moved, should no_subtree_check be used?

This should work, but only in autofs v5.  You don't mention anywhere
what version of autofs you are using, or under what kernel.  There is
a chance you can get this to work with v4, if you use the rhel4
packages from my people page:

http://people.redhat.com/jmoyer/autofs/rhel4/

These are only test packages, so the "may eat your data" disclaimer
applies.  Once I've put the patches through the proper testing, I'll
of course submit them for 4.1.  However, the right way to move forward
is to test out autofs v5.

-Jeff
