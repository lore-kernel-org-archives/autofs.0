From: Ian Kent <raven@themaw.net>
Subject: Re: weighting factor?
Date: Thu, 23 Apr 2009 14:34:12 +0800
Message-ID: <49F00BE4.8020205@themaw.net>
References: <OFA7BAAD33.0A4CD567-ON8825759F.00604D01-8825759F.006168EB@mck.us.ray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OFA7BAAD33.0A4CD567-ON8825759F.00604D01-8825759F.006168EB@mck.us.ray.com>
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
To: Darlene D Choontanom <dchoontanom@raytheon.com>
Cc: autofs@linux.kernel.org

Darlene D Choontanom wrote:
> Hi, all--
> 
> Apologies in advance if this has been asked before, but I'm running into 
> issues with a shared NIS auto.home file we're trying to stand up between 
> two remote sites.  My clients are a mixture of Solaris and RHEL 3 & 4 
> machines.  A sample entry in question reads:

This won't work how you want in RHEL-3 but should work in reasonably
recent versions of autofs on RHEL-4.

> 
> foo     thisserver:/export/home4/& \
>         thatserver:/export/home10/&
> 
> The Sun clients work fine, automounting the server closest to them 
> geographically.  The Linux boxes, however, all seem to want to mount 
> "thatserver", regardless of how far the distance is between them.  I tried 
> weighting them:
> 
> foo     thisserver(1):/export/home4/& \
>         thatserver(9):/export/home10/&
> 
> But while that seems to work okay for some of my RHEL boxes, it doesn't 
> seem to get recognized on others.  I'd like to try to restart the 
> automounter on the non-working clients, but since they're all in 
> production, it'll be a little tricky if I don't want to impact my users.
> 
> Is this a known problem, or is there a fix?  The weighting factor really 
> will only fix the clients closest to "thisserver" ; I'd rather not force 
> the clients close to "thatserver" to have to go to a remote box if there's 
> a closer one they should be mounting, instead.
> 
> Thanks--
> Darlene
> 
> ---
> dchoontanom@raytheon.com                                        Raytheon 
> Company
> 310.334.5478
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
