From: ergatz@comcast.net
Subject: Re: Problem between autofs 3 and autofs4
Date: Sun, 23 Apr 2006 13:24:28 +0000
Message-ID: <042320061324.20487.444B800C000C9242000050072207020653969B0E099D0A@comcast.net>
Return-path: <autofs-bounces@linux.kernel.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>

I tried all sorts of things, to include autofs reload, autofs stop and start, ypbind stop and start.
The only thing that would work was too reboot the machine.  Rebooting a SERVER is not
really something I want to do when I make changes.

One of the guys in the office found an updated version of autofs.  I installed it, and everything
works like a charm.  

A commentary:  I found somewhere that autofs 4 was written by someone who did not write
autofs3.  In fact, the author of 3 said he would like to come back to write 5.  It seems the author
of 4 did not know as much about autofs as he should have to write properly functioning code.

Just one of my many frustrations with Redhat and open source....





 -------------- Original message ----------------------
From: Ian Kent <raven@themaw.net>
> On Sat, 15 Apr 2006, ergatz wrote:
> 
> > I have a Solaris 2.6 NIS server and have recently added some Redhat Linux 
> hosts to it.
> > 
> > I have:
> > 
> >      1 RH 7.3 machine
> >      2 RH 3.0 update 0
> >      1 RH 3.0 update 3
> >      2 RH 4.0 machines
> > 
> > I have looked at this problem a lot, and the difference I see is that 7.3 and 
> 3.0U0 use autofs 3.
> > The 4.0 and 3.0U3 machines use autofs 4
> > 
> > My problem is:  When I moved some users' home directories to a different 
> partition, the RH machines using autofs 4 had to be rebooted to pick up the 
> changes.  The solaris hosts and the 7.3 and 3.0U0 (running autofs 3) picked up 
> the changed locations magically like they are supposed to.  The machines using 
> autofs 4 had to be rebooted in order to pick up the changes.  I tried everything 
> I could think of to avoid reboot, because multiple users are on the the system 
> at all times.
> > 
> > I stopped and restarted autofs and ypbind--SEVERAL times.  Nothing worked.
> 
> Did you try "service autofs reload".
> 
> or 
> 
> /etc/init.d/autofs reload
> 
> ?
> 
> > 
> > So, who know the differences between autofs 3 and 4, and what can I do to 
> hosts running autofs 4 to get them to pick up the NIS changes without having to 
> reboot?
> > 
> > dorothy
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
