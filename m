From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 09:49:11 -0700 (PDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404090943590.8569@simba.math.ucla.edu>
References: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
	<Pine.LNX.4.58.0404081009540.546@simba.math.ucla.edu>
	<Pine.LNX.4.58.0404090941020.4861@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404090941020.4861@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Fri, 9 Apr 2004, Ian Kent wrote:

> On Thu, 8 Apr 2004, Jim Carter wrote:
> > v4.1.2 seems happy with the back-version module.  However, being unable to
> > do "ghost mounts", it (seems to) mount every exported filesystem from the
> > target host (and they expire normally if unused).  That could be a problem
> > if many filesystems are exported.  4.1.0 would complain and bypass the
> > ghost mounts.  My preference would be for it to not complain and to mount
> > only the requested filesystem.
> 
> More info please Jim?

Oops, I misinterpreted a test.  With the back-version module that can't do
ghost mounts, 4.1.2 in fact silently mounts only the requested filesystem,
and there is no trace of potentially but not actually requested
filesystems, with both Linux and Solaris servers.  (Unless one has
previously mounted the filesystem and forgotten that one has done it.)

Sorry about that.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
