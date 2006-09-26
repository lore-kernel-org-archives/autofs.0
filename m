From: Ian Kent <raven@themaw.net>
Subject: Re: SOLVED?? Pls help on configuring autofs on
	NFS	for	home dir
Date: Wed, 27 Sep 2006 00:35:59 +0800
Message-ID: <1159288559.27996.12.camel@raven.themaw.net>
References: <200609261119.47084.fajarpri@cbn.net.id>
	<200609261143.12477.fajarpri@cbn.net.id> <45192426.3040108@onsemi.com>
	<200609262047.22505.fajarpri@cbn.net.id>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200609262047.22505.fajarpri@cbn.net.id>
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
To: Fajar Priyanto <fajarpri@cbn.net.id>
Cc: autofs@linux.kernel.org

On Tue, 2006-09-26 at 20:47 +0700, Fajar Priyanto wrote:
> On Tuesday 26 September 2006 19:59, Dana Wellen wrote:
> >  Fajar,
> >    I assume you want your nfstest user to mount their home directory in
> > /home.  Your autofs files should be:
> >  auto.master
> >  /home      /etc/auto.home --timeout=60
> >  auto.home
> > *       -rw,soft,intr   192.168.1.247:/home/&
> 
> Hi Dana,
> Thank you very much for replying.
> Actually, that was one of the first configurations I tried, but, when I tried 
> it, autofs couldn't be started with error:
> "Cannot start automount. 
> /home already mounted"

umount /home

I assume /home is not in use for home directories since you are testing
your setup.

> 
> I don't know, maybe it's because I have done some mistakes before. But, I 
> couldn't restart the machine since it's my running mail server (shame on me 
> by experimenting on a production server).

Depends on the version of autofs.

Ian
