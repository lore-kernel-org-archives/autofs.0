From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs v4 beta3 (fwd)
Date: Fri, 14 Nov 2003 08:24:37 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311140823140.28052-100000@wombat.indigo.net.au>
References: <3FB397B9.9010600@rhythm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB397B9.9010600@rhythm.com>
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
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

On Thu, 13 Nov 2003, Greg Bradner wrote:

> I have multiple mount points on a NetApp, but I don't have 'access'
> permissions to all of them.  When autofs encountered a permission denied
> on one of the mount points, it didn't mount any of them.  Shouldn't it
> just skip over the permission denied one and still mount the others?

More info please.

What does your map entry look like?
What version of autofs are you using?


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
