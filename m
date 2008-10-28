From: Ian Kent <raven@themaw.net>
Subject: Re: expire_indirect errors in the syslog
Date: Tue, 28 Oct 2008 20:19:13 +0900
Message-ID: <1225192753.2938.103.camel@zeus.themaw.net>
References: <4906C365.8030209@s3group.cz>
	<1225181075.2938.97.camel@zeus.themaw.net>
	<4906CB2A.9010705@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4906CB2A.9010705@s3group.cz>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Tue, 2008-10-28 at 09:19 +0100, Ondrej Valousek wrote:
> Hi Ian,
> 
> Thanks for the quick reply. 2 more questions:
> 1. Is the "nohide" bug exposed even when using NFSv3 (NFSv3 client
> mounting the nohide nfs server export)

Yes. If your map is mounting based on exports from the server there is
no way to know, from the export information, if the NFS client will will
automatically mount the export (the "nohide" option) which leads to the
conflict.

> 2. from the bug #448038 details I can see a patch for this has already
> been accepted and will go into RHEL-5. When?

5.3.

> 
> I have already filed a bug regarding the gnome-vfs, but I do not know
> whether I should also mention the autofs errors.
> I do not need NFSv4 right now - I just wanted to prepare my NFS servers
> for v4 - so I introduced the nohide option.
> For sake of safety, I have removed this option for now.
> 
> Thanks,
> Ondrej
> 
> Ian Kent wrote:
> > On Tue, 2008-10-28 at 08:46 +0100, Ondrej Valousek wrote:
> >   
> >> Hi all,
> >>
> >> I am seeing quite lot of following messages in the syslog:
> >> Oct 21 02:17:05 ara automount[3181]: expire_indirect: fstat failed: Bad
> >> file descriptor
> >>
> >> On RHEL-5.2, last updates, autofs-5.0.1-0.rc2.88.
> >> I have seen some discussion on the net (bug #448038) regarding this
> >> error and what is common is, that my  NFS server is using the "nohide"
> >> option.
> >>
> >> Question - is this bug dangerous or not? Is there any resolution to
> >> this? Recently I have experienced our logon server instability (Gnome
> >> session frozen) due to a problem with gnome-vfs so I do not know if this
> >> is related....
> >>     
> >
> > Ummm .. it could be but should only be an issue when related to the
> > "nohide" handling.
> >
> > Log a bug and get hold of rev 101 and see how things go.
> >
> > Ian
> >
> >
> >   
> 
