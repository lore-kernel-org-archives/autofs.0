From: kiran@serc.iisc.ernet.in
Subject: multi-mount not working on autofs-3.1.7-900.1
Date: Thu, 19 Aug 2010 22:28:19 +0530 (IST)
Message-ID: <17432.10.16.10.158.1282237099.squirrel@mail.serc.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: autofs@linux.kernel.org

Hi,

on SLES 9 having autofs-3.1.7-900.1

content of /etc/auto.master is :

/home1         /etc/auto/map.home1

content of /etc/auto/map.home1 is:

tt        /  -rw,soft,intr    10.XX.XX.XX:/local/scratch /point
-rw,soft,intr  10.XX.XX.XX:/local/scratch1


Both /local/scratch and /local/scratch1 are coming from same nfs server.

when i access /home1/tt, /local/scratch gets mounted, but when i access
/home1/tt/point it will not mount /local/scratch1.

But same setup works on RHEL4 version autofs-4.1.3-169
and  RHEL5 version autofs-5.0.1-0.rc2.88

multimount is it supported in autofs-3.1.7-900.1 ? if it not supported
what is work around?

Thanking you,
regards,
kiran



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
