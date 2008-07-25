From: Mike Marion <mmarion@qualcomm.com>
Subject: "no hosts available"
Date: Fri, 25 Jul 2008 15:44:30 -0700
Message-ID: <20080725224430.GL13495@u20m2mm.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

Google didn't help much, nothing I see in RH's bugzilla, and I don't understand 
the code enough to figure out... what are a couple ideas of what could trigger the
following error on an attempted mount:

automount[32110]: mount_mount: mount(nfs): no hosts available

Note, this is across a WAN connection to a filer at another site.. so
could network issues do this?  Just trying to track down possible causes
of periodic failures to mount.

Will attempt to catch on a host with debug log vs verbose.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
[Joe just pulled Antonio away from a beautiful woman he was talking to, to move
a cabinet a tiny bit]
Antonio: "We barely moved it!"   Joe: "Yeah I know, but it was askew!  Isn't it 
amazing how something like that can throw off your whole day?"
Antonio: "Yes, and you know I only wish I could stay and slap you senseless.. 
but there's a goddess waiting for me in the terminal." -- Wings
