From: Ian Kent <raven@themaw.net>
Subject: Re: Re: newly added heirarchical mount points not found
Date: Mon, 1 Mar 2004 16:04:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403011547160.15326@raven.themaw.net>
References: <1077211015.19371.32.camel@brilong-lnx2.cisco.com> 
	<1077211301.19371.34.camel@brilong-lnx2.cisco.com> 
	<Pine.LNX.4.58.0402202058120.4573@raven.themaw.net>
	<403AA2A7.3010409@motorola.com>
	<Pine.LNX.4.58.0402251203060.31545@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402251203060.31545@wombat.indigo.net.au>
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
To: Tom Georgoulias <tom.georgoulias@motorola.com>
Cc: autofs@linux.kernel.org

On Wed, 25 Feb 2004, Ian Kent wrote:

> On Mon, 23 Feb 2004, Tom Georgoulias wrote:
> 
> > Hi:
> > 
> > I'd like to know if the heirarchical mount point behavior I've been 
> > seeing lately with autofs4 is what I should expect.  When I add an 
> > additional submount point to an existing set of heirarchical mounts, I 
> > cannot access the file system referenced by the new mount point.

Unfortunately it is. After checking the code I see that autofs v4 does 
not look inside the multi-mount map. It just mounts the whole thing and 
umounts it after a timeout (you already know this anyway). Consequently 
changes to the map are not seen until it is umounted and then remounted. 
To change this is quite a bit of work because of the tight coupling 
between the mount lookup and the action of the mount itself in the 
current design.

This design has caused me pain before and I have been planning to rework 
it for ages. I've been trying to complete as many bug fixes and requested 
features (that are fairly straight forward) before starting this as it's 
likely to take quite a while (and will probably be the start of 4.2.x).

So the news is not good I'm afraid. As I said I'll try and implement a 
work around in the 4.1.x release but I can't work out a way to do it yet
without a fair bit of change to the code.

Ian
