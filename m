From: Stef Bon <stef@bononline.nl>
Subject: Mount wrapper used at umount.
Date: Wed, 10 Nov 2010 09:30:31 +0100
Message-ID: <4CDA5827.7050801@bononline.nl>
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

  Hello,

I'm using a construction which offers easy, userfriendly and effective 
and powerfull access to various kinds of resources, like USB disks, 
CDroms woth media and SMB shares.

Look:

http://linux.bononline.nl/wiki/index.php/Changes_and_issues

and

http://linux.bononline.nl/projects/mount.md5key.new/



It uses a FUSE module (fuse-workspace-ll), autofs, udev, at, ConsoleKit 
and some other things like the usb.ids file.

Now the automounter is setup very easy like:

cat /etc/autofs/auto.md5key
*           -fstype=md5key :/&


This will launch mount.md5key, which is a wrapper. It calls the right 
mount command, like mount.ext2, mount.ntfs-3g and mount.cifs, depending 
on the kind of resource. I do not know you know about this feature 
(because md5key is not a real filesystem..) but it's great!!

This auto.md5key file is mapped to /mnt/mount.md5key/sbon/mount:

sbon [ /var/run/autofs ]$ cat mount.m5key.master
/mnt/mount.md5key/sbon/mount  /etc/autofs/auto.md5key MD5KEY_USER=sbon


The key is a unique md5 value, which identifies a resource. This md5sum 
is the index value of records in
/var/cache/mount.md5key/<md5sum>/config where config  looks like:


sbon [ /var/cache/mount.md5key/123c359b21d27c834a8c82d1f3ccbda3 ]$ cat 
config
RECORD_type=smb
RECORD_security=public
RECORD_creator=20.discover-smb-shares.sh
RECORD_resource_uri="smb://HPCLIENT/video/"
RECORD_dnsdomain=intern.bononline.tk
LOCAL_user=
SMB_workgroup=TESTGROUP
SMB_name=HPCLIENT
SMB_share=video
SMB_ip=192.168.0.11
SMB_auth_method=guest
SMB_credential_file=


The md5sum value is actually the md5sum of this config file.
THis looks complicated,and that's true, But no pain, no gain.

This construction is simular to GnomeVFS.

Now I would like that's it's possible that the umount.md5key wrapper is 
used at unmounting, simular like the mount.md5key is used at mounting. 
But now when unmounting the automounter looks at the
umount.<filesystem>, where filesystem is the filesystem is used.

Stef
