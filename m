From: Bill Shannon <bill.shannon@sun.com>
Subject: Ubuntu NFS automount problem
Date: Sat, 22 Nov 2008 18:27:48 -0800
Message-ID: <4928BFA4.2090805@sun.com>
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

I'm running Ubuntu 8.04 (Hardy Heron) on my desktop at home.
I have an OpenSolaris 2008.11 server and a Solaris 10 server.
Both servers export NFS filesystems.

On my Ubuntu desktop, the autmounter doesn't want to automount hierarchical
filesystems.  I first noticed this with /home, but /net doesn't work either.

My OpenSolaris server is named "nissan".  My Solaris server is named "nissan2".

# showmount -e nissan
Export list for nissan:
/backup                 (everyone)
/backup/download        (everyone)
/export/home/admin      (everyone)
/backup/pictures        (everyone)
/export/home/shannon    (everyone)
/export/home            (everyone)
/export/home/readerware (everyone)
/backup2                (everyone)
/export/home/opt        (everyone)
# showmount -e nissan2
Export list for nissan2:
/export/home (everyone)
/backup      (everyone)
/backup2     (everyone)
# cat /etc/auto.net
*	-rw,intr	&:/
# ls /net/nissan
ls: cannot access /net/nissan: No such file or directory
# ls /net/nissan2
ls: cannot access /net/nissan2: No such file or directory
# ls /home/nissan
admin  opt  readerware	shannon
# ls /home/nissan/shannon
# ls /home/nissan2/shannon
(lots of files)

Of course I have all those hierarchical exports on OpenSolaris because
of separate zfs filesystems.

Has anyone else seen this with the Ubuntu automounter?  Is this a known bug?
I've spent over an hour searching the web and I can't find an explanation
for this problem.

Thanks for any help!
