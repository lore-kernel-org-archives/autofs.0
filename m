From: Jeff Moyer <jmoyer@redhat.com>
Subject: correct format for mounting cifs/smbfs shares
Date: Wed, 7 Sep 2005 10:10:35 -0400
Message-ID: <17182.62683.375367.892022@segfault.boston.redhat.com>
Reply-To: jmoyer@redhat.com
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

Hi,

I had a user report a bug as follows:

---
Description of problem:
automount does not understand //hostname in its config files, which is needed by mount.cifs and mount.smbfs
I found a "solution", but I don't like it:
use \/\/hostname in /etc/auto.misc file


Version-Release number of selected component (if applicable):
autofs-4.1.3-114
samba-client-3.0.14a-2.1.fc3.kde

How reproducible:
Always

Steps to Reproduce:
1. put following line in /etc/auto.misc file:
share  -fstype=cifs                                                                                                     //HOST/SHARE
(of course, I hope that you have host HOST with share SHARE and you can make
mount -t cifs //HOST/SHARE /misc/share)

2. ls /misc/share 
  

Actual Results:  in /var/log/messages:
automount[1624]: mount(generic): failed to mount  (type cifs) on /misc/share/HOST/share

Expected Results:  //HOST/SHARE mounted in /misc/share
;-)

Additional info:

Same results with -fstype=smb
---

I have no experience with this.  What is the expected configuration to get
this to work?

Thanks,

Jeff
