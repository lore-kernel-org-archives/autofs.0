From: Ian Kent <raven@themaw.net>
Subject: Re: automount does not close file descriptors at start
Date: Thu, 17 Feb 2005 09:40:03 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502170939200.19755@wombat.indigo.net.au>
References: <20050216125350.GA6031@uio.no>
	<Pine.LNX.4.61.0502162301590.8161@donald.themaw.net>
	<20050216222749.GA19214@ba.issia.cnr.it>
Mime-Version: 1.0
In-Reply-To: <20050216222749.GA19214@ba.issia.cnr.it>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Francesco P. Lovergine" <f.lovergine@acm.org>
Cc: autofs@linux.kernel.org

On Wed, 16 Feb 2005, Francesco P. Lovergine wrote:

> On Wed, Feb 16, 2005 at 11:04:07PM +0800, raven@themaw.net wrote:
> > On Wed, 16 Feb 2005, Steinar H. Gunderson wrote:
> > 
> > >Hi,
> > >
> > >My latest autofs package for Debian (4.1.3+4.1.4beta2-1) had problems
> > >installing, freezing after install; I've worked around this now
> > >(4.1.3+4.1.4beta2-2 is on its way up to the archive), but I've been told 
> > >this
> > >is really a bug in automount. What I've been told is along the lines of:
> > >
> > >"Any daemon going into the background should close all file descriptors 
> > >from
> > >zero up to MAXFDS minus the ones it actually wants to have open."
> > 
> > And you would like to substantiate that, right!
> > 
> 
> Err, maybe closing stdin,stdout and stderr? 

MAXFDS is much larger that 2.
