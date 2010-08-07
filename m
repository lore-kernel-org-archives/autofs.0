From: M N KIRAN <kiranmn@yahoo.com>
Subject: multi-mount not working on autofs-3.1.7-900.1
Date: Sat, 7 Aug 2010 03:32:35 -0700 (PDT)
Message-ID: <517808.86831.qm@web35601.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024;
	t=1281177155; bh=r1sSMUwg8YeQMtlFsvfVqjOBCyC9Ti/gBY/91Xo0JSI=;
	h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
	b=ltisfXc6F0vOzNYnaZd/AarS5d64RGxdARUb4WZvNnPaJ/5uVsTQHhrYzqsC0bpbA2qiQbsjKAJI9FnchqWgDbCy3uuuSn4l1o6AHMItaP8/ex+z6jLGUVsJmH2Blu/vJcEwC1BqNnctlUJioy1VvlqIcvKpfvo21EOHK5dF7Kg=
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
To: autofs@linux.kernel.org

Hi,

on SLES 9 having autofs-3.1.7-900.1

content of /etc/auto.master is :

/home1         /etc/auto/map.home1

content of /etc/auto/map.home1 is:

tt        /  -rw,soft,intr    10.XX.XX.XX:/local/scratch /point -rw,soft,intr  10.XX.XX.XX:/local/scratch1


Both /local/scratch and /local/scratch1 are coming from same nfs server.

when i access /home1/tt, /local/scratch gets mounted, but when i access
/home1/tt/point it will not mount /local/scratch1.

But same setup works on RHEL4 version autofs-4.1.3-169
and  RHEL5 version autofs-5.0.1-0.rc2.88

multimount is it supported in autofs-3.1.7-900.1 ? if it not supported what is work around?

Thanking you,
regards,
kiran
