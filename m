From: Tim Hockin <thockin@sun.com>
Subject: Re: RE: autofs scalability
Date: Thu, 4 Dec 2003 15:12:46 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031204231246.GL10772@sun.com>
References: <20031203194323.GB10772@sun.com>
	<Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
	<20031204191203.GA17865@sun.com> <3FCF9367.8040804@zytor.com>
	<20031204223733.GJ10772@sun.com> <3FCFBE9B.6080807@zytor.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <3FCFBE9B.6080807@zytor.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

On Thu, Dec 04, 2003 at 03:09:15PM -0800, H. Peter Anvin wrote:
> > You either allocate 2^20 bits for every user, or you allocate it as needed
> > (and handle alloc failures when they are least expected) or you sysctl it
> > and let the admin decide early on whether she wants to allow large numbers
> > of pseudo-devs.

> I can't imagine that these are allocated left and center... it should
> pretty much be mount and nothing else.  So yes, it's some more
> complexity but not really significant.
> 
> 2^20 bits = 128K, which falls in the "it's a bit on the expensive side,
> but doable" class.
> 
> Fixed limits suck.  And yes, I'm also guilty of having put them in in
> the past.  They still suck.


I think we agree about fixed limits, I'm just wary to spend 128k of every
user's box for it, which is why I mentioned sysctl.

Tim
-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
