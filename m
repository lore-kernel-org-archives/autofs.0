From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 patches for 2.6 kernel
Date: Sat, 10 Apr 2004 21:14:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404102113300.5094@raven.themaw.net>
References: <Pine.LNX.4.58.0404071952170.4948@raven.themaw.net>
 <20040409204604.GB4007@foudroyante.lifl.fr>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040409204604.GB4007@foudroyante.lifl.fr>
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
To: Julien.Soula@lifl.fr
Cc: autofs mailing list <autofs@linux.kernel.org>

On Fri, 9 Apr 2004 Julien.Soula@lifl.fr wrote:

> On Wed, Apr 07, 2004 at 08:04:18PM +0800, Ian Kent wrote:
> > 
> > Hi all,
> > 
> > Some progress on getting the autofs4 patches into the kernel tree.
> > 
> > Could anyone that is able to test within a 2.6 envronment please test this 
> > as much as possible and feed back the results.
> > 
> > There are bound to be problems so it would be good to be pro-active.
> 
> It's not really related to kernel side but it seems that the variables
> on command line (-Dtoto=tata) are not passed throught submount, at
> least for direct mount.
> 
> I test it with automount version 4.1.2

You are correct.

I have a contributed patch for that and hope to get to it soon.

Ian
