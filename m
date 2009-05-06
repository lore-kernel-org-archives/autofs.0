From: Matthias =?iso-8859-1?Q?K=F6nig?= <mk@phasorlab.de>
Subject: Re: using autofs ...
Date: Wed, 6 May 2009 21:50:36 +0200
Message-ID: <20090506195036.GA4877@zebra.localsite>
References: <1241636410.4468.22.camel@bellerophon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1241636410.4468.22.camel@bellerophon>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: raespi <raespi@estudiantes.uci.cu>
Cc: autofs@linux.kernel.org

raespi <raespi@estudiantes.uci.cu> wrote:

> It works ... My question is, why can't I use the "/" directory as a key
> name?? And how could I configure the two files so I can mount everything
> in "/home" ??

Because with normal indirect mounts / would be overmounted with an
autofs filesystem.
The alternative is using direct mounts (assuming autofs5) by using
/- for the mount point in the master map and give the full path of
the mount point as key in the map, something like this should work:

auto.master:
/-	/etc/auto.home

auto.home:
/home	x.x.x.x:/home

Matthias
