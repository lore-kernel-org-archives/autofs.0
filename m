From: "Philip Ong Jr." <pongjr@gmail.com>
Subject: 5.0.5 non-expiring mounts
Date: Tue, 08 Feb 2011 01:30:59 -0800
Message-ID: <4D510D53.7010507@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
	:subject:content-type:content-transfer-encoding;
	bh=7YhUd7ksf/LypgIMCzODihHrMUB+4Ms1D+0rcVe9l0Y=;
	b=cPLPqaKIuWhtd4piu2yUNz2lmoprIlrjaTFR7AffZGCUxf0MzPErPpcgHIpYn7mwVP
	MEzJO/aXDg4AbfOoCS/ISm1qqQg64HgVnkUnkplZotC81FkBY34uBREwCiyzNicxQKtQ
	KqJlmBZwkAgDajC5G/lyMy3nizvoiw0zTyTe0=
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

I've pulled down the 5.0.5 tree and all patches.

I've set the logging level to debug and can see messages of expiring 
mounts in /var/log/messages...but when I check /etc/mtab or /proc/mounts 
or df, i can still see them there. Any ideas if this is a known issue or 
if I can give more info than below?


Linux sc-sim-208-144 2.6.29.4 #8 SMP Tue May 25 14:00:33 PDT 2010 x86_64 
x86_64 x86_64 GNU/Linux
# automount -V

Linux automount version 5.0.5

Directories:
         config dir:     /etc/sysconfig
         maps dir:       /etc
         modules dir:    /usr/lib/autofs

Compile options:
   DISABLE_MOUNT_LOCKING ENABLE_IGNORE_BUSY_MOUNTS LIBXML2_WORKAROUND
