From: Ryan Go <ryan@rentec.com>
Subject: Re: Problem with NIS maps
Date: Wed, 1 Sep 2004 08:54:42 -0400 (EDT)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409010851430.6576@vulture.rentec.com>
References: <4133F97E.8060509@cjs226.com>
	<Pine.LNX.4.58.0408312110390.2756@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408312110390.2756@raven.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Hello,

We don't use the replicated stuff so I am not sure if it works with SuSE.
But 8.1 has autofs v4 (not the latest one though), you might wanna check
it out.

HTH,
	<< ryan

On Tue, 31 Aug 2004, Ian Kent wrote:

> On Mon, 30 Aug 2004, Clif Smith wrote:
>
> > I'm in a large heterogeneous environment located across multiple
> > locations.  I use NIS maps such as:
> > /home -rw austin:/export/home boston:/export/home phoenix:/export/home
> >
> > with the following in /etc/auto.master:
> > /nis      yp      auto_indirect_nis
> >
> > With AIX and Solaris, automounter chooses the server with the fewest
> > hops to determine which server to mount from.  Unfortunately, it appears
> > Suse's 8.1 implementation of automounter (v3.1.7-556) seems to choose
> > the first listed.
>
> Sorry, SuSE have chosen not to update to autofs v4.
>
> The most recent version handles this.
>
> You may wish to try building the SRPM from one of the FC distributions.
>
> Ian
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
