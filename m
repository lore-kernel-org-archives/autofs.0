From: Ian Kent <raven@themaw.net>
Subject: [ANNOUNCE] autofs 4.1.0 release
Date: Sun, 7 Dec 2003 22:39:31 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0312072233130.3128-100000@raven.themaw.net>
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

As usual the packages can be found at:

ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4

They are:

autofs-4.1.0.tar.[gz|bz2]

Changes:

1) Corrected master map processing in init script.
2) Backed out multi-mount patch in favour of using
   the nonstrict option.

autofs4-2.4-module-20031201.tar.[gz|bz2]

Changes:

1) Changed the readdir related routines yet again.
   I hope this is the last time.


-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
