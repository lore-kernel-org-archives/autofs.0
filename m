From: Michael Marion <mmarion@qualcomm.com>
Subject: Failure to mount without ever trying to mount..
Date: Tue, 31 May 2005 14:42:02 -0700 (PDT)
Message-ID: <200505312142.j4VLg3OT016150@cornholio.qualcomm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: INLINE
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Wonder if this is known.. don't see the same thing in the list, but I'm way
behind.

Most hosts failing to mount a test server, but watching packets shows that it
never does try to mount.  I've verified that patching 4.1.4 with:
autofs-4.1.4-multi-parse-fix.patch
autofs-4.1.4-non-replicated-ping.patch
autofs-4.1.4-misc-fixes.patch

fixes the problem, and I'm guessing it's the non-replicated-ping patch that
does it as the ok hosts do a lot more rpc traffic.  

Only this one host fails, and I think it's due to it not running nfs v2 or
something else under portmap, it's only running:
cornholio src {511}$ rpcinfo -p box
   program vers proto   port
    100000    2   udp    111  portmapper
    100000    2   tcp    111  portmapper
    100003    3   udp   2049  nfs
    100003    3   tcp   2049  nfs
    100005    1   udp    635  mountd
    100005    1   tcp    635  mountd
    100005    2   udp    635  mountd
    100005    2   tcp    635  mountd
    100005    3   udp    635  mountd
    100005    3   tcp    635  mountd

Most servers (and filers) which work fine have more ports up, like nfs v2,
status, nlockmgr, etc.

We're trying to figure out if just enabling nfs v2 support, or something else
simple will help in the short term.. I'd rather not update the kernel and
automount daemon on 800+ hosts for one path. :)  Though I want to get them all
updated eventually where I can.

I attached ethereal caps of a successful host vs a failed host... the failed
host does getport call for nfs v3, talks to 2049, does an nfs v3 null call..
more nfsd port talk, getport call for nfs v2, then quits.

-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Stewie Griffin: Forecast for tomorrow; A few sprinkles of genius with a chance of 
doom.  ==> Family Guy
