From: Tim Hockin <thockin@sun.com>
Subject: Re: RE: autofs scalability
Date: Thu, 4 Dec 2003 14:37:33 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031204223733.GJ10772@sun.com>
References: <20031203194323.GB10772@sun.com>
	<Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
	<20031204191203.GA17865@sun.com> <3FCF9367.8040804@zytor.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <3FCF9367.8040804@zytor.com>
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

On Thu, Dec 04, 2003 at 12:04:55PM -0800, H. Peter Anvin wrote:
> > Ditto. It's simple, but it just hasn't been high enough priority.
> > 
> 
> It really would be better if it was dynamic.  Any fixed limit (other
> than 2^20 minors) is really  a hack.

You either allocate 2^20 bits for every user, or you allocate it as needed
(and handle alloc failures when they are least expected) or you sysctl it
and let the admin decide early on whether she wants to allow large numbers
of pseudo-devs.


-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
