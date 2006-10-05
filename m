From: Ian Kent <raven@themaw.net>
Subject: Re: Using auto.net on SuSE 10.1
Date: Thu, 05 Oct 2006 08:23:16 +0800
Message-ID: <1160007796.2815.37.camel@raven.themaw.net>
References: <31806a030610031427x7de0906ave47db71ce845d329@mail.gmail.com>
	<31806a030610041120w280c57fdy13705ce7a6eba542@mail.gmail.com>
	<1160007303.2815.31.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1160007303.2815.31.camel@raven.themaw.net>
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
To: Steve Potter <geopagan@gmail.com>
Cc: autofs@linux.kernel.org

On Thu, 2006-10-05 at 08:15 +0800, Ian Kent wrote:
> On Wed, 2006-10-04 at 11:20 -0700, Steve Potter wrote:
> > > On a SuSE 10.1 machine I'm setting up, running autofs 4.1.4-23,
> > > when I do an ls of /net/foo, instead of getting 'export', I get
> > > the subdirectories of foo:/export.  That is, to get to the
> > > file foo:/export/xyz I would need to use /net/foo/xyz instead
> > > of /net/foo/export/xyz.
> > 
> > I found out a little more about the problem.  If the target
> > machine is exporting only 1 directory, the contents of
> > that directory get mounted regardless of whether the
> > directory is '/' or some subdirectory like '/export'.  If the
> > target machine is exporting more than 1 directory, they
> > seem to get mounted correctly.  Is this a known bug and
> > I just need to update to a later autofs?
> 
> Don't think that would be fixed in a later version, you might want to
> check the patches on kernel.org.

Have you tried autofs-4.1.4-multi-parse-fix.patch?

Ian
