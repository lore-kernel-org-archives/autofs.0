From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs v4 beta3 (fwd)
Date: Fri, 14 Nov 2003 10:59:34 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311141052560.30495-100000@wombat.indigo.net.au>
References: <3FB3BC61.8060005@intel.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <3FB3BC61.8060005@intel.com>
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
To: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Cc: autofs@linux.kernel.org

On Thu, 13 Nov 2003, Taylor, ForrestX wrote:

> Greg Bradner wrote:
> > I have multiple mount points on a NetApp, but I don't have 'access'
> > permissions to all of them.  When autofs encountered a permission denied
> > on one of the mount points, it didn't mount any of them.  Shouldn't it
> > just skip over the permission denied one and still mount the others?
>
> That is what the nonstrict option is for.
>

How embarressing. I thought I knew the autofs code pretty well but clearly
not.

Now I will have to backout one of the patches in 4.1.0-beta3.

Very cool Forrest, Thanks.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
