From: raven@themaw.net
Subject: Re: Problem with NIS maps
Date: Sat, 4 Sep 2004 12:06:24 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409041204250.8861@donald.themaw.net>
References: <4133F97E.8060509@cjs226.com>
	<Pine.LNX.4.58.0408312110390.2756@raven.themaw.net>
	<413632D5.3090301@cjs226.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <413632D5.3090301@cjs226.com>
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
To: "Clif J. Smith" <plone@cjs226.com>
Cc: autofs@linux.kernel.org

On Wed, 1 Sep 2004, Clif J. Smith wrote:

> Ian Kent wrote:
> 
> >On Mon, 30 Aug 2004, Clif Smith wrote:
> >
> >  
> >
> >>I'm in a large heterogeneous environment located across multiple 
> >>locations.  I use NIS maps such as:
> >>/home -rw austin:/export/home boston:/export/home phoenix:/export/home
> >>
> >>with the following in /etc/auto.master:
> >>/nis      yp      auto_indirect_nis
> >>
> >>With AIX and Solaris, automounter chooses the server with the fewest
> >>hops to determine which server to mount from.  Unfortunately, it appears
> >>Suse's 8.1 implementation of automounter (v3.1.7-556) seems to choose 
> >>the first listed.
> >>    
> >>
> >
> >Sorry, SuSE have chosen not to update to autofs v4.
> >
> >The most recent version handles this.
> >
> >You may wish to try building the SRPM from one of the FC distributions.
> >
> >Ian
> >  
> >
> I ASSuMEd compiling it from source (4.1.3) would be even "cleaner", but 
> when I see that /etc/init.d/autofs has:
> if [ -f /etc/debian_version ]; then
>     system=debian
> elif [ -f /etc/redhat-release ]; then
>     system=redhat
> else
>     echo "$0: Unknown system, please port and contact 
> autofs@linux.kernel.org" 1>&2
>     exit 1
> fi
> 
> Why is the source so restrictive?
> 
> Moving on to the FC SRPM.
> 

Yes, that's a good point.

This is one of the issues that should be addressed when the master map 
parsing is taken into the daemon. It's pretty much the highest priority 
task atm.

Ian
