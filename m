From: Jeff Moyer <jmoyer@redhat.com>
Subject: RE: auotfs/NFS Issue with WAN mounted filesystem?
Date: Wed, 23 Feb 2005 11:30:21 -0500
Message-ID: <16924.44957.101559.336147@segfault.boston.redhat.com>
References: <10EE351D89AE1F488B426AC91EF6EDAB0128138C@server-1.ad.lsil.com>
	<Pine.LNX.4.58.0502231215210.5535@wombat.indigo.net.au>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0502231215210.5535@wombat.indigo.net.au>
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
To: Ian Kent <raven@themaw.net>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>, Kevork Kechichian <kkechich@lsil.com>, Michael Gallant <mgallant@lsil.com>, Jeffery Malloch <jmall@lsil.com>

==> Regarding RE: [autofs] auotfs/NFS Issue with WAN mounted filesystem?; Ian Kent <raven@themaw.net> adds:

raven> On Tue, 22 Feb 2005, Jeffery Malloch wrote:
>> Hi Ian,
>> 
>> Sorry it's been such a long time but I thought I had gotten my issue
>> down to an issue with IBM Clearcase and their "mvfs" implementation.
>> But as it happens, I believe there still to be issues with autofs in
>> RedHat WS3 U3.  I am currently using autofs-4.1.3-47.  I have been
>> running many automounts on the linux systems in debug mode for some
>> time.  But here's what I have to give you for now:
>> 
>> Feb 21 23:44:33 lserver-11 automount[15042]: rm_unwanted:
>> /lsi/vp/bed_shared Feb 21 23:44:33 lserver-11 automount[15042]: expired
>> /lsi/vp/bed_shared Feb 21 23:44:38 lserver-11 automount[1700]:
>> attempting to mount entry /lsi/vp/bed_shared Feb 22 00:16:51 lserver-11
>> automount[19628]: BUG: /lsi/vp/bed_shared already mounted
>> 

raven> This is usually due to mtab corruption caused by broken file locking
raven> in mount and autofs.

raven> What is the state of mtab when this happens.

Actually, please include the state of /proc/mounts, too, so we can verify
whether there is corruption.  One without the other is pretty much useless.

-Jeff
