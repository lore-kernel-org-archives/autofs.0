From: Ian Kent <raven@themaw.net>
Subject: RE: autofs scalability
Date: Thu, 4 Dec 2003 09:35:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0312040929220.7055-100000@wombat.indigo.net.au>
References: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6AB920CC10586340BE1674976E0A991DE22E18@slexch2.sugarland.unocal.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Ogden, Aaron A." <aogden@unocal.com>
Cc: autofs@linux.kernel.org


Hi Aaron,

Long time no hear.

Good to hear from you.

On Wed, 3 Dec 2003, Ogden, Aaron A. wrote:

>
> Hello all,
> I was reading through Joe Pranevich's "Wonderful World of Linux 2.6" and
> I came across this, I thought you might find it interesting. (source:
> http://kniggit.net/wwol26.html)  The "Network Filesystems" section makes
> for interesting reading as well.  If I am reading this correctly, the
> 'unnamed device' limit has been raised from 256 to 4096 in kernel 2.6,
> can anyone confirm this?  If this is the case the only barrier left to
> remove is the RPC port limitation of ~800 open ports.  If the
> connections were multiplexed such that all connections to a given server
> used the same port then 800 ports would stretch a lot farther than they
> do now...

Sorry to say that the code that limits the number of anonymous mounts
to 255 does in fact remain. At least it was last time I checked.

I have been studying the rpc/nfs code but it is fairly complex so I am
not able to work on either of the two thinks you mention yet, because of
it.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
