From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RE: autofs scalability
Date: Thu, 04 Dec 2003 15:09:15 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <3FCFBE9B.6080807@zytor.com>
References: <20031203194323.GB10772@sun.com>
	<Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
	<20031204191203.GA17865@sun.com> <3FCF9367.8040804@zytor.com>
	<20031204223733.GJ10772@sun.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20031204223733.GJ10772@sun.com>
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
To: thockin@sun.com
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

Tim Hockin wrote:
> 
> You either allocate 2^20 bits for every user, or you allocate it as needed
> (and handle alloc failures when they are least expected) or you sysctl it
> and let the admin decide early on whether she wants to allow large numbers
> of pseudo-devs.
> 

I can't imagine that these are allocated left and center... it should
pretty much be mount and nothing else.  So yes, it's some more
complexity but not really significant.

2^20 bits = 128K, which falls in the "it's a bit on the expensive side,
but doable" class.

Fixed limits suck.  And yes, I'm also guilty of having put them in in
the past.  They still suck.

	-hpa
