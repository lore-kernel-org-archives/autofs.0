From: Todd Denniston <Todd.Denniston@ssa.crane.navy.mil>
Subject: Re: automount usb key (vfat and ntfs)
Date: Mon, 01 Dec 2008 15:19:47 -0500
Message-ID: <493446E3.7060708@ssa.crane.navy.mil>
References: <4aa525de0812010542k29530958r359ae01f1a514e58@mail.gmail.com>	<4933FD65.5060802@ssa.crane.navy.mil>
	<4aa525de0812010752k3fb5c3f2x213d35977b56e043@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4aa525de0812010752k3fb5c3f2x213d35977b56e043@mail.gmail.com>
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
To: Paolo Minazzi <paolo.minazzi@gmail.com>
Cc: autofs@linux.kernel.org

Paolo Minazzi wrote, On 12/01/2008 10:52 AM:
>> So, have you tried something like:
>> pen   -fstype=vfat,ntfs-3g        :/dev/sda1
>>
> 
> Thanks for your replay.
>>From the documentation I have read that the 2nd parameter to the last
> parameter are specific mount parameter, so it does not solve the
> problem.
> 
> For example
> pen   -fstype=vfat,gid=102,umask=002        :/dev/sda1
> 
> means do
> 
> mount -t vfat -o gid=102,umask=002 /dev/sda1 /media/pen
> 

darn.
next suggestion, which I only alluded to in the last email:
if ! grep -e "ntfs-3g" /etc/filesystems
then
	echo "perhaps do the following"
	echo "echo ntfs-3g >> /etc/filesystems"
	echo " and let autofs use auto for the fs type."
else
	echo "darn, even editing /etc/filesystems"
	echo "will not help."
fi

of course this assumes that the lack of an entry in /etc/filesystems means 
mount will not try that type, and that you can use the same gid umask set for 
both FS types.

-- 
Todd Denniston
Crane Division, Naval Surface Warfare Center (NSWC Crane)
Harnessing the Power of Technology for the Warfighter
