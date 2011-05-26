From: Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] FedFS file system client support
Date: Thu, 26 May 2011 12:39:01 -0400
Message-ID: <20110526163545.3676.52586.stgit@dali.1015granger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:sender:from:subject:to:date:message-id
	:user-agent:mime-version:content-type:content-transfer-encoding;
	bh=SoecP/CMDbVJKTHvGzl651xwAPr4XqoS8T3n8yi+ZSI=;
	b=qoVx4ARRKRmBETDI81yP5R2lEhpPAWQEWD59lDwfHvTTTiyZEWliAeHEz/UuEFoC1H
	/bA7uFaG1ER4Hvt/nrac3y1WXTKNL320eYd+ddTwEnSTInKKgIPFo7pCYwxBbBI/XE6R
	V3GpTm51gOO4pGkCwY4rRotpGg3w7S3y9+zMM=
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
To: fedfs-utils-devel@oss.oracle.com, autofs@linux.kernel.org

Hi-

The next release of fedfs-utils will provide all necessary components
for a Linux NFS client to participate in a FedFS domain as a file
system client.  This new utility is intended to be a part of the
upcoming release.

I'm interested in comments on this approach.  Ian had suggested a new
lookup module, but a program map looked simpler to prototype and has
the great advantage of no dependencies between fedfs-utils and autofs.
If program maps have some nasty problem that require the use of a
lookup module, we can take that next step.

---

Chuck Lever (1):
      mount: Add automounter program map for FedFS


 .gitignore                 |    1 
 INSTALL                    |   10 +-
 README                     |   14 ++-
 doc/man/Makefile.am        |    2 
 doc/man/fedfs-map-nfs4.8   |  154 ++++++++++++++++++++++++++++
 doc/man/fedfs.7            |    4 +
 src/mount/Makefile.am      |    5 +
 src/mount/fedfs-map-nfs4.c |  242 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 422 insertions(+), 10 deletions(-)
 create mode 100644 doc/man/fedfs-map-nfs4.8
 create mode 100644 src/mount/fedfs-map-nfs4.c

-- 
Chuck Lever
