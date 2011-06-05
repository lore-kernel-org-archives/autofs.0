From: Stef Bon <stef@bononline.nl>
Subject: bug doing simple stat call to mountpoint
Date: Sun, 05 Jun 2011 18:44:11 +0200
Message-ID: <4DEBB25B.3020509@bononline.nl>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

  Hi,

I'm using autofs 5.0.5, kernel 2.6.38.6.

In the construction I'm working on I got the following error:

stat /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
stat: cannot stat 
`/mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1': No such 
file or directory
sbon [ 
/tmp/mount.md5key/users/sbon/cache/0a8805e89f4cc6653185a4ec4335cca1 ]$ 
ls /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
<gives contents as expected>

The automounter does not call the mount command in the first case, and 
like it should in the second.

mount | grep 55ed
//SCLFS20091030/sbon on 
/mnt/mount.md5key/sbon/0/55ed21dee4bb9604117a013e57dc5690 type cifs (rw)


When then again the first command (=share is mounted):

stat /mnt/mount.md5key/sbon/0/55ed21dee4bb9604117a013e57dc5690
   File: `/mnt/mount.md5key/sbon/0/55ed21dee4bb9604117a013e57dc5690'
   Size: 0               Blocks: 0          IO Block: 16384  directory
Device: 19h/25d Inode: 77256       Links: 35
Access: (0755/drwxr-xr-x)  Uid: ( 4000/    sbon)   Gid: ( 3000/netgroup)
Access: 2011-06-05 18:06:06.000000000 +0200
Modify: 2011-06-05 18:03:00.000000000 +0200
Change: 2011-06-05 18:03:00.000000000 +0200



This not ok.

I've reinstalled autofs with the latest patches already, did not help.

Stef
