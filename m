From: Ian Kent <raven@themaw.net>
Subject: Re: timeout for direct mounts?
Date: Tue, 07 Oct 2008 09:36:15 +0800
Message-ID: <1223343375.3031.2.camel@raven.themaw.net>
References: <20080905232113.GW18282@pixar.com>
	<1223284729.3162.46.camel@raven.themaw.net>
	<20081006131916.GQ25342@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20081006131916.GQ25342@pixar.com>
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

On Mon, 2008-10-06 at 06:19 -0700, Chris Walker wrote:
> I didn't. I'm just not sure where to put the --timeout arg to get to
> work for direct mounts.

It's the same as for indirect map entries.
At the end of the line in the master map entry.

/-	auto.direct --timeout=180

The question gets more interesting if you have multiple direct map
entries.

> 
> From raven [10/06 02:20]:
> > On Fri, 2008-09-05 at 16:21 -0700, Chris Walker wrote:
> > > I can't seem to figure out where to specify the timeout for a direct
> > > mount. It doesn't seem to work as an option in auto.master or
> > > auto.direct.
> > 
> > Did you find out what this problem was?
> > 
> > Ian
> > 
> > 
> 
