From: Ian Kent <raven@themaw.net>
Subject: Re: Problem between autofs 3 and autofs4
Date: Mon, 24 Apr 2006 10:06:08 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604241003550.2604@raven.themaw.net>
References: <042320061925.20471.444BD4990001AC3A00004FF72207020953969B0E099D0A@comcast.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <042320061925.20471.444BD4990001AC3A00004FF72207020953969B0E099D0A@comcast.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>
Cc: Jonathan Loran <jonathan@loran.name>

On Sun, 23 Apr 2006, ergatz@comcast.net wrote:

> Jonathan is right.   Chastisement accepted and filed away.
> 
>  I should not have vented my frustration here.  I know how things SHOULD work, but I don't always see it in RH.  Thanks for the replies.  I will keep negative opinions to myself in the future.  I have been doing Solaris too long to change over to RH very quickly.

And I've worked in Solaris environments for more than 10 years of my 
more than 20 years in computing.

> 
> dorothy
> 
> 
> 
>  -------------- Original message ----------------------
> From: Jonathan Loran <jonathan@loran.name>
> > 
> > 
> > 
> > ergatz@comcast.net wrote:
> > > I tried all sorts of things, to include autofs reload, autofs stop and start, 
> > ypbind stop and start.
> > > The only thing that would work was too reboot the machine.  Rebooting a SERVER 
> > is not
> > > really something I want to do when I make changes.
> > >
> > > One of the guys in the office found an updated version of autofs.  I installed 
> > it, and everything
> > > works like a charm.  
> > >
> > > A commentary:  I found somewhere that autofs 4 was written by someone who did 
> > not write
> > > autofs3.  In fact, the author of 3 said he would like to come back to write 5.  
> > It seems the author
> > > of 4 did not know as much about autofs as he should have to write properly 
> > functioning code.
> > >
> > >   
> > I just have to chime in here, that though Ian Kent may sometimes be self
> > deprecating, it is not at all fair to say this about him.  He has given
> > so much of himself to the autofs project, and he, at least at this date,
> > is hardly ignorant as to how autofs works.  I for one feel extremely
> > grateful to him for his tireless hard work on this project.  Cheers to Ian!
> > 
> > Jon
> > 
> > > Just one of my many frustrations with Redhat and open source....
> > >
> > >
> > >
> > >
> > >
> > >  -------------- Original message ----------------------
> > > From: Ian Kent <raven@themaw.net>
> > >   
> > >> On Sat, 15 Apr 2006, ergatz wrote:
> > >>
> > >>     
> > >>> I have a Solaris 2.6 NIS server and have recently added some Redhat Linux 
> > >>>       
> > >> hosts to it.
> > >>     
> > >>> I have:
> > >>>
> > >>>      1 RH 7.3 machine
> > >>>      2 RH 3.0 update 0
> > >>>      1 RH 3.0 update 3
> > >>>      2 RH 4.0 machines
> > >>>
> > >>> I have looked at this problem a lot, and the difference I see is that 7.3 
> > and 
> > >>>       
> > >> 3.0U0 use autofs 3.
> > >>     
> > >>> The 4.0 and 3.0U3 machines use autofs 4
> > >>>
> > >>> My problem is:  When I moved some users' home directories to a different 
> > >>>       
> > >> partition, the RH machines using autofs 4 had to be rebooted to pick up the 
> > >> changes.  The solaris hosts and the 7.3 and 3.0U0 (running autofs 3) picked 
> > up 
> > >> the changed locations magically like they are supposed to.  The machines 
> > using 
> > >> autofs 4 had to be rebooted in order to pick up the changes.  I tried 
> > everything 
> > >> I could think of to avoid reboot, because multiple users are on the the 
> > system 
> > >> at all times.
> > >>     
> > >>> I stopped and restarted autofs and ypbind--SEVERAL times.  Nothing worked.
> > >>>       
> > >> Did you try "service autofs reload".
> > >>
> > >> or 
> > >>
> > >> /etc/init.d/autofs reload
> > >>
> > >> ?
> > >>
> > >>     
> > >>> So, who know the differences between autofs 3 and 4, and what can I do to 
> > >>>       
> > >> hosts running autofs 4 to get them to pick up the NIS changes without having 
> > to 
> > >> reboot?
> > >>     
> > >>> dorothy
> > >>>       
> > >> _______________________________________________
> > >> autofs mailing list
> > >> autofs@linux.kernel.org
> > >> http://linux.kernel.org/mailman/listinfo/autofs
> > >>     
> > >
> > >
> > > _______________________________________________
> > > autofs mailing list
> > > autofs@linux.kernel.org
> > > http://linux.kernel.org/mailman/listinfo/autofs
> > >   
> 
> 
> 
> 
