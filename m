From: Jeffery Malloch <jmall@lsil.com>
Subject: auotfs/NFS Issue with WAN mounted filesystem?
Date: Fri, 3 Dec 2004 15:01:31 -0500
Message-ID: <10EE351D89AE1F488B426AC91EF6EDAB0128105F@server-1.videolocus.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
To: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

Hi,

I appear to be seeing some sort of hang or race condition when accessing
code from a WAN automounted filesystem.  We have a 4Mbps VPN link between
our site and the site we are automounting from.  As many have observed in
other threads, this doesn't seem to occur on Solaris.  For linux I am
running RedHat WS3 Update 3 and the version of autofs is 4.1.3-12 (came with
OS).  The end result is that the process accessing this filesystem sits in a
constant I/O wait state and the same automount map is mounted twice (or even
three times).  It pretty much makes the system unusable and the only
recourse so far has been a reboot.  Does anyone have any suggestions other
then making the data available locally?

Thanks,

Jeff Malloch
Senior Systems Administrator, LSI Logic
