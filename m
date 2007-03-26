From: Jarl Stefansson <jarl@marimo.is>
Subject: Re: Unmount not working with 2.6.21  & 4.1.3/4.1.4
Date: Mon, 26 Mar 2007 13:22:47 +0000 (GMT)
Message-ID: <22356485.6841174915367481.JavaMail.root@holcus>
References: <1174885989.4483.0.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1174885989.4483.0.camel@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hi Ian,

I spent the morning testing automount on several other kernels, I have verified that the problem also affects:

2.6.19-gentoo-r1
2.6.20-gentoo-r5
2.6.21-rc2-git4

Yours

Jarl


----- Original Message -----
From: Ian Kent <raven@themaw.net>
To: Jarl Stefansson <jarl@marimo.is>
Cc: autofs@linux.kernel.org
Sent: Monday, March 26, 2007 5:13:09 AM GMT Africa/Casablanca
Subject: Re: [autofs] Unmount not working with 2.6.21  & 4.1.3/4.1.4

On Mon, 2007-03-26 at 12:07 +0800, Ian Kent wrote:
> On Sun, 2007-03-25 at 17:38 +0000, Jarl Stefansson wrote:
> > I'm working on a custom Gentoo build and autofs seems to completely ignore all timeout/unmount attempts.
> > 
> > My configuration is 2.6.21-rc3-mm2 with 4.1.3-R7.
> 
> Are you sure this doesn't happen with 2.6.20?

And does this also happen with 2.6.21-rc kernels?

Ian
