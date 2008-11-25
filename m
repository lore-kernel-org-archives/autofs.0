From: Ian Kent <raven@themaw.net>
Subject: Re: Ubuntu NFS automount problem
Date: Tue, 25 Nov 2008 21:11:54 +0900
Message-ID: <1227615114.3009.22.camel@zeus.themaw.net>
References: <4928BFA4.2090805@sun.com>
	<1227499728.2913.0.camel@zeus.themaw.net> <492A56E6.1070603@sun.com>
	<1227531120.2913.9.camel@zeus.themaw.net> <492ACFB9.7060201@redhat.com>
	<492B0F04.1080104@sun.com> <1227576741.3009.12.camel@zeus.themaw.net>
	<492BD2FE.7050309@s3group.cz>
	<1227612453.3009.19.camel@zeus.themaw.net>
	<492BE522.30703@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <492BE522.30703@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

On Tue, 2008-11-25 at 12:44 +0100, Ondrej Valousek wrote:
> > I don't think so, not the hosts map, since the export path doesn't match
> > the mount location path. There are other difficulties as well such as
> > having to modify paths in the export list as we go. However, exports
> > with "nohide" option should be automounted by the kernel client and not
> > confuse autofs so that part is ok with 5.0.4 or if the patch which deals
> > with this has been applied to 5.0.3.
> >
> > This is something I need to work on.
> >
> >   
> So since the "nohide" option is a must for the Linux-based NFSv4 server,
> it will work (for most of the people)...

Don't forget that I need to remove the initial part of each export path
that corresponds to the NFSv4 export root which hasn't been done yet.

> Thanks,
> Ondrej
