From: Joseph V Moss <jmoss@ichips.intel.com>
Subject: Re: /net support
Date: Tue, 31 Oct 2006 13:00:59 -0800
Message-ID: <29733.1162328459@ichips.intel.com>
References: <200610312042.k9VKgBVw009630@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Tue, 31 Oct 2006 15:42:11 EST."
	<200610312042.k9VKgBVw009630@jetcar.spd.analog.com> 
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

> 
> > That very much depends on usage.
> > 
> > If you have a bunch of clients that typically open and load files of
> > potentially several hundred megabytes then UDP retransmits can become a
> > problem.
> > 
> > But then if traffic is light there's not much to be gained and if there
> > are traffic spikes possibly something to be lost.
> 
> Well, our CAD software can generate files varying from several hundred
> megabytes up to 1-3 gigabytes.  So yes, we actually do have
> large files being transmitted, which is why I had been looking at not
> using tcp on the LAN.  But tcp is the only reliable WAN method I've
> found.  I think what I'm going to have to do is generate local NIS
> maps for every client and use a "program" script to read them.  That
> way I can insert the appropriate flags in there, depending on whether
> or not a machine is on the LAN vs. WAN.  I had just noticed that on
> Solaris, the behavior seems to work much better than on linux, so I was
> kind of wondering how they had solved it.

If you're going to be dealing with files that large, then you're probably
better off switching to all TCP, since you can also switch to larger
block sizes.  Try comparing the performance of copying files with
'tcp,rsize=32768,wsize=32768' to your current settings.
