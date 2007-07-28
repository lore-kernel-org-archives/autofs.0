From: Ian Kent <raven@themaw.net>
Subject: Re: Seeing some 5.0.1 stop expiring mounts
Date: Sat, 28 Jul 2007 14:51:12 +0800
Message-ID: <1185605472.8326.6.camel@raven.themaw.net>
References: <20070717195431.GA14624@cornholio.qualcomm.com>
	<1184741167.4178.50.camel@raven.themaw.net>
	<20070718213945.GA7455@cornholio.qualcomm.com>
	<1184847139.3258.63.camel@raven.themaw.net>
	<20070719234009.GS7455@cornholio.qualcomm.com>
	<1185507080.3203.15.camel@raven.themaw.net>
	<20070727220608.GD26192@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20070727220608.GD26192@cornholio.qualcomm.com>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@linux.kernel.org

On Fri, 2007-07-27 at 15:06 -0700, Mike Marion wrote:
> On Fri, Jul 27, 2007 at 11:31:20AM +0800, Ian Kent wrote:
> 
> > Don't mean to be a pain but have you had time to check this?
> 
> Not a pain.. too much got in the way this week. I was able to test that
> patch both against 5.0.1 with the
> autofs-5.0.1-map-update-source-only.patch 
> and against 5.0.2 and it's good.

Cool .. I'll commit the patch to the repo and deal with any other issues
as we need this anyway.

Thanks

> 
> Just to show, here's 5.0.2 without those 2 lines patched in2
> 
> vbr2-001:/usr/src/packages/SOURCES # ps auxw | grep automount
> root      6812  0.7  0.0  28552  7180 ?        Ssl  13:59   0:00
> automount
> root      6935  0.0  0.0   2888   704 pts/1    S+   14:00   0:00 grep
> automount
> vbr2-001:/usr/src/packages/SOURCES # wc /proc/mounts; mount | wc ; kill
> -HUP 6812; while [ 1 ]; do wc /proc/mounts ; mount | wc; sleep 5; done
> 6314 37884 730725 /proc/mounts
>      12      72     441
> 6314 37884 730725 /proc/mounts
>      12      72     441
> 6107 36642 706276 /proc/mounts
>      12      72     441
> 5964 35784 689905 /proc/mounts
>      12      72     441
> 5833 34998 674567 /proc/mounts
>      12      72     441
> 5695 34170 658506 /proc/mounts
>      12      72     441
> 5477 32862 633119 /proc/mounts
>      12      72     441
> 
> 
> and on down until all the auto.projects entries are gone... which takes
> awhile.
> 
> The syslog shows them all being unmounted, unlike 5.0.1 it only shows
> the "rmdir lmstat of <path> failed" messages for things that were
> actually nfs mounted vs the entire auto.projects tree though.
> 
