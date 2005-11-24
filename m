From: Ian Kent <raven@themaw.net>
Subject: Re: cryptsetup with automount
Date: Thu, 24 Nov 2005 23:41:13 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511242338350.2378@donald.themaw.net>
References: <4385CFB2.5070908@bppiac.hu>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4385CFB2.5070908@bppiac.hu>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Farkas Levente <lfarkas@bppiac.hu>
Cc: autofs@linux.kernel.org

On Thu, 24 Nov 2005, Farkas Levente wrote:

> hi,
> may be it seems to be offtopic, but first i have to describe the problem
> or just jump to the QUESTION.
> recently i try to use encrypted filesystem on linux. now i'd not like
> into the detail, but it seems currently the best solution is LUKS on
> dm-crypt (http://luks.endorphin.org/dm-crypt). the whole thing is well
> documented:
> http://www.flyn.org/easycrypto/easycrypto.html
> http://www.saout.de/tikiwiki/tiki-index.php?page=EncryptedDeviceUsingLUKS
> and working for block device and file container.
> the only problem you always need to be root:-(
> what i would like to do, setup everything as root (create luks partition
> is a file in this way eg):
> --------------------------------
> dd if=/dev/urandom of=/home/lfarkas/.private bs=1M count=2048
> losetup /dev/loop0 /home/lfarkas/.private
> cryptsetup luksFormat /dev/loop0
> cryptsetup luksOpen /dev/loop0 private
> mkfs.ext3 /dev/mapper/private
> mount /dev/mapper/private /home/lfarkas/private
> umount /home/lfarkas/private
> cryptsetup luksClose private
> losetup -d /dev/loop0
> --------------------------------
> and after then i'd like to allow user lfarkas to mount his own file and
> use it. ie:
> --------------------------------
> losetup /dev/loop0 /home/lfarkas/.private
> cryptsetup luksOpen /dev/loop0 private
> mount /dev/mapper/private /home/lfarkas/private
> umount /home/lfarkas/private
> cryptsetup luksClose private
> losetup -d /dev/loop0
> --------------------------------
> and here comes the problems:
> - losetup can used only by root,
> - cryptsetup luksOpen/luksClose can used only by root,
> - there is a modified mount at :
> http://people.redhat.com/kzak/util-linux-cryptsetup/
> which should have to allow this with:
> mount /home/lfarkas/.private /home/lfarkas/private -t ext3 -o crypt,loop
> it always give me:
> --------------------------------
> mount: wrong fs type, bad option, bad superblock on /dev/loop0,
>        missing codepage or other error
>        In some cases useful info is found in syslog - try
>        dmesg | tail  or so
> --------------------------------
> while at the and of dmesg:
> --------------------------------
> VFS: Can't find ext3 filesystem on dev loop0.
> --------------------------------
> 
> ================== QUESTION ====================
> so what comes into my mind, may be i can use autofs. can i define some
> scripts which are run:
> - before the mount
> - after the umount
> i can use program map and run losetup and cryptsetup luksOpen in it (can
> i do so?) and this run by the kernel so run as root. but how can i give
> the password of key file in this case? and is there any way to define
> post umount script?

Yes you could use a program mount to run the commands and then return a 
map entry for the mount.
 
There's no way have anything run after the mount.

Ian
