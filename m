From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: autofs unmount don't work with symbolic links
Date: Mon, 1 Nov 2004 13:32:06 +0200
Message-ID: <200411011332.06171.vda@port.imtp.ilyichevsk.odessa.ua>
References: <1098779618.19050.61.camel@IAPonomarenko.isd.dp.ua>
	<200410302317.04738.vda@port.imtp.ilyichevsk.odessa.ua>
	<1099300553.19050.241.camel@IAPonomarenko.isd.dp.ua>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1099300553.19050.241.camel@IAPonomarenko.isd.dp.ua>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: apon@isd.dp.ua
Cc: autofs@linux.kernel.org

Please use "reply before quote" style.

On Monday 01 November 2004 11:15, Alexander Ponomarenko wrote:
> I use Debian Linux (testing) and version of automount there is
>         Linux automount version 4.0.0
> But I think this bug is not known and so is not fixed yet even in new
> versions (I didn't find any subject on this question in Internet).

I can confirm that bug is still there in 4.1.3:

# automount /mnt/auto

(/mnt is a symlink) does not expire mounts:

13:23:47 * Initializing
13:23:48 * Starting: automount -f -s -v --timeout 15 /mnt/auto program /root/bin/mapper.sh
13:23:48 starting automounter version 4.1.3, path = /mnt/auto, maptype = program, mapname = /root/bin/mapper.sh
13:23:48 using kernel protocol version 3.00
13:23:48 using timeout 15 seconds; freq 4 secs
13:23:59 attempting to mount entry /mnt/auto/hda2
13:23:59 >> /usr/bin/mount: illegal option -- s
13:24:16 expired /mnt/auto/hda2
13:24:44 expired /mnt/auto/hda2
13:25:04 expired /mnt/auto/hda2
13:25:20 expired /mnt/auto/hda2
13:25:36 expired /mnt/auto/hda2
13:25:52 expired /mnt/auto/hda2
13:26:08 expired /mnt/auto/hda2
13:26:24 expired /mnt/auto/hda2
13:26:40 expired /mnt/auto/hda2
13:26:56 expired /mnt/auto/hda2
13:27:12 expired /mnt/auto/hda2
13:27:28 expired /mnt/auto/hda2

OTOH,

# autolomunt /.local/mnt/auto

works fine:

13:22:34 attempting to mount entry /.local/mnt/auto/hda2
13:22:35 >> /usr/bin/mount: illegal option -- s
13:22:57 rm_unwanted: /.local/mnt/auto/hda2
13:22:57 expired /.local/mnt/auto/hda2
13:23:31 shut down, path = /.local/mnt/auto

("/usr/bin/mount: illegal option -- s" is irrelevant here)
--
vda
