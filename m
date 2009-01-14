From: Ian Kent <raven@themaw.net>
Subject: Re: autofs options and LDAP
Date: Wed, 14 Jan 2009 21:48:51 +0900
Message-ID: <1231937331.3168.45.camel@zeus.themaw.net>
References: <1231894833.3319.59.camel@localhost.localdomain>
	<1231898104.3168.14.camel@zeus.themaw.net>
	<1231899729.3319.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1231899729.3319.63.camel@localhost.localdomain>
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
To: Brian Kosick <bkosick@mxlogic.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2009-01-13 at 19:22 -0700, Brian Kosick wrote:
> On Tue, 2009-01-13 at 18:55 -0700, Ian Kent wrote:
> > On Tue, 2009-01-13 at 18:00 -0700, Brian Kosick wrote:
> > > Hi All,
> > > 
> > > I'm trying to add the autofs option --ghost to a 2307bis? autofs.ldif
> > > schema file.  It seems to have come up at least once back in 2006, but
> > > after a workaround was suggested and accepted by the original reporter,
> > > I don't think that anything has ever come of it.
> > > 
> > > http://www.mail-archive.com/autofs@linux.kernel.org/msg05449.html
> > > 
> > > https://www.redhat.com/archives/fedora-directory-users/2009-January/msg00035.html
> > > 
> > > In short I've got it working great except that I want one autofs map to
> > > use --ghost and one to not use ghost, so the adding ghost to
> > > the /etc/sysconfig/autofs options won't work for me.
> > > 
> > > Can anyone provide information as to the state of this?  I would
> > > appreciate any help greatly.
> > 
> > What autofs version?
> > 
> > Ian
> > 
> Errm Sorry about that...   I'm using autofs 5 on a RHEL5.2 server.
> autofs-5.0.1-0.rc2.88
> kernel-2.6.18-92.el5

Should work with this, give it a try and log a bug if it doesn't.

> 
> Though I would like to use this on rhel4, rhel3 and fedora servers using
> autofs v4.

If it's broken in RHEL-3 you could log a bug but RHEL-3 is maintenance
only now so you will need to see how you go.

If it does get fixed in RHEL-3 then that it can be fixed in RHEL-4 but
you could also use the autofs5 package in RHEL-4.

Ian
