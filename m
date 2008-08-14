From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: broken mount
Date: Thu, 14 Aug 2008 18:58:41 +0200
Message-ID: <1218733121.10481.20.camel@vesuv.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: autofs@linux.kernel.org

Hi all,

I obviously  have a broken /etc/mtab locking. mount says there are 1280
mounts of this kind:

filesrv:/export/support/vol/adm/share on /tmp/autoMcOAUm type nfs4
filesrv:/export/support/vol/adm/share on /tmp/auto2pnUBs type nfs4
filesrv:/export/support/vol/adm/share on /tmp/autovVvZv2 type nfs4

consulting /proc/mounts, none(!) of them actually exist. 

I don't really know which other list better to contact for this, sorry :(.

The util-linux we use is version 2.12r from debian etch with the patch
from the autofs source already applied (it is supposed to
fix /etc/mtab-locking in mount, right?).

Our system is currently a bit of a mess, but since this is a prudiction
system we can't do much about it at the moment.

autofs is version 5.0.3, with all patches from kernel.org applied. Any
help?

-- 
Lukas
