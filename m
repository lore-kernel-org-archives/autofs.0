From: Ian Kent <raven@themaw.net>
Subject: Re: multiple servers per automount
Date: Fri, 10 Oct 2003 09:16:33 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0310100915540.7746-100000@wombat.indigo.net.au>
References: <3F85D4EA.5030708@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3F85D4EA.5030708@sun.com>
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
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: "Ogden, Aaron A." <aogden@unocal.com>, autofs mailing list <autofs@linux.kernel.org>

On Thu, 9 Oct 2003, Mike Waychison wrote:

>
> 2.6 mainline still has the 256 pseudo-block device limit.  Fortunately,
> the patches used in distros should still apply with minimal fuzz.  Devfs
> probably won't help matters here.
>
> I think the next step in 2.6 is to change the bitmap used to grow as
> needed..  especially now that minors are 20 bits, or 1048576 minors  :))

Missed that.

I'll have to look more closely.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
