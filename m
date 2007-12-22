From: Ian Kent <raven@themaw.net>
Subject: Re: Linux+Solaris - NIS auto.master versus autofs5
Date: Sat, 22 Dec 2007 17:46:14 +0900
Message-ID: <1198313175.3114.74.camel@raven.themaw.net>
References: <753ec7300712211400g3eb45b21n1f236fe7056f87a1@mail.gmail.com>
	<1198312105.3114.71.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1198312105.3114.71.camel@raven.themaw.net>
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
To: David Mack <davidwmack@gmail.com>
Cc: autofs@linux.kernel.org

On Sat, 2007-12-22 at 17:28 +0900, Ian Kent wrote:
> > 
> > It appears that the problem is that autofs5 doesn't like parameters
> > introduces with hyphens in auto.master, which Solaris unfortunately
> > requires.
> 
> OK, I don't think that's correct.
> Perhaps it has been fixed over time and I missed that I fixed it.
> 
> It is true that the man page specifies no "-" but I believe it is
> accepted and works.

And a quick test here confirms that this work for me even with a
relatively old verion 5.

Ian
