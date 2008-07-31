From: Ian Kent <raven@themaw.net>
Subject: Re: cache_delete_offset_list: active offset mount key
Date: Thu, 31 Jul 2008 11:54:27 +0800
Message-ID: <1217476468.2989.4.camel@raven.themaw.net>
References: <20080729183800.GB11329@pixar.com>
	<1217388746.2999.0.camel@raven.themaw.net>
	<20080730174214.GB848@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20080730174214.GB848@pixar.com>
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
To: Chris Walker <cwalker@pixar.com>
Cc: autofs@linux.kernel.org


On Wed, 2008-07-30 at 10:42 -0700, Chris Walker wrote:
> Sorry about that.
> 
> 2.6.18

What autofs4 specific patches have you applied.

> 
> This isn't reproducible and only happens occasionally on our compute
> farm.

I have a feeling that the current autofs4 kernel patch will help with
this.

> 
> From raven [07/29 20:39]:
> > 
> > On Tue, 2008-07-29 at 11:38 -0700, Chris Walker wrote:
> > > We're seeing a bunch of these:
> > > 
> > > Jul 28 09:23:21 XXXXX automount[11830]: cache_delete_offset_list: active offset mount key /net/XXXX/data
> > > 
> > > /net/XXXX/data isn't accessible through the automounter while other
> > > servers are accessible through /net. The automounter has to be restarted
> > > to correct this.
> > 
> > Kernel version and debug log please.
> > 
> > Ian
> > 
> > 
> 
