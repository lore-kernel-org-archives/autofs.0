From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [BUG] 5.0.0_beta1: does not auto-unmount
Date: Thu, 27 Sep 2007 21:14:11 +0100
Message-ID: <200709272114.11469.vda.linux@googlemail.com>
References: <200709261123.41401.vda.linux@googlemail.com>
	<200709261700.24672.vda.linux@googlemail.com>
	<1190824605.12109.39.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1190824605.12109.39.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

On Wednesday 26 September 2007 17:36, Ian Kent wrote:
> On Wed, 2007-09-26 at 17:00 +0100, Denys Vlasenko wrote:
> > On Wednesday 26 September 2007 16:34, Ian Kent wrote:
> > > 
> > > Denys,
> > > 
> > > On another note.
> > > 5.0.0_beta1?
> > 
> > It's the latest thing I found at 
> > 
> > http://www.kernel.org/pub/linux/daemons/autofs/v4/
> > 
> > Aha. I see. I had to fetch stuff from
> > 
> > http://www.kernel.org/pub/linux/daemons/autofs/v5/
> > 
> > right?
> 
> Yep, that's the place.
> Ian

autofs-5.0.2 still references www.kernel.org/pub/linux/daemons/autofs/v4/:

# grep -r /v4 .
./INSTALL:     from http://www.kernel.org/pub/linux/daemons/autofs/v4.
./autofs.spec:Source: ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4/autofs-%{version}.tar.gz
./gentoo/net-fs/autofs/autofs-5.0.2.ebuild:SRC_URI_BASE="mirror://kernel/linux/daemons/${PN}/v4"

What do you think about removing autofs-5.0.0_beta1.tar.* from .../v4 directory
in order to prevent confusion?
--
vda
