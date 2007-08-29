From: Simon Gao <gao@schrodinger.com>
Subject: Auto mounted file system has incomplete listing of
	directories
Date: Wed, 29 Aug 2007 11:36:59 -0700
Message-ID: <46D5BCCB.2050205@schrodinger.com>
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

Hi,

Just run into this strange problem. The file system does not list mount
point when do "df" and lists incomplete directories (ie, fewer than
actual number of directories and files).

I am seeing following errors logged:


Aug 28 13:37:32 host1 automount[2255]: rmdir_path: lstat of .app1 failed.
Aug 28 13:37:32 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.Z failed.
Aug 28 13:37:32 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.gz failed.
Aug 28 13:37:47 host1 automount[2255]: rmdir_path: lstat of .app1 failed.
Aug 28 13:37:47 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.Z failed.
Aug 28 13:37:47 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.gz failed.
Aug 28 13:38:38 host1 automount[2255]: rmdir_path: lstat of .app1 failed.
Aug 28 13:38:38 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.Z failed.
Aug 28 13:38:38 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.gz failed.
Aug 28 13:58:54 host1 automount[2255]: rmdir_path: lstat of .app1 failed.
Aug 28 13:58:54 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.Z failed.
Aug 28 13:58:54 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.gz failed.
Aug 28 14:12:57 host1 automount[2255]: rmdir_path: lstat of .app1 failed.
Aug 28 14:12:57 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.Z failed.
Aug 28 14:12:57 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.gz failed.
Aug 28 15:02:11 host1 automount[2255]: rmdir_path: lstat of .hidden failed.
Aug 28 15:02:34 host1 automount[2255]: rmdir_path: lstat of .app1 failed.
Aug 28 15:02:34 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.Z failed.
Aug 28 15:02:34 host1 automount[2255]: rmdir_path: lstat of
.app1-os.tar.gz failed.
Aug 28 15:39:29 host1 automount[2255]: rmdir_path: lstat of jc failed.
Aug 28 15:54:56 host1 automount[2255]: rmdir_path: lstat of jc failed.
Aug 28 16:07:10 host1 automount[2255]: rmdir_path: lstat of .hidden failed.
Aug 28 16:08:00 host1 automount[2255]: rmdir_path: lstat of .hidden failed.
Aug 28 16:29:33 host1 automount[2255]: rmdir_path: lstat of .hidden failed.
Aug 28 16:35:12 host1 automount[2255]: rmdir_path: lstat of .hidden failed.
Aug 28 16:36:25 host1 automount[2255]: rmdir_path: lstat of .hidden failed.


2.6.18-8.1.8.el5xen
autofs-5.0.1-0.rc2.43.0.2

Anyone has an idea what the problem is?

Simon
