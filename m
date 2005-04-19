From: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Tue, 19 Apr 2005 18:06:53 -0300
Message-ID: <20050419210653.GA15270@vision.ime.usp.br>
References: <20050417154240.GA17232@uio.no>
	<Pine.LNX.4.62.0504200059370.8587@donald.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504200059370.8587@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org, 304245@bugs.debian.org

Hi,

On Wed, Apr 20, 2005 at 01:00:30AM +0800, raven@themaw.net wrote:
> 
> Has this patch been tested with multi-mount map entries?

I don't have experience with multi-mount map entries, but I have done a
small test with entries like this (borrowed from
http://linux.kernel.org/pipermail/autofs/2005-February/001909.html):

auto.master contains:

/testing    /etc/auto.testing

/etc/auto.testing contains:

foo     -ro,hard,intr \
        /dir/bar        server:/export/a \
        /dir/baz        server:/export/b

It seems to work (both directories were mounted) if I cd to
/testing/foo. After the expiration time they were also unmounted.

Thanks,

Daniel
