From: "jehan.procaccia" <jehan.procaccia@int-edu.eu>
Subject: hostname lookup failed: Operation not permitted
Date: Mon, 15 Oct 2007 12:06:46 +0200
Message-ID: <47133BB6.5010903@int-edu.eu>
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
To: autofs mailing list <autofs@linux.kernel.org>
Cc: "Eric. Doutreleau" <eric.doutreleau@int-evry.fr>

Hello,

I have several users that cannot automount their homdir . The logs says:

Oct 14 15:56:47 anaconda automount[10054]: create_udp_client: hostname 
lookup failed: Operation not permitted
Oct 14 15:56:47 anaconda automount[10054]: create_tcp_client: hostname 
lookup failed: Operation not permitted
Oct 14 15:56:47 anaconda automount[10054]: lookup_mount: exports lookup 
failed for .directory
Oct 14 16:01:19 anaconda automount[10054]: create_udp_client: hostname 
lookup failed: Operation not permitted
Oct 14 16:01:19 anaconda automount[10054]: create_tcp_client: hostname 
lookup failed: Operation not permitted
Oct 14 16:01:19 anaconda automount[10054]: lookup_mount: exports lookup 
failed for ipv4
Oct 14 16:01:19 anaconda automount[10054]: create_udp_client: hostname 
lookup failed: Operation not permitted
Oct 14 16:01:19 anaconda automount[10054]: create_tcp_client: hostname 
lookup failed: Operation not permitted

Any idea of what happens ?

PS: my system versions:
[root@anaconda log]# rpm -q autofs
autofs-5.0.1-27
[root@anaconda log]# cat /etc/redhat-release
Fedora release 7 (Moonshine)
[root@anaconda log]# uname -a
Linux anaconda.int-evry.fr 2.6.22.9-91.fc7 #1 SMP Thu Sep 27 23:10:59 
EDT 2007 i686 i686 i386 GNU/Linux

Nfs server:
$ uname -a
Linux cobra3.int-evry.fr 2.6.9-55.0.2.ELsmp #1 SMP Tue Jun 12 17:59:08 
EDT 2007 i686 i686 i386 GNU/Linux
[root@cobra3 /var/log]
$ cat /etc/redhat-release
Red Hat Enterprise Linux ES release 4 (Nahant Update 5)
