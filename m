From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 09:43:05 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404090941020.4861@raven.themaw.net>
References: <OFBFF7C508.11CDF1FE-ON85256E6F.00696B8E-04256E6F.006A66DA@us.ibm.com>
	<Pine.LNX.4.58.0404081009540.546@simba.math.ucla.edu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404081009540.546@simba.math.ucla.edu>
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
To: Jim Carter <jimc@math.ucla.edu>
Cc: Raymond Prach <rprach@us.ibm.com>, autofs@linux.kernel.org

On Thu, 8 Apr 2004, Jim Carter wrote:

> 
> v4.1.2 seems happy with the back-version module.  However, being unable to
> do "ghost mounts", it (seems to) mount every exported filesystem from the
> target host (and they expire normally if unused).  That could be a problem
> if many filesystems are exported.  4.1.0 would complain and bypass the
> ghost mounts.  My preference would be for it to not complain and to mount
> only the requested filesystem.

More info please Jim?

Ian
