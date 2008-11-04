From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS5 for 2.6.27.x?
Date: Tue, 04 Nov 2008 09:37:38 +0900
Message-ID: <1225759058.3003.12.camel@zeus.themaw.net>
References: <490EFB81.3060102@aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <490EFB81.3060102@aei.mpg.de>
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
To: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Cc: autofs@linux.kernel.org

On Mon, 2008-11-03 at 14:24 +0100, Carsten Aulbert wrote:
> Hi all,
> 
> I'm reading/skimming this list for quite a bit of time, but somehow I
> lost track. In the mainline kernel 2.6.27.4 there seems to be only
> autofs4 not autofs5, right?  At least I'm only seeing CONFIG_AUTOFS_FS
> and CONFIG_AUTOFS4_FS.

Like Jeff says, you need autofs4.

You should make sure that the autofs4 module is being loaded, not the
autofs module. If your using a later init script it will explicitly load
the module, but only if one isn't already present (so rmmod autofs
before startup should make things work). Another way to prevent being
caught is to "alias autofs autofs4" in your modules configuration (at
least I think that's the order, it's been a while since we've had this
problem reported).

> 
> On the ftp server of kernel.org I found 5.0.3 patches from January, but
> that seems quite old to me. The golden question: Is this the correct
> tarball to use or is there some git repo were I should pull the patches
> - and how?

The version 5 patch series is located at:
http://www.kernel.org/pub/linux/daemons/autofs/v5.

See patch_order-5.0.3 also. The patch list is quite large.

The git repo is at:
git clone git://git.kernel.org/pub/scm/linux/storage/autofs/autofs.git

The kernel patches in the repo are usually not up to date but, as I'm
wanting to release 5.0.4, they are at the moment.

Ian
