From: Tom Georgoulias <tom.georgoulias@freescale.com>
Subject: Re: mount fails because entry in multi-mount doesn't work
Date: Thu, 13 May 2004 13:32:42 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <40A3BF4A.8080901@freescale.com>
References: <40A38585.4050103@freescale.com>
	<Pine.LNX.4.58.0405132305230.13693@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405132305230.13693@donald.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs mailing list <autofs@linux.kernel.org>

raven@themaw.net wrote:

> Use the -nonstrict option on the autofs mount.

Any docs for this?  I didn't see anything in the man pages about 
nostrict and I wasn't able to get it to work, so I want to be sure I've 
done everything correctly.

[root@winston root]# /sbin/service autofs status
Configured Mount Points:
------------------------
/usr/sbin/automount --timeout=60 --debug /proj/tec yp auto.proj 
-rw,hard,intr,nosuid,nostrict rsize=32768,wsize=32768

<snipped>

Active Mount Points:
--------------------
/usr/sbin/automount --timeout=60 --debug /proj/tec yp auto.proj 
-rw,hard,intr,nosuid,nostrict rsize=32768,wsize=32768

<snipped>

[root@winston root]# cat /etc/auto.master
# /etc/auto.master
yp:auto_master
/home yp:auto.home
[root@winston root]# ypcat -k auto_master | grep auto.proj
/proj/tec auto.proj             -rw,hard,intr,nosuid,nostrict

-- 
Tom Georgoulias
POPI Classification
[x] General Business Information
[] Freescale Semiconductor Internal Use
[] Freescale Semiconductor Confidential Proprietary
