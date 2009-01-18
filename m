From: "Jonathan E. Brickman" <jeb@joshuacorps.org>
Subject: Autofs permissions incorrect
Date: Sun, 18 Jan 2009 16:54:15 -0600
Message-ID: <4973B317.2000803@joshuacorps.org>
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

Am trying to use autofs with SMB shares.  My auto.smb looks like:

MYDOCS 
-fstype=smbfs,username=xxx,password=xxx,uid=jeb,gid=users,rsize=34000,file_mode=0660,dir_mode=0770,nounix 
   ://192.168.0.101/MYDOCS
MYVID 
-fstype=smbfs,username=xxx,password=xxx,uid=jeb,gid=users,rsize=34000,file_mode=0660,dir_mode=0770,nounix 
   ://192.168.0.101/MYVID
MYPIX 
-fstype=smbfs,username=xxx,password=xxx,uid=jeb,gid=users,rsize=34000,file_mode=0660,dir_mode=0770,nounix 
   ://192.168.0.101/MYPIX
MYMUSIC 
-fstype=smbfs,username=xxx,password=xxx,uid=jeb,gid=users,rsize=34000,file_mode=0660,dir_mode=0770,nounix 
   ://192.168.0.101/MYMUSIC
0JEB 
-fstype=smbfs,username=xxx,password=xxx,uid=jeb,gid=users,rsize=34000,file_mode=0660,dir_mode=0770,nounix 
   ://192.168.0.101/0JEB

192.168.0.101 is an XP Home PC; I can mount all of the above using 
mount.cifs perfectly well.  But when I set up the above for autofs, the 
shares get permissioned wrong:

jeb@jebslinux /var/autofs/smb $ ls -l
total 0
dr-xr-x--- 1 jeb users 0 2009-01-06 21:07 MYDOCS
jeb@jebslinux /var/autofs/smb $ cd /var/autofs/smb
jeb@jebslinux /var/autofs/smb $ ls -l
total 0
dr-xr-x--- 1 jeb users 0 2009-01-06 21:07 MYDOCS
jeb@jebslinux /var/autofs/smb $ ls -l MYDOCS/Tracts
total 7508
-rw-rw---- 1 jeb users 3731841 2007-10-04 18:57 Signs to Heaven 
(darker).png
-rw-rw---- 1 jeb users 3945310 2007-10-04 18:57 Signs to Heaven
(original).png
-rw-rw---- 1 jeb users    2560 2007-10-04 18:57 Thumbs.db
jeb@jebslinux /var/autofs/smb $

In other words, the share gets set +rx-w, but when I cd to a directory 
one level into the share, it is correct.

What am I doing wrong?

J.E.B.
