From: Tim Hockin <thockin@sun.com>
Subject: Re: RE: autofs scalability
Date: Thu, 4 Dec 2003 11:12:03 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <20031204191203.GA17865@sun.com>
References: <20031203194323.GB10772@sun.com>
	<Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs@linux.kernel.org

On Thu, Dec 04, 2003 at 09:37:44AM +0800, Ian Kent wrote:
> > removed the 256 limit, but has made it so that it CAN BE removed.  We hav a
> > prelim patch for that, which I wan tot rework, some, maybe.
> >
> 
> Are you refering to the sysctl recommendation.
> 
> I would like to do it but haven't had time.
> 
> I'll let you know if I get to start work on it.

Ditto. It's simple, but it just hasn't been high enough priority.
