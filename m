From: Ian Kent <raven@themaw.net>
Subject: RE: auotfs/NFS Issue with WAN mounted filesystem?
Date: Wed, 23 Feb 2005 12:17:08 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0502231215210.5535@wombat.indigo.net.au>
References: <10EE351D89AE1F488B426AC91EF6EDAB0128138C@server-1.ad.lsil.com>
Mime-Version: 1.0
In-Reply-To: <10EE351D89AE1F488B426AC91EF6EDAB0128138C@server-1.ad.lsil.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeffery Malloch <jmall@lsil.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>, Kevork Kechichian <kkechich@lsil.com>, Michael Gallant <mgallant@lsil.com>

On Tue, 22 Feb 2005, Jeffery Malloch wrote:

> Hi Ian,
> 
> Sorry it's been such a long time but I thought I had gotten my issue down to
> an issue with IBM Clearcase and their "mvfs" implementation.  But as it
> happens, I believe there still to be issues with autofs in RedHat WS3 U3.  I
> am currently using autofs-4.1.3-47.  I have been running many automounts on
> the linux systems in debug mode for some time.  But here's what I have to
> give you for now:
> 
> Feb 21 23:44:33 lserver-11 automount[15042]: rm_unwanted: /lsi/vp/bed_shared
> Feb 21 23:44:33 lserver-11 automount[15042]: expired /lsi/vp/bed_shared
> Feb 21 23:44:38 lserver-11 automount[1700]: attempting to mount entry
> /lsi/vp/bed_shared
> Feb 22 00:16:51 lserver-11 automount[19628]: BUG: /lsi/vp/bed_shared already
> mounted
> 

This is usually due to mtab corruption caused by broken file locking in 
mount and autofs.

What is the state of mtab when this happens.

Ian
