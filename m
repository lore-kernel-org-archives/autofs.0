From: Gokdeniz Karadag <gokdeniz@cclub.metu.edu.tr>
Subject: autofs-ldap-nfs is slow because of mtab
Date: Wed, 17 Jan 2007 00:47:45 +0200
Message-ID: <45AD5611.3080405@cclub.metu.edu.tr>
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

Hello,

In my setup there are three automount mount points. They are all ldap maps. The 
nfs shares are on the same nfs server. nfs client and automount is on a debian 
system, nfs server is a solaris one.

The problem is, trying to mount a nonexisting directory fails immediately  with 
the message, "No such file or directory" in two of the shares. But the third 
share waits for 10-30 seconds before giving the error. The maps have 1, 9 and 
19 items respectively.

I have run strace on the different automount processes. The quick ones show a 
query to ldap server, then a reasonable amount of mtab stats & reads, then they 
  finish. The process for the slow mount point queries ldap, gets mount map, 
then for about 100000 times; opens mtab file, reads contents and then closes it.
the trace file is full of these;
open("/etc/mtab", O_RDONLY)             = 7
fstat64(7, {st_mode=S_IFREG|0644, st_size=1733, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 
0xa7afb000
read(7, "/dev/sda1 / ext3 rw,errors=remou"..., 4096) = 1733
close(7)


Any pointers to where should I look ?


-- 
Gokdeniz Karadag
