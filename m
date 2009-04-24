From: Ian Kent <raven@themaw.net>
Subject: Re: Automounter stops after reload signal.
Date: Fri, 24 Apr 2009 12:31:43 +0800
Message-ID: <20090424043142.GA3172@zeus.themaw.net>
References: <49DCCD73.5050307@bononline.nl>
	<1239545315.23791.0.camel@zeus.themaw.net>
	<49E22C1D.8030504@bononline.nl> <49E2D284.1040801@themaw.net>
	<49E2F90A.9010901@bononline.nl> <49E2FF76.2080108@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <49E2FF76.2080108@themaw.net>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

On Mon, Apr 13, 2009 at 05:01:42PM +0800, Ian Kent wrote:
> Stef Bon wrote:
> > Ian Kent wrote:
> >> Stef Bon wrote:
> >>  
> >>> Ian Kent wrote:
> >>>    
> >>>> On Wed, 2009-04-08 at 18:14 +0200, Stef Bon wrote:
> >>>>  
> >>>>      
> >>>>> Hello,
> >>>>>
> >>>>> I've been working on a construction which adds an autofs managed
> >>>>> mountpoint to the homedirectory, when:
> >>>>> a. an usb device or more than one is detected when logging in
> >>>>> b. an usb device is plugged in during a session
> >>>>>             
> >>>> What version of autofs did you say you are using?
> >>>>         
> >>> Well, 5.0.4.
> >>>     
> >>
> >> OK, then the daemon should remain running as long as there is at least
> >> one entry in the master map. If the daemon receives a HUP signal then
> >> any mount handling threads that terminate will send SIGTERM to the
> >> signal catching thread. If the master map becomes empty during this
> >> SIGTERM check autofs will exit. That is what the daemon exit condition
> >> is and we do need such a condition to be able to exit at all.
> >>
> >> If something else is happening in your case then we need to work out
> >> what's going on.
> >>   
> > 
> > Yes, the auto.master file is not empty. In all of my cases, and in the
> > example below, the auto.master file has one line which is there always:
> > 
> > /mnt/sd /etc/autofs/auto.sd --timeout=50
> > 
> > 
> > I remember that I have added this line to prevent this unwanted
> > behaviour. In my construction it can happen that when no users are
> > logged in (after logout), there are no mountpoints, and then the
> > automounter did stop also. So then I added this line, and the behaviour
> > disappeared. Now it's back again. Removing a mountpoint, and reloading
> > gives this behaviour, even if there are other mountpoints and maps in
> > the auto.master file.
> > 
> > Ok, so this should be a bug, if you say that, when the auto.master file
> > is empty, the automounter should stop after a HUP signal.
> > Apart from this bug, I do not understand this. You say it's necessary to
> > exit at all, but is this a technical reason? The master daemon should
> > not stop after a reload signal, even if the master file is empty.
> 
> OK, looks like a bug.
> I'll look further, using your example.
> 

Yep, I've introduced a regression.
Can you try this patch please.

Ian

autofs-5.0.4 - library reload fix update fix

From: Ian Kent <raven@themaw.net>

The library reload fixes introduced a bug which causes autofs to
incorrectly shutdown. Previously the signal handling thread only
recieved signals either when they were explicity sent or it was
time to shutdown so continuing on to call the signal handling
routine was the correct thing to do. Now we need to join with
the mount handling thread at exit but, in this case, we don't
want to continue on to the signal handling routine as that will
incorrectly cause the signal to be passed on to other mount
handling threads.
---

 daemon/automount.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)


diff --git a/daemon/automount.c b/daemon/automount.c
index 80691fa..d7e3e12 100644
--- a/daemon/automount.c
+++ b/daemon/automount.c
@@ -1332,8 +1332,17 @@ static void *statemachine(void *arg)
 		case SIGTERM:
 		case SIGINT:
 		case SIGUSR2:
-			if (master_done(master_list))
-				return NULL;
+			master_mutex_lock();
+			if (!list_empty(&master_list->completed)) {
+				if (master_done(master_list)) {
+					master_mutex_unlock();
+					return NULL;
+				}
+				master_mutex_unlock();
+				break;
+			}
+			master_mutex_unlock();
+
 		case SIGUSR1:
 			do_signals(master_list, sig);
 			break;
