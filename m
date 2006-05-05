From: "Neil Millar" <nmillar@gmail.com>
Subject: Re: opensuse 10/autofs-4.1.4-6 Automount getting stuck with
	superblock/time out/no mount found errors
Date: Fri, 5 May 2006 02:37:57 +0100
Message-ID: <694d2f6c0605041837s4e87cccfsce78e3038d7d6b9f@mail.gmail.com>
References: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
	<x491wv9xzfg.fsf@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x491wv9xzfg.fsf@redhat.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On 04/05/06, Jeff Moyer <jmoyer@redhat.com> wrote:
> ==> Regarding [autofs] opensuse 10/autofs-4.1.4-6 Automount getting stuck with superblock/time out/no mount found errors; "Neil Millar" <nmillar@gmail.com> adds:
>
> nmillar> We are having a problem with autofs getting stuck mounting a
> nmillar> number of directories on a number of machines in a short space of
> nmillar> time.

> What do the logs on the NFS server show?  If/when you do get debug logs
> from the automounter, that will certainly help debug the problem.
>
> -Jeff
>
> p.s. your auto.master refers to /etc/auto.home, but you only include the
> contents of the yp map auto.home.

I will try and get hold of the server logs.

I have uploaded 3 autofs debug logs to:

http://www.dur.ac.uk/n.r.millar/

If you search for timed, failed, and superblock you should see the
errors. The debug differs slightly from the settings I posted as the
debug machines were using multi on /data but the rest should be
the same.

We don't have a /etc/auto.home on these machines, so the autofs
startup script drops through to just using the auto.home from yp.

Looking at the debug output i'm less convinced now that it is problems
with automount rather than nfs in general, but the return codes may help
confirm that?

Thanks,
Neil.
