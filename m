From: "Neil Millar" <nmillar@gmail.com>
Subject: Re: opensuse 10/autofs-4.1.4-6 Automount getting stuck with
	superblock/time out/no mount found errors
Date: Fri, 5 May 2006 03:13:27 +0100
Message-ID: <694d2f6c0605041913s58953350jdb737123b7a21bdb@mail.gmail.com>
References: <694d2f6c0605040946u25257f96ga8dbb5f1c24fe1f2@mail.gmail.com>
	<x491wv9xzfg.fsf@redhat.com>
	<694d2f6c0605041837s4e87cccfsce78e3038d7d6b9f@mail.gmail.com>
	<Pine.LNX.4.64.0605050949570.2898@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605050949570.2898@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On 05/05/06, Ian Kent <raven@themaw.net> wrote:
> On Fri, 5 May 2006, Neil Millar wrote:
>
> > Looking at the debug output i'm less convinced now that it is problems
> > with automount rather than nfs in general, but the return codes may help
> > confirm that?
>
> Yes. That superblock error is a bit suspicious.
>
> However, before we go further please check to see if your autofs package
> includes the patch:
>
> http://www.kernel.org/pub/linux/daemons/autofs/v4/autofs-4.1.4-locking-fix-1.patch

The suse package doesn't appear to have that patch included. Should
I try that?

Neil.
