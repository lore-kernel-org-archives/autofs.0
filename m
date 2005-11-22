From: Brian Long <brilong@cisco.com>
Subject: stat of /users/no-such-user takes 15 seconds
Date: Tue, 22 Nov 2005 09:39:18 -0500
Message-ID: <1132670358.4039.37.camel@brilong-lnx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I have an auto.master deployed to thousands of hosts and it looks like
this:

/misc   /etc/auto.misc          --timeout=60
/auto   /etc/auto.indirect      rsize=32768,wsize=32768,tcp
/users  auto_home               rw,hard,intr,rsize=32768,wsize=32768,tcp

As you can see, /users comes from NIS auto.home map.  In our case,
auto.home contains over 34,000 entries.  I've noticed in RHEL 3 U5 and
beyond (autofs-4.1.3-130), trying to stat (ls) /users/no-such-user takes
roughly 12-15 seconds.  In RHEL 3 U3 (autofs-4.1.3-12), it returns
immediately.  This is a regression in my opinion.

After looking at tcpdump data, it appears automounter is downloading the
entire auto.home map when it fails to lookup "no-such-user".  This
results in a > 700KB transfer from the NIS server  :(

In the older autofs version, it does NOT do this.  I have opened a Red
Hat issue tracker (82760), but in parallel I wanted to ask this list if
this is known behavior and if there is any way I can disable the
download of the entire auto.home map using /etc/sysconfig/autofs or
auto.master options to the automount program.

Thank you.

/Brian/

-- 
       Brian Long                      |         |           |
       IT Data Center Systems          |       .|||.       .|||.
       Cisco Linux Developer           |   ..:|||||||:...:|||||||:..
       Phone: (919) 392-7363           |   C i s c o   S y s t e m s
