From: Jeff Moyer <jmoyer@redhat.com>
Subject: RE: auotfs/NFS Issue with WAN mounted filesystem?
Date: Wed, 23 Feb 2005 12:39:01 -0500
Message-ID: <16924.49077.320677.10889@segfault.boston.redhat.com>
References: <10EE351D89AE1F488B426AC91EF6EDAB012813AC@server-1.ad.lsil.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <10EE351D89AE1F488B426AC91EF6EDAB012813AC@server-1.ad.lsil.com>
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
To: Jeffery Malloch <jmall@lsil.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>, Kevork Kechichian <kkechich@lsil.com>, "'ges-field-east@lsil.com'" <ges-field-east@lsil.com>, Michael Gallant <mgallant@lsil.com>, Ian Kent <raven@themaw.net>

==> Regarding RE: [autofs] auotfs/NFS Issue with WAN mounted filesystem?; Jeffery Malloch <jmall@lsil.com> adds:

jmall> -----Original Message----- From: Jeff Moyer
jmall> [mailto:jmoyer@redhat.com] Sent: Wednesday, February 23, 2005 11:30
jmall> AM To: Ian Kent Cc: Jeffery Malloch; 'autofs@linux.kernel.org';
jmall> Kevork Kechichian; Michael Gallant Subject: RE: [autofs] auotfs/NFS
jmall> Issue with WAN mounted filesystem?

==> Regarding RE: [autofs] auotfs/NFS Issue with WAN mounted filesystem?;
jmall> Ian Kent <raven@themaw.net> adds:

raven> On Tue, 22 Feb 2005, Jeffery Malloch wrote:
>>> Hi Ian,
>>> 
>>> Sorry it's been such a long time but I thought I had gotten my issue
>>> down to an issue with IBM Clearcase and their "mvfs" implementation.
>>> But as it happens, I believe there still to be issues with autofs in
>>> RedHat WS3 U3.  I am currently using autofs-4.1.3-47.  I have been
>>> running many automounts on the linux systems in debug mode for some
>>> time.  But here's what I have to give you for now:
>>> 
>>> Feb 21 23:44:33 lserver-11 automount[15042]: rm_unwanted:
>>> /lsi/vp/bed_shared Feb 21 23:44:33 lserver-11 automount[15042]: expired
>>> /lsi/vp/bed_shared Feb 21 23:44:38 lserver-11 automount[1700]:
>>> attempting to mount entry /lsi/vp/bed_shared Feb 22 00:16:51 lserver-11
>>> automount[19628]: BUG: /lsi/vp/bed_shared already mounted
>>> 

raven> This is usually due to mtab corruption caused by broken file locking
raven> in mount and autofs.

raven> What is the state of mtab when this happens.

jmall> Actually, please include the state of /proc/mounts, too, so we can
jmall> verify whether there is corruption.  One without the other is pretty
jmall> much useless.

jmall> -Jeff

jmall> ----------------------------------------------------------------------------

jmall> Hi Guys,

jmall> I have a machine that went into this state again...  Here's a list
jmall> of what I see:

jmall> - I can look at the /proc/mounts and /etc/mtab without issue so they
jmall> don't appear corrupted in any way

Let me rephrase: we want to know if these two files are out of synch.  As
such, please actually include their contents here!

-Jeff
