From: Ian Kent <raven@themaw.net>
Subject: Re: Problems with Autofs and .hidden files
Date: Tue, 02 Oct 2007 14:56:54 +0800
Message-ID: <1191308214.26331.56.camel@raven.themaw.net>
References: <200709291742.54831.lists@fabis-site.net>
	<x49sl4uykdh.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49sl4uykdh.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org

On Mon, 2007-10-01 at 10:34 -0400, Jeff Moyer wrote:
> Fabian Steiner <lists@fabis-site.net> writes:
> 
> > Hello!
> >
> > We are using autofs in order to mount the user's home drive via NFS after a
> > successfull login authenticated by ldap.
> >
> > /etc/auto.master looks like this:
> >
> > # AUOTOFS-MAPPING
> > /home/schueler  /etc/auto.schueler
> > /home/lehrer    /etc/auto.lehrer
> > /home/maerkte   /etc/auto.maerkte
> >
> > /etc/auto.schueler has the following content (the same also applies for the
> > other files):
> >
> > *       -fstype=nfs,rw,hard,intr,nodev,nosuid,exec,acl         
> > server.domain.de:/home/schueler/&
> >
> > Generally speaking this setup works like a charm but from time to time we
> > encounter the following messages in syslog:
> >
> > Sep 24 16:46:57 server mountd[8818]: authenticated mount request from
> > client.domain.de:559 for /home/schueler/.directory (/home/schueler)
> > Sep 24 16:46:57 server mountd[8818]: can't stat exported
> > dir /home/schueler/.directory: No such file or directory
> >
> > Our investigations show that these messages are probably to be created
> > whenever a user tries to access /home/schueler by using Konqueror or
> > Nautilus. The file .directory doesn't exist, however, and that's why these
> > messages appaer. Normalley, this wouldn't be a severe problem but the
> > entire is completely slowed down so that another kind of error occurs:
> >
> > Sep 24 16:47:00 server mountd[8818]: refused mount request from
> > client.domain.de for /home/schueler/.directory (/home/schueler): illegal
> > port 48337
> >
> > Does anybody know this issue and could provide any hints how to solve it?
> 
> Negative lookup caching will help this.  I'm not sure whether/when
> that went into the kernel.  Ian?

There was a report of the patch causing a kernel panic which I've still
not been able to duplicate. I need to return to this real soon.

Ian  
