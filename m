From: Stef Bon <stef@bononline.nl>
Subject: Re: bug doing simple stat call to mountpoint
Date: Sun, 05 Jun 2011 19:26:15 +0200
Message-ID: <4DEBBC37.8020205@bononline.nl>
References: <4DEBB25B.3020509@bononline.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4DEBB25B.3020509@bononline.nl>
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

  On 06/05/2011 06:44 PM, Stef Bon wrote:
>  Hi,
>
> I'm using autofs 5.0.5, kernel 2.6.38.6.
>
> In the construction I'm working on I got the following error:
>
> stat /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
> stat: cannot stat 
> `/mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1': No such 
> file or directory
> sbon [ 
> /tmp/mount.md5key/users/sbon/cache/0a8805e89f4cc6653185a4ec4335cca1 ]$ 
> ls /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
> <gives contents as expected>
>
> The automounter does not call the mount command in the first case, and 
> like it should in the second.
>
> mount | grep 55ed
> //SCLFS20091030/sbon on 
> /mnt/mount.md5key/sbon/0/55ed21dee4bb9604117a013e57dc5690 type cifs (rw)
>

I'm sorry I'm mixing two mountpoints here:

mount | grep 0a88
//SCLFS20091030/ftp on 
/mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1 type cifs (rw)

and

stat /mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1
   File: `/mnt/mount.md5key/sbon/0/0a8805e89f4cc6653185a4ec4335cca1'
   Size: 0               Blocks: 0          IO Block: 16384  directory
Device: 18h/24d Inode: 2           Links: 692
Access: (0755/drwxr-xr-x)  Uid: ( 4024/    gast)   Gid: ( 3000/netgroup)
Access: 2011-06-05 18:36:16.283327100 +0200
Modify: 2011-05-08 23:30:59.245301800 +0200
Change: 2011-05-08 23:30:59.245301800 +0200

Stef
