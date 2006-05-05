From: Ian Kent <raven@themaw.net>
Subject: Re: opensuse 10/autofs-4.1.4-6 Automount getting stuck with
	superblock/time out/no mount found errors
Date: Fri, 5 May 2006 09:53:06 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605050949570.2898@raven.themaw.net>
References: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
	<x491wv9xzfg.fsf@redhat.com>
	<694d2f6c0605041837s4e87cccfsce78e3038d7d6b9f@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <694d2f6c0605041837s4e87cccfsce78e3038d7d6b9f@mail.gmail.com>
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
To: Neil Millar <nmillar@gmail.com>
Cc: autofs@linux.kernel.org

On Fri, 5 May 2006, Neil Millar wrote:

> On 04/05/06, Jeff Moyer <jmoyer@redhat.com> wrote:
> > ==> Regarding [autofs] opensuse 10/autofs-4.1.4-6 Automount getting stuck
> > with superblock/time out/no mount found errors; "Neil Millar"
> > <nmillar@gmail.com> adds:
> > 
> > nmillar> We are having a problem with autofs getting stuck mounting a
> > nmillar> number of directories on a number of machines in a short space of
> > nmillar> time.
> 
> > What do the logs on the NFS server show?  If/when you do get debug logs
> > from the automounter, that will certainly help debug the problem.
> > 
> > -Jeff
> > 
> > p.s. your auto.master refers to /etc/auto.home, but you only include the
> > contents of the yp map auto.home.
> 
> I will try and get hold of the server logs.
> 
> I have uploaded 3 autofs debug logs to:
> 
> http://www.dur.ac.uk/n.r.millar/
> 
> If you search for timed, failed, and superblock you should see the
> errors. The debug differs slightly from the settings I posted as the
> debug machines were using multi on /data but the rest should be
> the same.
> 
> We don't have a /etc/auto.home on these machines, so the autofs
> startup script drops through to just using the auto.home from yp.
> 
> Looking at the debug output i'm less convinced now that it is problems
> with automount rather than nfs in general, but the return codes may help
> confirm that?

Yes. That superblock error is a bit suspicious.

However, before we go further please check to see if your autofs package 
includes the patch:

http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-locking-fix-1.patch

Ian
