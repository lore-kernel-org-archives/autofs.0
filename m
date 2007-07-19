From: Ian Kent <raven@themaw.net>
Subject: Re: Seeing some 5.0.1 stop expiring mounts
Date: Thu, 19 Jul 2007 20:12:19 +0800
Message-ID: <1184847139.3258.63.camel@raven.themaw.net>
References: <20070717195431.GA14624@cornholio.qualcomm.com>
	<1184741167.4178.50.camel@raven.themaw.net>
	<20070718213945.GA7455@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070718213945.GA7455@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Wed, 2007-07-18 at 14:39 -0700, Mike Marion wrote:
> On Wed, Jul 18, 2007 at 02:46:07PM +0800, Ian Kent wrote:
> 
> > Might be worth considering going to 5.0.2, especially since you have a
> > busy site, as a nasty deadlock in the alarm handler has been fixed. 
> 

snip ...

> With the above patch applied to 5.0.1 (or using 5.0.2) as soon as the
> daemon gets a HUP signal, it flushes out all the auto.projects (our main
> map) entries from /proc/mounts and they're gone forever.

fwiw, the map-update-source-only patch is quite an important change from
the point of view of the version 5 design and the correct operation of
the map update logic. The reason it was needed is that I changed the way
instances of maps are sorted during initial development but didn't
properly account for it.

I really appreciate any time you can spare to help with this.

Thanks
Ian
