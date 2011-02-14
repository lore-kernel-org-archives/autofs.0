From: Steve Thompson <smt@vgersoft.com>
Subject: Autofs hangs
Date: Mon, 14 Feb 2011 14:31:41 -0500 (EST)
Message-ID: <alpine.LRH.0.9999.1102141422310.25310@firefly.vgersoft.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

CentOS 5.5, 32- and 64-bit. Maps from LDAP. I upgraded recently (as part 
of a system-wide yum update) from autofs-5.0.1-0.rc2.143.el5_5.4 to 
autofs-5.0.1-0.rc2.143.el5_5.6, and ever since I have had a MASSIVE number 
of automount hangs (several per day across 170 systems). Nothing is 
logged, and the automount deamon is hung solid; only a SIGKILL and a 
restart can recover the daemon (and, if I wasn't already logged in, a 
power cycle is required - all accounts use automounted NFS home 
directories). Reading the Changelog, I see these changes:

- add mutex to serialize access to mount module handle in parse module
- dont check null cache on expire
- fix null cache race
- fix cache_init() on source re-read
- fix negative cache included map lookup

I don't know which of these to point the finger at, but I have also 
noticed many messages similar to:

automount<pid>]: update_negative_cache: key "<pid>" not found in map.

all of which are incorrect. Really need a fix for this asap - we're 
almost dead in the water.

-smt
