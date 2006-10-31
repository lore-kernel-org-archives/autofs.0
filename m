From: David Meleedy <david.meleedy@analog.com>
Subject: Re: /net support
Date: Tue, 31 Oct 2006 16:58:35 -0500
Message-ID: <200610312158.k9VLwZUM016118@jetcar.spd.analog.com>
References: <29733.1162328459@ichips.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Tue, 31 Oct 2006 13:00:59 PST."
	<29733.1162328459@ichips.intel.com> 
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
To: Joseph V Moss <jmoss@ichips.intel.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

> From jmoss@ichips.intel.com  Tue Oct 31 16:01:38 2006
> If you're going to be dealing with files that large, then you're probably
> better off switching to all TCP, since you can also switch to larger
> block sizes.  Try comparing the performance of copying files with
> 'tcp,rsize=32768,wsize=32768' to your current settings.

Although, this sounds like a good idea, in addition to having some
files that are huge, we have thousands of small 1k->4k files that
are accessed as well.  It's just a huge mix.  I'm not sure that
increasing tcp packet sizes would be a good thing given the huge
quantity of small files.  But maybe... 

Thanks,

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
