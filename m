From: Chris Walker <cwalker@pixar.com>
Subject: Re: BUG: /foo/bar already mounted
Date: Thu, 14 Apr 2005 06:51:11 -0700
Message-ID: <20050414135111.GA12267@pixar.com>
References: <20050412175850.GA1556@pixar.com>
	<Pine.LNX.4.58.0504131308290.10508@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504131308290.10508@wombat.indigo.net.au>
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
To: autofs@linux.kernel.org

They're NIS maps most of which are like this:

proxydisk -rw,intr    netapp:/sv/blah-proxy
stats     -rw,intr    netapp:/vol/vol11/unit-stats-01/blah

The master map looks like this:

/shows/blah   auto.show.blah   -rw,intr,--timeout=0

From raven:
> On Tue, 12 Apr 2005, Chris Walker wrote:
> 
> > Apologies if this in faq or changelog somewhere. I get run into this bug
> > quite frequently:
> > 
> > Apr 11 15:40:15 XXXXX automount[21296]: BUG: /foo/bar/blah already mounted
> > 
> > Once hitting this, the filesystem in question is unavailable until
> > reboot. Has this bug been addressed? If so, in what version of the
> > autofs or the kernel has it been fixed? Thanks!
> > 
> > OS: fedora core 2
> > kernel: 2.6.8-1.521smp
> > autofs: 4.1.3-47 (autofs4 kernel mod)
> > 
> > Let me know if you need any more information.
> > 
> 
> This has come up in various ways lately.
> Jeff Moyer has a somewhat later version rpm around somewhere, Jeff?
> 
> What do your maps look like?
> 
> Ian
> 

-- 
Chris Walker
Render Pipeline Group
Pixar Animation Studios
510/752.3736
cwalker@pixar.com
