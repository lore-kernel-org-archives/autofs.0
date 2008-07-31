From: Ian Kent <raven@themaw.net>
Subject: Re: How to pass "-n" option to the mount
	command	via	automounter?
Date: Thu, 31 Jul 2008 11:52:27 +0800
Message-ID: <1217476348.2989.1.camel@raven.themaw.net>
References: <48903B22.3000608@s3group.cz>  <489057B6.5070108@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <489057B6.5070108@s3group.cz>
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


On Wed, 2008-07-30 at 13:59 +0200, Ondrej Valousek wrote:
> From what I see in the source for automounter, the answer is "no"  :-(
> I even tried automount -O "rw -n" hack - should work but it does not.
> In the spawn.c file I see comment that autofs ver. 5 needs to have
> /etc/mtab file updated. This is not a problem as most diskless
> environments have /etc/mtab pointed to /proc/mounts.
> 
> I believe this is a bug. Can we have it fixed? (for example detect if
> /etc/mytab is a symlink and if it is, pass the -n option to the mount
> command automagically)

ln -s /proc/mounts /etc/mtab
in the partition that is used for your /etc should do what you need.

> 
> Thanks,
> Ondrej
> 
> Ondrej Valousek wrote:
> > Hi List,
> >
> > I am wondering - I have diskless systems deployed here with /etc being
> > read-only -> I need to pass "-n" option to the mount command in order to
> > make it working.
> > I tried:
> >   
> >> automount -O "-n"
> >>     
> > but it passes the -n option after -o, like this:
> >
> > mount_mount: mount(nfs): calling mount -t nfs -s -o -n
> > hercules:/ext3/tmp /proj/tmp
> >
> > I need the -n option to be passed before "-o". How could I do it?
> > Many thanks for your help.
> >
> > Ondrej
> >
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> >   
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
