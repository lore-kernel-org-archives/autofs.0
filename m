From: Steve Thompson <smt@vgersoft.com>
Subject: Disabling bind mounts
Date: Wed, 7 Jul 2010 10:11:58 -0400 (EDT)
Message-ID: <alpine.LRH.0.9999.1007071010390.18053@firefly.vgersoft.com>
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


Is there any way to _disable_ bind mounts, always using the NFS stack? I 
need this for a drbd+heartbeat failover scenario.

TIA,
Steve
----------------------------------------------------------------------------
Steve Thompson                 E-mail:      smt AT vgersoft DOT com
Voyager Software LLC           Web:         http://www DOT vgersoft DOT com
39 Smugglers Path              VSW Support: support AT vgersoft DOT com
Ithaca, NY 14850
   "186,300 miles per second: it's not just a good idea, it's the law"
----------------------------------------------------------------------------
