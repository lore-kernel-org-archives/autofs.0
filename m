From: Ian Kent <raven@themaw.net>
Subject: Re: Automounting DVD images
Date: Mon, 11 Dec 2006 12:48:42 +0900
Message-ID: <1165808922.3380.1.camel@raven.themaw.net>
References: <457999E0.2040808@kmaclub.com>
	<1165602659.3996.59.camel@raven.themaw.net>
	<4579C7F4.4020506@kmaclub.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4579C7F4.4020506@kmaclub.com>
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
To: Michael <michael@kmaclub.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 2006-12-08 at 13:15 -0700, Michael wrote:
> Ian Kent wrote:
> > On Fri, 2006-12-08 at 09:59 -0700, Michael wrote:
> >   
> >> Hello,
> >>
> >> I have been trying to get autofs to mount DVD iso images but so far have 
> >> been unsuccessful.  I want to make this work from various client 
> >> machines and not on the machine that servers out the iso.
> >>
> >> I tried some examples from the web but can't seem to make them work.  I 
> >> can mount the file by hand  over NFS without any issues.
> >>
> >> Here is my configuration
> >>
> >> NIS:
> >>
> >> auto.master
> >> /mythtv         auto.mythtv     
> >> bg,hard,intr,retry=10000,rsize=32768,wsize=32768,timeo=600,nfsvers=3,tcp
> >>
> >> auto.mythtv
> >> iso             --timeout=60 -fstype=autofs     auto.mythtv.iso
> >> video           -rw             filer:/export/services/mythtv/video
> >>
> >> auto.mythtv.iso
> >> * -fstype=iso9660,ro,loop       /mythtv/video/Movies/&
> >>     
> > What happens if you use:
> > * -fstype=iso9660,ro,loop       :/mythtv/video/Movies/&
> >
> >   

What happens if you also use this patch:

diff --git a/daemon/spawn.c b/daemon/spawn.c
index 7f0a6e0..6f59bf2 100644
--- a/daemon/spawn.c
+++ b/daemon/spawn.c
@@ -272,7 +272,7 @@ int spawn_mount(logger *log, ...)
 #ifdef ENABLE_MOUNT_LOCKING
 	options = SPAWN_OPT_LOCK;
 #else
-	options = SPAWN_OPT_NONE;
+	options = SPAWN_OPT_ACCESS;
 #endif
 
 	va_start(arg, log);
