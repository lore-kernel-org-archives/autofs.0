From: Terrence Martin <tmartin@physics.ucsd.edu>
Subject: Is it normal for autofs to remount a file system more than once?
Date: Thu, 02 Sep 2004 14:48:57 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <41379549.2040305@physics.ucsd.edu>
Mime-Version: 1.0
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
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

Hi,

I am not sure if this is related to my NFS mount hanging problems, but I 
have noticed that autofs will often remount a file system multiple 
times.  Is this normal? I think I have pretty straight forward auto. 
files....

Terrence Martin
UCSD Physics

mount
automount(pid4293) on /home type autofs 
(rw,fd=5,pgrp=4293,minproto=2,maxproto=3)
192.168.20.3:/home/cdfcaf on /home/cdfcaf type nfs (rw,addr=192.168.20.3)
192.168.20.3:/home/cdfsoft on /home/cdfsoft type nfs (rw,addr=192.168.20.3)
192.168.10.5:/falcon/0/users on /home/users type nfs (rw,addr=192.168.10.5)
automount(pid12825) on /home type autofs 
(rw,fd=5,pgrp=12825,minproto=2,maxproto=3)
192.168.20.3:/home/cdfcaf on /home/cdfcaf type nfs (rw,addr=192.168.20.3)
automount(pid3625) on /home type autofs 
(rw,fd=5,pgrp=3625,minproto=2,maxproto=3)
automount(pid3656) on /netstor type autofs 
(rw,fd=5,pgrp=3656,minproto=2,maxproto=3)
automount(pid3684) on /afs type autofs 
(rw,fd=5,pgrp=3684,minproto=2,maxproto=3)
192.168.20.3:/home/cdfcaf on /home/cdfcaf type nfs (rw,addr=192.168.20.3)
192.168.20.3:/home/cdfsoft on /home/cdfsoft type nfs (rw,addr=192.168.20.3)
192.168.10.5:/falcon/0/users on /home/users type nfs (rw,addr=192.168.10.5)
frontend-3.local:/export/home/install on /home/install type nfs 
(rw,addr=192.168.21.1)
192.168.10.5:/falcon/0/afs/fnal.gov on /afs/fnal.gov type nfs 
(rw,addr=192.168.10.5)
192.168.10.5:/falcon/2 on /netstor/falcon0-2 type nfs (rw,addr=192.168.10.5)
192.168.10.5:/falcon/0/afs/cern.ch on /afs/cern.ch type nfs 
(rw,addr=192.168.10.5)

df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda1             14112620   3535196   9860528  27% /
/dev/hdb1             50394964   1222448  49172516   3% /state/data
/dev/hdb2            189967608 183507236   6460372  97% /state/dcache
none                   1030804         0   1030804   0% /dev/shm
192.168.20.3:/home/cdfcaf
                     101161396  34168568  66992828  34% /home/cdfcaf
192.168.20.3:/home/cdfsoft
                     101161396  34168568  66992828  34% /home/cdfsoft
192.168.10.5:/falcon/0/users
                     1463382364 618177588 845204776  43% /home/users
192.168.20.3:/home/cdfcaf
                     101161396  34168568  66992828  34% /home/cdfcaf
192.168.20.3:/home/cdfcaf
                     101161396  34168568  66992828  34% /home/cdfcaf
192.168.20.3:/home/cdfsoft
                     101161396  34168568  66992828  34% /home/cdfsoft
192.168.10.5:/falcon/0/users
                     1463382364 618177588 845204776  43% /home/users
frontend-3.local:/export/home/install
                      10080520   5781204   3787248  61% /home/install
192.168.10.5:/falcon/0/afs/fnal.gov
                     1463382364 618177588 845204776  43% /afs/fnal.gov
192.168.10.5:/falcon/2
                     1463382364 346259560 1117122804  24% /netstor/falcon0-2
192.168.10.5:/falcon/0/afs/cern.ch
                     1463382364 618177588 845204776  43% /afs/cern.ch

cat /etc/auto.master
# $411id: /etc/auto.master$
# Retrieved: 02-Sep-2004 21:42
# Master server: 192.168.21.1
# Last modified on master: 04-Aug-2004 04:04
# Encrypted file size: 490 bytes
#
# Owner: 0.0
# Name: etc.auto..master
# Mode: 0100644
/home auto.home --timeout 600
/netstor auto.net --timeout 600
/afs    auto.afs --timeout 600
/groot   auto.grid3      --timeout 600

# cat /etc/auto.net
# $411id: /etc/auto.net$
# Retrieved: 02-Sep-2004 21:42
# Master server: 192.168.21.1
# Last modified on master: 27-May-2004 07:23
# Encrypted file size: 490 bytes
#
# Owner: 0.0
# Name: etc.auto..net
# Mode: 0100644
data0   192.168.20.1:/raid0
falcon0-0    192.168.10.5:/falcon/0
falcon0-1    192.168.10.5:/falcon/1
falcon0-2    192.168.10.5:/falcon/2
