From: Jeffery Malloch <jmall@lsil.com>
Subject: RE: auotfs/NFS Issue with WAN mounted filesystem?
Date: Tue, 22 Feb 2005 12:43:40 -0500
Message-ID: <10EE351D89AE1F488B426AC91EF6EDAB0128138C@server-1.ad.lsil.com>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Ian Kent' <raven@themaw.net>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>, Kevork Kechichian <kkechich@lsil.com>, Michael Gallant <mgallant@lsil.com>

Hi Ian,

Sorry it's been such a long time but I thought I had gotten my issue down to
an issue with IBM Clearcase and their "mvfs" implementation.  But as it
happens, I believe there still to be issues with autofs in RedHat WS3 U3.  I
am currently using autofs-4.1.3-47.  I have been running many automounts on
the linux systems in debug mode for some time.  But here's what I have to
give you for now:

Feb 21 23:44:33 lserver-11 automount[15042]: rm_unwanted: /lsi/vp/bed_shared
Feb 21 23:44:33 lserver-11 automount[15042]: expired /lsi/vp/bed_shared
Feb 21 23:44:38 lserver-11 automount[1700]: attempting to mount entry
/lsi/vp/bed_shared
Feb 22 00:16:51 lserver-11 automount[19628]: BUG: /lsi/vp/bed_shared already
mounted

And this is the automount process:

/usr/sbin/automount --timeout=60 --debug /lsi/vp yp auto_lsi_vp
rw,intr,,noatime

Any help would be appreciated.

Thanks!

Jeff

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Wednesday, December 15, 2004 5:06 AM
To: Jeffery Malloch
Cc: 'autofs@linux.kernel.org'
Subject: Re: [autofs] auotfs/NFS Issue with WAN mounted filesystem?

On Fri, 3 Dec 2004, Jeffery Malloch wrote:

> Hi,
> 
> I appear to be seeing some sort of hang or race condition when accessing
> code from a WAN automounted filesystem.  We have a 4Mbps VPN link between
> our site and the site we are automounting from.  As many have observed in
> other threads, this doesn't seem to occur on Solaris.  For linux I am
> running RedHat WS3 Update 3 and the version of autofs is 4.1.3-12 (came
with
> OS).  The end result is that the process accessing this filesystem sits in
a
> constant I/O wait state and the same automount map is mounted twice (or
even
> three times).  It pretty much makes the system unusable and the only
> recourse so far has been a reboot.  Does anyone have any suggestions other
> then making the data available locally?

Add --debug to your master map entries and send the log output.

Ian
