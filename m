From: "Steve Potter" <geopagan@gmail.com>
Subject: Re: Using auto.net on SuSE 10.1
Date: Wed, 4 Oct 2006 11:20:08 -0700
Message-ID: <31806a030610041120w280c57fdy13705ce7a6eba542@mail.gmail.com>
References: <31806a030610031427x7de0906ave47db71ce845d329@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <31806a030610031427x7de0906ave47db71ce845d329@mail.gmail.com>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

> On a SuSE 10.1 machine I'm setting up, running autofs 4.1.4-23,
> when I do an ls of /net/foo, instead of getting 'export', I get
> the subdirectories of foo:/export.  That is, to get to the
> file foo:/export/xyz I would need to use /net/foo/xyz instead
> of /net/foo/export/xyz.

I found out a little more about the problem.  If the target
machine is exporting only 1 directory, the contents of
that directory get mounted regardless of whether the
directory is '/' or some subdirectory like '/export'.  If the
target machine is exporting more than 1 directory, they
seem to get mounted correctly.  Is this a known bug and
I just need to update to a later autofs?

It seems unlikely to me that it is deliberate that an exported
directory gets automounted differently depending on
what else is exported.

Thanks,
  Steve Potter
