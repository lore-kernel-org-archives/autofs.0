From: Ian Kent <raven@themaw.net>
Subject: Re: RE: autofs scalability
Date: Thu, 4 Dec 2003 09:37:44 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312040935420.7055-100000@wombat.indigo.net.au>
References: <20031203194323.GB10772@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20031203194323.GB10772@sun.com>
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
To: Tim Hockin <thockin@sun.com>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs@linux.kernel.org

On Wed, 3 Dec 2003, Tim Hockin wrote:

> On Wed, Dec 03, 2003 at 01:19:27PM -0600, Ogden, Aaron A. wrote:
> > 'unnamed device' limit has been raised from 256 to 4096 in kernel 2.6,
> > can anyone confirm this?  If this is the case the only barrier left to
> > remove is the RPC port limitation of ~800 open ports.  If the
> > connections were multiplexed such that all connections to a given server
> > used the same port then 800 ports would stretch a lot farther than they
> > do now...
>
> We're investigating the 800 limit reasoning.  2.6.(last I looked) has not
> removed the 256 limit, but has made it so that it CAN BE removed.  We hav a
> prelim patch for that, which I wan tot rework, some, maybe.
>

Are you refering to the sysctl recommendation.

I would like to do it but haven't had time.

I'll let you know if I get to start work on it.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
